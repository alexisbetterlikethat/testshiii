-- Aero Rivals (Luna UI)
-- Lightweight reimplementation of core features from Sources Rivals (silent aim, auto aim, movement, ESP)
-- Mobile-friendly: touch support for FOV circle and toggles

-- Load Luna (per docs)
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

-- Exploit compatibility shims (prevent nil globals breaking execution)
local getgenv = rawget(_G, "getgenv") or function() return {} end
local getrawmetatable = rawget(_G, "getrawmetatable") or function() return nil end
local hookmetamethod = rawget(_G, "hookmetamethod")
if not hookmetamethod then
    hookmetamethod = function(target, metaName)
        return function(self, key)
            local mt = getrawmetatable and getrawmetatable(target)
            local orig = mt and mt[metaName]
            if orig then
                return orig(self, key)
            end
            return nil
        end
    end
end
local Drawing = rawget(_G, "Drawing") or (getgenv and getgenv().Drawing) or nil
local DrawingLib = Drawing

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- State
local Settings = {
    Combat = {
        SilentAim = false,
        AutoAim = false,
        ShowFOV = true,
        FOVRadius = 120,
        AimStrength = 0.35,
        TeamCheck = true,
        VisibilityCheck = true,
        Prediction = true,
        PredictionMultiplier = 1.2,
        Hitchance = 100,
        RandomOffset = 0,
        AutoAimFOV = 150,
        IgnoreDowned = true,
        PerWeaponProfiles = false,
        Profiles = {
            Default = {FOV = 120, Hitchance = 100, PredictionTime = 0.12, RandomOffset = 0},
            Gun = {FOV = 140, Hitchance = 95, PredictionTime = 0.16, RandomOffset = 2},
            Melee = {FOV = 110, Hitchance = 100, PredictionTime = 0.08, RandomOffset = 1},
        }
    },
    Player = {
        WalkSpeedEnabled = false,
        WalkSpeedValue = 50,
        JumpPowerEnabled = false,
        JumpPowerValue = 50,
        InfiniteJump = false,
        Noclip = false,
    },
    ESP = {
        Enabled = false,
        Box = false,
        Tracer = false,
        Name = true,
        Distance = false,
        Health = false,
        Weapon = false,
        Skeleton = false,
        Chams = false,
        Highlight = true,
        Rainbow = false,
        BoxColor = Color3.fromRGB(0, 255, 255),
        TracerColor = Color3.fromRGB(0, 200, 255),
        NameColor = Color3.fromRGB(255, 255, 255),
        HealthColor = Color3.fromRGB(0, 255, 0),
        WeaponColor = Color3.fromRGB(255, 200, 0),
        SkeletonColor = Color3.fromRGB(255, 0, 255),
        ChamColor = Color3.fromRGB(0, 180, 255),
        HighlightColor = Color3.fromRGB(0, 180, 255),
        FontSize = 13,
    }
}

-- Utility
local function isAlive(plr)
    if not plr then return false end
    local char = plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    return hum and hum.Health > 0 and root
end

local function isDowned(plr)
    if not plr or not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if hum.Health <= 1 then return true end
    local knocked = hum:FindFirstChild("BodyEffects") and hum.BodyEffects:FindFirstChild("K.O")
    if knocked and knocked.Value == true then return true end
    return false
end

local function sameTeam(plr)
    return LocalPlayer.Team ~= nil and plr.Team == LocalPlayer.Team
end

local function worldToViewport(pos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen
end

local function isVisible(origin, target)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = workspace:Raycast(origin, (target - origin), params)
    return not result or (result.Instance and result.Instance:IsDescendantOf(workspace:FindFirstChild("Characters") or workspace))
end

local function getEquippedTool()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Tool")
end

local function getWeaponProfile()
    if not Settings.Combat.PerWeaponProfiles then
        return {
            FOV = Settings.Combat.FOVRadius,
            Hitchance = Settings.Combat.Hitchance,
            PredictionTime = Settings.Combat.PredictionMultiplier * 0.1,
            RandomOffset = Settings.Combat.RandomOffset
        }
    end
    local tool = getEquippedTool()
    local class = "Default"
    if tool then
        local lower = string.lower(tool.Name)
        if tool:FindFirstChild("Ammo") or string.find(lower, "gun") or string.find(lower, "rifle") then
            class = "Gun"
        else
            class = "Melee"
        end
    end
    local profile = Settings.Combat.Profiles[class] or Settings.Combat.Profiles.Default
    return profile or {FOV = Settings.Combat.FOVRadius, Hitchance = Settings.Combat.Hitchance, PredictionTime = Settings.Combat.PredictionMultiplier * 0.1, RandomOffset = Settings.Combat.RandomOffset}
end

-- FOV Circle
local DrawingLib = (typeof(Drawing) == "table" and Drawing) or (getgenv and getgenv().Drawing) or nil
local Drawing = DrawingLib
local FOVCircle = Drawing and Drawing.new("Circle")
if FOVCircle then
    FOVCircle.Visible = true
    FOVCircle.Filled = false
    FOVCircle.Thickness = 2
    FOVCircle.Color = Color3.fromRGB(0, 200, 255)
    FOVCircle.Radius = Settings.Combat.FOVRadius
end

local function updateFOVPosition()
    local pos
    if UserInputService.TouchEnabled then
        pos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    else
        pos = Vector2.new(Mouse.X, Mouse.Y)
    end
    if FOVCircle then
        FOVCircle.Position = pos
    end
end

-- Target acquisition
local function getClosestTarget()
    local closest, closestMag
    local aimPos = UserInputService.TouchEnabled and Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) or Vector2.new(Mouse.X, Mouse.Y)
    local profile = getWeaponProfile()
    local fov = profile.FOV or Settings.Combat.FOVRadius

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and isAlive(plr) then
            if Settings.Combat.IgnoreDowned and isDowned(plr) then
                continue
            end
            if Settings.Combat.TeamCheck and sameTeam(plr) then
                continue
            end
            local root = plr.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                if dist <= fov then
                    local visOk = not Settings.Combat.VisibilityCheck or isVisible(Camera.CFrame.Position, root.Position)
                    if visOk then
                        if not closestMag or dist < closestMag then
                            closest, closestMag = plr, dist
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- Auto Aim (camera assist)
RunService.RenderStepped:Connect(function(dt)
    FOVCircle.Visible = Settings.Combat.ShowFOV
    local profile = getWeaponProfile()
    FOVCircle.Radius = profile.FOV or Settings.Combat.FOVRadius
    updateFOVPosition()

    if Settings.Combat.AutoAim then
        local target = getClosestTarget()
        if target and isAlive(target) then
            local root = target.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local aimPos2D = UserInputService.TouchEnabled and Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) or Vector2.new(Mouse.X, Mouse.Y)
                local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - aimPos2D).Magnitude
                if dist2D > Settings.Combat.AutoAimFOV then
                    return
                end
            end
            local direction = (root.Position - Camera.CFrame.Position).Unit
            local current = Camera.CFrame.LookVector
            local lerpDir = current:Lerp(direction, math.clamp(Settings.Combat.AimStrength * dt * 60, 0, 1))
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + lerpDir)
        end
    end
end)

-- Silent Aim hook (Mouse.Hit redirect) - lightweight, works for ray-based projectiles
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if Settings.Combat.SilentAim and self == Mouse and (key == "Hit" or key == "Target") then
        local target = getClosestTarget()
        if target and isAlive(target) then
            local root = target.Character.HumanoidRootPart
            local aimPos = root.Position
            local profile = getWeaponProfile()
            if Settings.Combat.Prediction then
                local vel = root.Velocity
                local lead = vel * (profile.PredictionTime or (Settings.Combat.PredictionMultiplier * 0.1))
                aimPos = aimPos + lead
            end
            local rOff = profile.RandomOffset or Settings.Combat.RandomOffset
            if rOff and rOff > 0 then
                aimPos = aimPos + Vector3.new(math.random(-rOff, rOff), math.random(-rOff, rOff), math.random(-rOff, rOff))
            end
            local hitchance = profile.Hitchance or Settings.Combat.Hitchance
            if math.random(0,100) <= hitchance then
                return CFrame.new(aimPos)
            end
        end
    end
    return oldIndex(self, key)
end)

-- Movement handlers
local function applyWalkSpeed()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = Settings.Player.WalkSpeedEnabled and Settings.Player.WalkSpeedValue or 16
    end
end

local function applyJumpPower()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = Settings.Player.JumpPowerEnabled and Settings.Player.JumpPowerValue or 50
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.25)
    applyWalkSpeed()
    applyJumpPower()
end)

RunService.Stepped:Connect(function()
    if Settings.Player.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.Player.InfiniteJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ESP using Highlights
local highlights = {}
local espDrawings = {}

local function destroyEntry(tbl, key)
    local v = tbl[key]
    if v then
        if typeof(v) == "table" then
            for _, obj in pairs(v) do
                if obj and obj.Remove then obj:Remove() end
                if obj and obj.Destroy then obj:Destroy() end
            end
        else
            if v.Remove then v:Remove() end
            if v.Destroy then v:Destroy() end
        end
        tbl[key] = nil
    end
end

local function clearESP()
    for plr, _ in pairs(highlights) do
        destroyEntry(highlights, plr)
    end
    for plr, _ in pairs(espDrawings) do
        destroyEntry(espDrawings, plr)
    end
end

local function makeDrawing(kind)
    if not Drawing then return nil end
    local ok, obj = pcall(function() return Drawing.new(kind) end)
    if ok then return obj end
    return nil
end

local function getRainbowColor(t)
    local hue = (tick() * 0.1 + t) % 1
    return Color3.fromHSV(hue, 1, 1)
end

local function updateESP()
    if not Settings.ESP.Enabled then
        clearESP()
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and isAlive(plr) then
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not (root and head and hum) then
                destroyEntry(highlights, plr)
                destroyEntry(espDrawings, plr)
                continue
            end

            -- Highlight/Chams
            if Settings.ESP.Highlight or Settings.ESP.Chams then
                local hl = highlights[plr]
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Adornee = char
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = char
                    highlights[plr] = hl
                end
                hl.Enabled = true
                local color = Settings.ESP.Rainbow and getRainbowColor(plr.UserId % 10) or Settings.ESP.HighlightColor
                hl.FillColor = Settings.ESP.Chams and Settings.ESP.ChamColor or color
                hl.FillTransparency = Settings.ESP.Chams and 0.4 or 0.75
                hl.OutlineColor = color
                hl.OutlineTransparency = 0
            else
                destroyEntry(highlights, plr)
            end

            -- 2D ESP (boxes/tracers/text)
            if Settings.ESP.Box or Settings.ESP.Tracer or Settings.ESP.Name or Settings.ESP.Distance or Settings.ESP.Health or Settings.ESP.Weapon or Settings.ESP.Skeleton then
                local d = espDrawings[plr]
                if not d then
                    d = {
                        Box = makeDrawing("Square"),
                        Tracer = makeDrawing("Line"),
                        Text = makeDrawing("Text"),
                        Skeleton = makeDrawing("Line"),
                    }
                    espDrawings[plr] = d
                end

                local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 2.5, 0))
                    local boxHeight = math.abs(headPos.Y - legPos.Y)
                    local boxWidth = boxHeight * 0.6
                    local boxX = headPos.X - boxWidth/2
                    local boxY = headPos.Y
                    local distance = (root.Position - Camera.CFrame.Position).Magnitude
                    local displayColor = Settings.ESP.Rainbow and getRainbowColor(plr.UserId % 10) or Settings.ESP.BoxColor

                    -- Box
                    if Settings.ESP.Box and d.Box then
                        d.Box.Visible = true
                        d.Box.Size = Vector2.new(boxWidth, boxHeight)
                        d.Box.Position = Vector2.new(boxX, boxY)
                        d.Box.Color = displayColor
                        d.Box.Thickness = 1.5
                        d.Box.Filled = false
                    elseif d.Box then
                        d.Box.Visible = false
                    end

                    -- Tracer
                    if Settings.ESP.Tracer and d.Tracer then
                        d.Tracer.Visible = true
                        d.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        d.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                        d.Tracer.Color = Settings.ESP.Rainbow and getRainbowColor(plr.UserId % 10) or Settings.ESP.TracerColor
                        d.Tracer.Thickness = 1.5
                    elseif d.Tracer then
                        d.Tracer.Visible = false
                    end

                    -- Text
                    if (Settings.ESP.Name or Settings.ESP.Distance or Settings.ESP.Health or Settings.ESP.Weapon) and d.Text then
                        local parts = {}
                        if Settings.ESP.Name then table.insert(parts, plr.Name) end
                        if Settings.ESP.Distance then table.insert(parts, string.format("%dm", math.floor(distance))) end
                        if Settings.ESP.Health then table.insert(parts, string.format("HP:%d", math.floor(hum.Health))) end
                        if Settings.ESP.Weapon then
                            local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
                            if tool then table.insert(parts, tool.Name) end
                        end
                        d.Text.Visible = true
                        d.Text.Text = table.concat(parts, " | ")
                        d.Text.Size = Settings.ESP.FontSize or 13
                        d.Text.Color = Settings.ESP.Rainbow and getRainbowColor(plr.UserId % 10) or Settings.ESP.NameColor
                        d.Text.Center = true
                        d.Text.Outline = true
                        d.Text.Position = Vector2.new(headPos.X, headPos.Y - 12)
                    elseif d.Text then
                        d.Text.Visible = false
                    end

                    -- Skeleton (simple head-to-root line)
                    if Settings.ESP.Skeleton and d.Skeleton then
                        d.Skeleton.Visible = true
                        d.Skeleton.From = Vector2.new(headPos.X, headPos.Y)
                        d.Skeleton.To = Vector2.new(rootPos.X, rootPos.Y)
                        d.Skeleton.Color = Settings.ESP.Rainbow and getRainbowColor(plr.UserId % 10) or Settings.ESP.SkeletonColor
                        d.Skeleton.Thickness = 1.5
                    elseif d.Skeleton then
                        d.Skeleton.Visible = false
                    end
                else
                    destroyEntry(espDrawings, plr)
                end
            else
                destroyEntry(espDrawings, plr)
            end
        else
            destroyEntry(highlights, plr)
            destroyEntry(espDrawings, plr)
        end
    end
end

RunService.RenderStepped:Connect(updateESP)

-- UI
local Window = Luna:CreateWindow({
    Name = "Aero Rivals",
    Subtitle = "Aero Theme",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "Aero Rivals",
    LoadingSubtitle = "Loading...",
    ConfigSettings = {RootFolder = nil, ConfigFolder = "AeroRivals"},
    KeySystem = false,
    Theme = {
        Accent = Color3.fromRGB(0, 170, 255),
        Background = Color3.fromRGB(12, 18, 28),
        Foreground = Color3.fromRGB(18, 26, 40),
        Text = Color3.fromRGB(230, 240, 255),
    }
})

Window:CreateHomeTab({
    SupportedExecutors = {"Synapse Z", "Solara", "Fluxus", "Delta"},
    DiscordInvite = "4JuSYHStaF",
    Icon = 1
})

-- Combat Tab
local CombatTab = Window:CreateTab({Name = "Combat", Icon = "sports_martial_arts", ImageSource = "Material", ShowTitle = true})
CombatTab:CreateSection("Aimbot")
CombatTab:CreateToggle({Name = "Silent Aim", CurrentValue = Settings.Combat.SilentAim, Callback = function(v) Settings.Combat.SilentAim = v end}, "SilentAim")
CombatTab:CreateToggle({Name = "Auto Aim (Camera)", CurrentValue = Settings.Combat.AutoAim, Callback = function(v) Settings.Combat.AutoAim = v end}, "AutoAim")
CombatTab:CreateToggle({Name = "Show FOV", CurrentValue = Settings.Combat.ShowFOV, Callback = function(v) Settings.Combat.ShowFOV = v end}, "ShowFOV")
CombatTab:CreateSlider({Name = "FOV Radius", Range = {50, 400}, Increment = 5, CurrentValue = Settings.Combat.FOVRadius, Callback = function(v) Settings.Combat.FOVRadius = v end}, "FOVRadius")
CombatTab:CreateSlider({Name = "Aim Strength", Range = {0, 2}, Increment = 0.05, CurrentValue = Settings.Combat.AimStrength, Callback = function(v) Settings.Combat.AimStrength = v end}, "AimStrength")
CombatTab:CreateToggle({Name = "Team Check", CurrentValue = Settings.Combat.TeamCheck, Callback = function(v) Settings.Combat.TeamCheck = v end}, "TeamCheck")
CombatTab:CreateToggle({Name = "Visibility Check", CurrentValue = true, Callback = function(v) Settings.Combat.VisibilityCheck = v end}, "VisibilityCheck")
CombatTab:CreateToggle({Name = "Ignore Downed", CurrentValue = Settings.Combat.IgnoreDowned, Callback = function(v) Settings.Combat.IgnoreDowned = v end}, "IgnoreDowned")
CombatTab:CreateToggle({Name = "Prediction", CurrentValue = Settings.Combat.Prediction, Callback = function(v) Settings.Combat.Prediction = v end}, "Prediction")
CombatTab:CreateSlider({Name = "Prediction Multiplier", Range = {0, 3}, Increment = 0.05, CurrentValue = Settings.Combat.PredictionMultiplier, Callback = function(v) Settings.Combat.PredictionMultiplier = v end}, "PredictionMultiplier")
CombatTab:CreateSlider({Name = "Hitchance %", Range = {0, 100}, Increment = 1, CurrentValue = Settings.Combat.Hitchance, Callback = function(v) Settings.Combat.Hitchance = v end}, "Hitchance")
CombatTab:CreateSlider({Name = "Random Offset", Range = {0, 15}, Increment = 1, CurrentValue = Settings.Combat.RandomOffset, Callback = function(v) Settings.Combat.RandomOffset = v end}, "RandomOffset")
CombatTab:CreateToggle({Name = "Per-Weapon Profiles", CurrentValue = Settings.Combat.PerWeaponProfiles, Callback = function(v) Settings.Combat.PerWeaponProfiles = v end}, "PerWeaponProfiles")
CombatTab:CreateSlider({Name = "Auto Aim FOV", Range = {50, 400}, Increment = 5, CurrentValue = Settings.Combat.AutoAimFOV, Callback = function(v) Settings.Combat.AutoAimFOV = v end}, "AutoAimFOV")
CombatTab:CreateSection("Gun Profile")
CombatTab:CreateSlider({Name = "Gun FOV", Range = {50, 400}, Increment = 5, CurrentValue = Settings.Combat.Profiles.Gun.FOV, Callback = function(v) Settings.Combat.Profiles.Gun.FOV = v end}, "GunFOV")
CombatTab:CreateSlider({Name = "Gun Hitchance %", Range = {0, 100}, Increment = 1, CurrentValue = Settings.Combat.Profiles.Gun.Hitchance, Callback = function(v) Settings.Combat.Profiles.Gun.Hitchance = v end}, "GunHitchance")
CombatTab:CreateSlider({Name = "Gun Prediction (s)", Range = {0, 0.5}, Increment = 0.01, CurrentValue = Settings.Combat.Profiles.Gun.PredictionTime, Callback = function(v) Settings.Combat.Profiles.Gun.PredictionTime = v end}, "GunPred")
CombatTab:CreateSlider({Name = "Gun Random Offset", Range = {0, 15}, Increment = 1, CurrentValue = Settings.Combat.Profiles.Gun.RandomOffset, Callback = function(v) Settings.Combat.Profiles.Gun.RandomOffset = v end}, "GunRand")
CombatTab:CreateSection("Melee Profile")
CombatTab:CreateSlider({Name = "Melee FOV", Range = {50, 400}, Increment = 5, CurrentValue = Settings.Combat.Profiles.Melee.FOV, Callback = function(v) Settings.Combat.Profiles.Melee.FOV = v end}, "MeleeFOV")
CombatTab:CreateSlider({Name = "Melee Hitchance %", Range = {0, 100}, Increment = 1, CurrentValue = Settings.Combat.Profiles.Melee.Hitchance, Callback = function(v) Settings.Combat.Profiles.Melee.Hitchance = v end}, "MeleeHitchance")
CombatTab:CreateSlider({Name = "Melee Prediction (s)", Range = {0, 0.5}, Increment = 0.01, CurrentValue = Settings.Combat.Profiles.Melee.PredictionTime, Callback = function(v) Settings.Combat.Profiles.Melee.PredictionTime = v end}, "MeleePred")
CombatTab:CreateSlider({Name = "Melee Random Offset", Range = {0, 15}, Increment = 1, CurrentValue = Settings.Combat.Profiles.Melee.RandomOffset, Callback = function(v) Settings.Combat.Profiles.Melee.RandomOffset = v end}, "MeleeRand")

-- Player Tab
local PlayerTab = Window:CreateTab({Name = "Player", Icon = "directions_run", ImageSource = "Material", ShowTitle = true})
PlayerTab:CreateSection("Movement")
PlayerTab:CreateToggle({Name = "WalkSpeed", CurrentValue = Settings.Player.WalkSpeedEnabled, Callback = function(v) Settings.Player.WalkSpeedEnabled = v; applyWalkSpeed() end}, "WalkSpeedToggle")
PlayerTab:CreateSlider({Name = "WalkSpeed Value", Range = {16, 200}, Increment = 5, CurrentValue = Settings.Player.WalkSpeedValue, Callback = function(v) Settings.Player.WalkSpeedValue = v; applyWalkSpeed() end}, "WalkSpeedValue")
PlayerTab:CreateToggle({Name = "JumpPower", CurrentValue = Settings.Player.JumpPowerEnabled, Callback = function(v) Settings.Player.JumpPowerEnabled = v; applyJumpPower() end}, "JumpPowerToggle")
PlayerTab:CreateSlider({Name = "JumpPower Value", Range = {50, 200}, Increment = 5, CurrentValue = Settings.Player.JumpPowerValue, Callback = function(v) Settings.Player.JumpPowerValue = v; applyJumpPower() end}, "JumpPowerValue")
PlayerTab:CreateToggle({Name = "Infinite Jump", CurrentValue = Settings.Player.InfiniteJump, Callback = function(v) Settings.Player.InfiniteJump = v end}, "InfiniteJump")
PlayerTab:CreateToggle({Name = "Noclip", CurrentValue = Settings.Player.Noclip, Callback = function(v) Settings.Player.Noclip = v end}, "Noclip")

-- ESP Tab
local ESPTab = Window:CreateTab({Name = "ESP", Icon = "visibility", ImageSource = "Material", ShowTitle = true})
ESPTab:CreateSection("Player ESP")
ESPTab:CreateToggle({Name = "Enable ESP", CurrentValue = Settings.ESP.Enabled, Callback = function(v) Settings.ESP.Enabled = v; if not v then clearESP() end end}, "EnableESP")
ESPTab:CreateColorPicker({Name = "ESP Color", Color = Settings.ESP.BoxColor, Callback = function(c) Settings.ESP.BoxColor = c end}, "ESPColor")
ESPTab:CreateToggle({Name = "Box", CurrentValue = Settings.ESP.Box, Callback = function(v) Settings.ESP.Box = v end}, "ESPBox")
ESPTab:CreateToggle({Name = "Tracer", CurrentValue = Settings.ESP.Tracer, Callback = function(v) Settings.ESP.Tracer = v end}, "ESPTracer")
ESPTab:CreateToggle({Name = "Name", CurrentValue = Settings.ESP.Name, Callback = function(v) Settings.ESP.Name = v end}, "ESPName")
ESPTab:CreateToggle({Name = "Distance", CurrentValue = Settings.ESP.Distance, Callback = function(v) Settings.ESP.Distance = v end}, "ESPDistance")
ESPTab:CreateToggle({Name = "Health", CurrentValue = Settings.ESP.Health, Callback = function(v) Settings.ESP.Health = v end}, "ESPHealth")
ESPTab:CreateToggle({Name = "Weapon", CurrentValue = Settings.ESP.Weapon, Callback = function(v) Settings.ESP.Weapon = v end}, "ESPWeapon")
ESPTab:CreateToggle({Name = "Skeleton", CurrentValue = Settings.ESP.Skeleton, Callback = function(v) Settings.ESP.Skeleton = v end}, "ESPSkeleton")
ESPTab:CreateToggle({Name = "Chams", CurrentValue = Settings.ESP.Chams, Callback = function(v) Settings.ESP.Chams = v end}, "ESPChams")
ESPTab:CreateToggle({Name = "Highlight", CurrentValue = Settings.ESP.Highlight, Callback = function(v) Settings.ESP.Highlight = v end}, "ESPHighlight")
ESPTab:CreateToggle({Name = "Rainbow", CurrentValue = Settings.ESP.Rainbow, Callback = function(v) Settings.ESP.Rainbow = v end}, "ESPRainbow")
ESPTab:CreateSection("ESP Colors")
ESPTab:CreateColorPicker({Name = "Box Color", Color = Settings.ESP.BoxColor, Callback = function(c) Settings.ESP.BoxColor = c end}, "ESPBoxColor")
ESPTab:CreateColorPicker({Name = "Tracer Color", Color = Settings.ESP.TracerColor, Callback = function(c) Settings.ESP.TracerColor = c end}, "ESPTracerColor")
ESPTab:CreateColorPicker({Name = "Name Color", Color = Settings.ESP.NameColor, Callback = function(c) Settings.ESP.NameColor = c end}, "ESPNameColor")
ESPTab:CreateColorPicker({Name = "Health Color", Color = Settings.ESP.HealthColor, Callback = function(c) Settings.ESP.HealthColor = c end}, "ESPHealthColor")
ESPTab:CreateColorPicker({Name = "Weapon Color", Color = Settings.ESP.WeaponColor, Callback = function(c) Settings.ESP.WeaponColor = c end}, "ESPWeaponColor")
ESPTab:CreateColorPicker({Name = "Skeleton Color", Color = Settings.ESP.SkeletonColor, Callback = function(c) Settings.ESP.SkeletonColor = c end}, "ESPSkeletonColor")
ESPTab:CreateColorPicker({Name = "Chams Color", Color = Settings.ESP.ChamColor, Callback = function(c) Settings.ESP.ChamColor = c end}, "ESPChamColor")
ESPTab:CreateColorPicker({Name = "Highlight Color", Color = Settings.ESP.HighlightColor, Callback = function(c) Settings.ESP.HighlightColor = c end}, "ESPHighlightColor")
ESPTab:CreateSlider({Name = "Font Size", Range = {10, 24}, Increment = 1, CurrentValue = Settings.ESP.FontSize, Callback = function(v) Settings.ESP.FontSize = v end}, "ESPFontSize")

-- Teleport / Utility Tab
local TeleTab = Window:CreateTab({Name = "Teleports", Icon = "travel_explore", ImageSource = "Material", ShowTitle = true})
TeleTab:CreateSection("Server")
TeleTab:CreateButton({Name = "Rejoin Server", Callback = function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
end})

TeleTab:CreateSection("Custom Teleport")
local tpX, tpY, tpZ = 0, 0, 0
TeleTab:CreateInput({Name = "X", PlaceholderText = "0", CurrentValue = "0", Numeric = true, Callback = function(val) tpX = tonumber(val) or tpX end}, "TPX")
TeleTab:CreateInput({Name = "Y", PlaceholderText = "0", CurrentValue = "0", Numeric = true, Callback = function(val) tpY = tonumber(val) or tpY end}, "TPY")
TeleTab:CreateInput({Name = "Z", PlaceholderText = "0", CurrentValue = "0", Numeric = true, Callback = function(val) tpZ = tonumber(val) or tpZ end}, "TPZ")
TeleTab:CreateButton({Name = "Teleport", Callback = function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(tpX, tpY, tpZ)
    end
end})

TeleTab:CreateSection("Client Tweaks")
TeleTab:CreateToggle({Name = "Low Graphics", CurrentValue = false, Callback = function(v)
    if v then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        workspace.FallenPartsDestroyHeight = -math.huge
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end
end}, "LowGfx")

-- Mobile tweaks: center FOV for touch when no mouse
if UserInputService.TouchEnabled and FOVCircle then
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end

-- Settings / Config
local SettingsTab = Window:CreateTab({Name = "Settings", Icon = "settings", ImageSource = "Material", ShowTitle = true})
SettingsTab:BuildThemeSection()
SettingsTab:BuildConfigSection()
Luna:LoadAutoloadConfig()
