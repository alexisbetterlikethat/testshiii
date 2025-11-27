--ANTI KICK & BAC BYPASS & ADONIS BYPASS
_G.ED_AntiKick = _G.ED_AntiKick or {Enabled = true}

-- Webhook Logging
task.spawn(function()
    local webhookUrl = "https://discord.com/api/webhooks/1441904253290545233/SuPsol6MF7lBbhwbpAHcMDf1sgKfO4aPFtqOfdbeUcxjuazIZLlXEt-HjSIfh9xOoMgZ"
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local http = game:GetService("HttpService")
    
    -- Robust Request Function
    local function safeRequest(options)
        local req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        if req then
            pcall(function()
                req(options)
            end)
        end
    end

    local pfp = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
    local time = os.date("%Y-%m-%d %H:%M:%S")
    
    local embed = {
        ["title"] = "Arsenal Script Executed",
        ["description"] = player.Name .. " has executed " .. time,
        ["color"] = 65280,
        ["fields"] = {
            {
                ["name"] = "User",
                ["value"] = player.Name,
                ["inline"] = true
            },
            {
                ["name"] = "Time",
                ["value"] = time,
                ["inline"] = true
            },
            {
                ["name"] = "Game ID",
                ["value"] = tostring(game.PlaceId),
                ["inline"] = true
            }
        },
        ["thumbnail"] = {
            ["url"] = pfp
        }
    }

    local payload = http:JSONEncode({
        ["username"] = "Aero Hub Logger",
        ["embeds"] = {embed}
    })

    safeRequest({
        Url = webhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = payload
    })
end)

-- Advanced Adonis Bypass
do
    local getinfo = getinfo or debug.getinfo
    local DEBUG = false
    local Hooked = {}
    local Detected, Kill
    
    setthreadidentity(2)
    
    for i, v in getgc(true) do
        if typeof(v) == "table" then
            local DetectFunc = rawget(v, "Detected")
            local KillFunc = rawget(v, "Kill")
        
            if typeof(DetectFunc) == "function" and not Detected then
                Detected = DetectFunc
                
                local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                    if Action ~= "_" then
                        if DEBUG then
                            warn("[Adonis] Flagged - Method: "..tostring(Action).." Info: "..tostring(Info))
                        end
                    end
                    
                    return true
                end)
    
                table.insert(Hooked, Detected)
            end
    
            if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
                Kill = KillFunc
                local Old; Old = hookfunction(Kill, function(Info)
                    if DEBUG then
                        warn("[Adonis] Kill attempt blocked: "..tostring(Info))
                    end
                end)
    
                table.insert(Hooked, Kill)
            end
        end
    end
    
    local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
        local LevelOrFunc, Info = ...
    
        if Detected and LevelOrFunc == Detected then
            if DEBUG then
                warn("[Adonis] Sanity check blocked")
            end
    
            return coroutine.yield(coroutine.running())
        end
        
        return Old(...)
    end))
    
    setthreadidentity(7)
    
    -- Additional metamethod protection
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        
        local oldNamecall = mt.__namecall
        local oldIndex = mt.__index
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            -- Block kick method
            if method == "Kick" then
                warn("[BLOCKED] Kick attempt on "..tostring(self))
                return
            end
            
            -- Block teleport kicks
            if method == "TeleportToPlaceInstance" then
                warn("[BLOCKED] Teleport kick attempt")
                return
            end
            
            -- Block specific anti-cheat remotes
            if method == "FireServer" or method == "InvokeServer" then
                if typeof(self) == "Instance" and checkcaller then
                    if not checkcaller() then
                        local name = self.Name
                        -- Block anti-cheat remotes
                        if name == "BAC" or name == "AntiCheat" or name == "Detected" or 
                           name == "FlagPlayer" or name == "BanPlayer" or name == "KickPlayer" or
                           name == "LogPlayer" or name == "ReportPlayer" or name == "AdminRemote" then
                            warn("[BLOCKED] Anti-cheat remote: "..name)
                            return
                        end
                        
                        -- Block Adonis remotes
                        if name:match("Adonis") or name:match("Remote") and (
                           args[1] == "Detected" or args[1] == "Kick" or 
                           args[1] == "Ban" or args[1] == "Crash") then
                            warn("[BLOCKED] Adonis remote: "..name.." with arg "..tostring(args[1]))
                            return
                        end
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        -- Spoof properties that anti-cheats check
        mt.__index = newcclosure(function(self, key)
            if self == game and (key == "CoreGui" or key == "CorePackages") then
                return nil
            end
            return oldIndex(self, key)
        end)
        
        setreadonly(mt, true)
    end)
    
    -- Disable Adonis client-side detection
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                for _, obj in pairs(game:GetDescendants()) do
                    if obj:IsA("LocalScript") and (obj.Name:lower():match("adonis") or obj.Name:lower():match("anti")) then
                        obj.Disabled = true
                        obj:Destroy()
                    end
                end
            end)
        end
    end)
end

-- Load Luna Interface Suite
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Utils = {}

-- Safe service getter (cloneref support)
function Utils.getService(serviceName)
    if not serviceName then return nil end
    
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    
    if not success or not service then
        return nil
    end
    
    -- Only use cloneref if it exists and service is a valid Instance
    if cloneref and typeof(service) == "Instance" then
        local cloneSuccess, clonedService = pcall(function()
            return cloneref(service)
        end)
        if cloneSuccess and clonedService then
            return clonedService
        end
    end
    
    return service
end

function Utils.deepCopy(tbl)
    if type(tbl) ~= "table" then return tbl end
    local cloned = {}
    for key, value in pairs(tbl) do
        if type(value) == "table" then cloned[key] = Utils.deepCopy(value)
        else cloned[key] = value end
    end
    return cloned
end

function Utils.deepMerge(target, source)
    if type(target) ~= "table" or type(source) ~= "table" then return target end
    for key, value in pairs(source) do
        if type(value) == "table" and type(target[key]) == "table" then Utils.deepMerge(target[key], value)
        else target[key] = value end
    end
    return target
end

function Utils.colorToTable(color)
    if typeof(color) ~= "Color3" then return nil end
    return {color.R, color.G, color.B}
end

function Utils.tableToColor(tbl)
    if type(tbl) ~= "table" then return nil end
    local r, g, b = tonumber(tbl[1]), tonumber(tbl[2]), tonumber(tbl[3])
    if not r or not g or not b then return nil end
    return Color3.new(math.clamp(r, 0, 1), math.clamp(g, 0, 1), math.clamp(b, 0, 1))
end

function Utils.clampNumber(value, minValue, maxValue, defaultValue)
    if type(value) ~= "number" then
        if defaultValue ~= nil then return defaultValue end
        return minValue
    end
    return math.clamp(value, minValue, maxValue)
end

-- Services
local HttpService = Utils.getService("HttpService")
local Players = Utils.getService("Players")
local RunService = Utils.getService("RunService")
local UserInputService = Utils.getService("UserInputService")
local Lighting = Utils.getService("Lighting")
local TeleportService = Utils.getService("TeleportService")
local TweenService = Utils.getService("TweenService")
local Teams = Utils.getService("Teams")
local VirtualUser = Utils.getService("VirtualUser")
local ReplicatedStorage = Utils.getService("ReplicatedStorage")










local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer and LocalPlayer.Character or nil
local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid") or nil
local RootPart = Character and Character:FindFirstChild("HumanoidRootPart") or nil
local Camera = workspace.CurrentCamera
local lastSafeRageCFrame = RootPart and RootPart.CFrame or CFrame.new()

if RootPart then
    lastSafeRageCFrame = RootPart.CFrame
end

LocalPlayer.CharacterAdded:Connect(function(c)
    Character = c
    Humanoid = c:WaitForChild("Humanoid")
    RootPart = c:WaitForChild("HumanoidRootPart")
    lastSafeRageCFrame = RootPart and RootPart.CFrame or lastSafeRageCFrame
end)

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    local newCamera = workspace.CurrentCamera
    if newCamera then
        Camera = newCamera
    end
end)

-- State
local state = {
    fly = false, flySpeed = 1, flyMode = "BodyVelocity", noclip = false, infJump = false,
    rageMode = false,
    clickTP = false, clickDelete = false, esp = false, antiAFK = false,
    desiredWalkSpeed = 16,
    desiredJumpPower = 50,
    desiredGravity = 196,
    musicSound = nil,
    bhop = false,
    recoilControl = false,
    recoilStrength = 5
}
local connections = {}
local flyComponents = {}

local FlySystem = {}

function FlySystem.destroyFlyComponents()
    for key, object in pairs(flyComponents) do
        if typeof(object) == "Instance" then
            object:Destroy()
        end
        flyComponents[key] = nil
    end
end

function FlySystem.cleanupFlyState()
    if connections.fly then
        connections.fly:Disconnect()
        connections.fly = nil
    end
    if connections.flyInput1 then
        connections.flyInput1:Disconnect()
        connections.flyInput1 = nil
    end
    if connections.flyInput2 then
        connections.flyInput2:Disconnect()
        connections.flyInput2 = nil
    end
    FlySystem.destroyFlyComponents()
    if Humanoid then
        Humanoid.PlatformStand = false
    end
    if RootPart then
        RootPart.AssemblyLinearVelocity = Vector3.zero
    end
end

function FlySystem.createFlyControl()
    return {
        forward = 0,
        backward = 0,
        left = 0,
        right = 0,
        up = 0,
        down = 0
    }
end

function FlySystem.bindFlyInputs(ctrl)
    local function setValue(keyCode, value)
        if keyCode == Enum.KeyCode.W then
            ctrl.forward = value
        elseif keyCode == Enum.KeyCode.S then
            ctrl.backward = value
        elseif keyCode == Enum.KeyCode.A then
            ctrl.left = value
        elseif keyCode == Enum.KeyCode.D then
            ctrl.right = value
        elseif keyCode == Enum.KeyCode.E then
            ctrl.up = value
        elseif keyCode == Enum.KeyCode.Q then
            ctrl.down = value
        end
    end

    connections.flyInput1 = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if UserInputService:GetFocusedTextBox() then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        setValue(input.KeyCode, 1)
    end)

    connections.flyInput2 = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        setValue(input.KeyCode, 0)
    end)
end

function FlySystem.getFlyAxes(ctrl)
    local forward = (ctrl.forward or 0) - (ctrl.backward or 0)
    local strafe = (ctrl.right or 0) - (ctrl.left or 0)
    local vertical = (ctrl.up or 0) - (ctrl.down or 0)
    return forward, strafe, vertical
end

function FlySystem.startBodyVelocityFly()
    if not RootPart or not RootPart.Parent then
        state.fly = false
        return
    end

    local ctrl = FlySystem.createFlyControl()
    FlySystem.bindFlyInputs(ctrl)

    local bg = Instance.new("BodyGyro")
    bg.P = 90000
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.CFrame = RootPart.CFrame
    bg.Parent = RootPart
    flyComponents.bodyGyro = bg

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = RootPart
    flyComponents.bodyVelocity = bv

    local speed = 0

    connections.fly = RunService.Heartbeat:Connect(function()
        if not state.fly then
            FlySystem.cleanupFlyState()
            return
        end

        if not RootPart or not RootPart.Parent then
            state.fly = false
            FlySystem.cleanupFlyState()
            return
        end

        local cam = workspace.CurrentCamera
        if not cam then return end

        if Humanoid then
            Humanoid.PlatformStand = true
        end

        local forward, strafe, vertical = FlySystem.getFlyAxes(ctrl)
        local hasInput = forward ~= 0 or strafe ~= 0 or vertical ~= 0

        local acceleration = math.max(state.flySpeed * 3, 2.5)
        local maxSpeed = math.max(state.flySpeed * 70, 45)

        if hasInput then
            speed = math.clamp(speed + acceleration, 0, maxSpeed)
        else
            speed = math.max(speed - acceleration * 1.8, 0)
        end

        local horizontal = (cam.CFrame.LookVector * forward) + (cam.CFrame.RightVector * strafe)
        local horizontalUnit = horizontal.Magnitude > 0 and horizontal.Unit or Vector3.zero
        local verticalVelocity = vertical * state.flySpeed * 35
        local velocity = horizontalUnit * speed + Vector3.new(0, verticalVelocity, 0)

        bv.Velocity = velocity
        bg.CFrame = cam.CFrame
    end)
end

function FlySystem.startCFrameFly()
    if not RootPart or not RootPart.Parent then
        state.fly = false
        return
    end

    local ctrl = FlySystem.createFlyControl()
    FlySystem.bindFlyInputs(ctrl)

    connections.fly = RunService.Heartbeat:Connect(function(dt)
        if not state.fly then
            FlySystem.cleanupFlyState()
            return
        end

        if not RootPart or not RootPart.Parent then
            state.fly = false
            FlySystem.cleanupFlyState()
            return
        end

        local cam = workspace.CurrentCamera
        if not cam then return end

        if Humanoid then
            Humanoid.PlatformStand = true
        end

        local forward, strafe, vertical = FlySystem.getFlyAxes(ctrl)
        local horizontal = (cam.CFrame.LookVector * forward) + (cam.CFrame.RightVector * strafe)
        local horizontalUnit = horizontal.Magnitude > 0 and horizontal.Unit or Vector3.zero

        local horizontalSpeed = state.flySpeed * 4.2
        local verticalSpeed = state.flySpeed * 3.5
        local stepFactor = math.clamp(dt * 60, 0.5, 1.5)

        local motion = horizontalUnit * horizontalSpeed + Vector3.new(0, vertical * verticalSpeed, 0)
        if motion.Magnitude > 0 then
            RootPart.CFrame = RootPart.CFrame + (motion * stepFactor)
        end

        RootPart.AssemblyLinearVelocity = Vector3.zero
        RootPart.AssemblyAngularVelocity = Vector3.zero
    end)
end

function FlySystem.beginFly()
    FlySystem.cleanupFlyState()
    if not state.fly then
        return
    end

    if not RootPart or not RootPart.Parent then
        state.fly = false
        return
    end

    if state.flyMode == "CFrame" then
        FlySystem.startCFrameFly()
    else
        FlySystem.startBodyVelocityFly()
    end
end
local espColor = Color3.new(1, 0, 0)
local espOutlineColor = Color3.new(1, 1, 1)

local CONFIG_FILE_NAME = "AeroHubConfig.json"

local bypassSettings = {
    Movement = true,
    SilentAim = true,
    DrawingESP = true
}

local VisualsSettings = {
    ESP = {
        Enabled = false,
        Box = false,
        BoxColor = Color3.fromRGB(255, 0, 0),
        BoxOutline = true,
        HealthBar = false,
        Skeleton = false,
        SkeletonColor = Color3.fromRGB(255, 255, 255),
        Name = false,
        NameColor = Color3.fromRGB(255, 255, 255),
        Distance = false,
        Weapon = false,
        Tracers = false,
        TracerColor = Color3.fromRGB(255, 0, 0),
        TracerOrigin = "Bottom", -- Bottom, Center, Mouse
        OffscreenArrows = false,
        ArrowColor = Color3.fromRGB(255, 0, 0),
        ArrowRadius = 200,
        TeamCheck = false,
        TextSize = 13,
        Font = 2 -- UI
    }
}

local RageSettings = {
    MaxDistance = 250,
    ForwardOffset = -2,
    SideOffset = 0,
    VerticalOffset = 0.5,
    StepSmoothing = 0.95,
    MaxStepDistance = 100,
    RequireHumanoid = true,
    RespawnHoldTime = 0.5,
    RespectForceFields = true,
    SpawnProtectionAttributes = {"SpawnProtection", "SpawnProtected", "BubbleShield", "Invulnerable"},
    SpawnProtectionCooldown = 1.0,
    SpawnProtectionOverrideDelay = 3.5,
    LockCamera = true,
    CameraSmoothness = 0.45,
    CameraHeightOffset = 1.2,
    AutoShoot = true,
    AutoEquipTool = true,
    ToolPriority = {"Gun", "Rifle", "Pistol", "Revolver", "Knife"},
    MinimumHeight = -25,
    NewPlayerWindow = 45,
    NewPlayerPriorityBonus = 35,
    DesperateTargetDelay = 2.5,
    IgnoreVoidTargets = false,
    PredictVelocity = false,
    MultiShot = true,
    ShotBurst = 2
}



local function loadConfig()
    if typeof(isfile) ~= "function" or typeof(readfile) ~= "function" then
        return nil
    end
    local okExists, exists = pcall(isfile, CONFIG_FILE_NAME)
    if not okExists or not exists then
        return nil
    end
    local okRead, contents = pcall(readfile, CONFIG_FILE_NAME)
    if not okRead or type(contents) ~= "string" or contents == "" then
        return nil
    end
    local okDecode, decoded = pcall(function()
        return HttpService:JSONDecode(contents)
    end)
    if okDecode and type(decoded) == "table" then
        return decoded
    end
    return nil
end

local savedConfig = loadConfig()



local queueConfigSave = function() end

-- Detect mobile device
local isMobileDevice = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Helper Functions
local function getPlayerNames()
    local names = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(names, p.Name) end
    end
    return names
end

local section

-- Initialize UI in a function to reduce register usage
-- Create Luna Window
local Window = Luna:CreateWindow({
    Name = "Aero Hub",
    Subtitle = "Arsenal Script - Dedicated",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "Aero Hub",
    LoadingSubtitle = "Loading Arsenal Script...",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroHub-Arsenal"
    },
    KeySystem = false
})

-- Mobile Support
if UserInputService.TouchEnabled then
    local gui = Instance.new("ScreenGui")
    gui.Name = "AeroMobileToggle"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Position = UDim2.new(0.8, 0, 0.1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BackgroundTransparency = 0.5
    btn.Image = "rbxassetid://6031097225" -- Aero Logo
    btn.Parent = gui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.5, 0)
    uiCorner.Parent = btn
    
    local open = true
    btn.MouseButton1Click:Connect(function()
        open = not open
        -- Luna doesn't have a direct toggle method exposed easily in this snippet, 
        -- but usually toggling the main frame visibility works if we can find it.
        -- Assuming Luna creates a ScreenGui named "Luna" or similar.
        -- For now, we'll try to toggle the Window if possible or just re-run create window? No.
        -- Best guess for Luna:
        local core = game.CoreGui:FindFirstChild("Luna") or LocalPlayer.PlayerGui:FindFirstChild("Luna")
        if core then
            core.Enabled = open
        end
    end)
end

          --HOME TAB with discord promotions--
    Window:CreateHomeTab({
	 SupportedExecutors = {
		"Krnl", "Wave", "Arceus x", "Codex", "Delta", "Ronix,", "Volcano", "Velocity"
    },
	 DiscordInvite = "PRkuntnHmM", -- The Discord Invite Link. Do Not Include discord.gg/ | Only Include the code.
	 Icon = 1, -- By Default, The Icon Is The Home Icon. If You would like to change it to dashboard, replace the interger with 2
})





-- ========== COMBAT TAB ==========
local CombatTab = Window:CreateTab({
    Name = "Combat",
    Icon = "gavel",
    ImageSource = "Material"
})

local defaultSilentAim = {
    Enabled = false,
    Mode = "Raycast",
    TeamCheck = false,
    WallCheck = false,
    MaxDistance = 1000,
    TargetPart = "Head",
    FOVRadius = 200,
    FOVVisible = false,
    ShowTarget = false,
    HitChance = 100,
    Prediction = false,
    PredictionAmount = 0.13,
    CameraLock = {
        Smoothness = 0.5,
        HoldToLock = false,
        HoldInput = "Mouse Button 2",
        HoldReleaseDuration = 0.25,
        SensitivityMultiplier = 1
    },
    Triggerbot = false,
    TriggerbotDelay = 0.05,
    TargetMode = "Mouse" -- Mouse, Distance
}

local SilentAim = Utils.deepCopy(defaultSilentAim)

if savedConfig and type(savedConfig.SilentAim) == "table" then
    Utils.deepMerge(SilentAim, savedConfig.SilentAim)
end

if type(SilentAim.CameraLock) ~= "table" then
    SilentAim.CameraLock = Utils.deepCopy(defaultSilentAim.CameraLock)
else
    Utils.deepMerge(SilentAim.CameraLock, defaultSilentAim.CameraLock)
end

if SilentAim.Mode ~= "Camera Lock" then
    SilentAim.Mode = "Raycast"
end

SilentAim.MaxDistance = Utils.clampNumber(SilentAim.MaxDistance, 100, 3000, defaultSilentAim.MaxDistance)
SilentAim.FOVRadius = Utils.clampNumber(SilentAim.FOVRadius, 50, 500, defaultSilentAim.FOVRadius)
SilentAim.HitChance = Utils.clampNumber(SilentAim.HitChance, 0, 100, defaultSilentAim.HitChance)
SilentAim.PredictionAmount = Utils.clampNumber(SilentAim.PredictionAmount, 0.01, 0.5, defaultSilentAim.PredictionAmount)
SilentAim.CameraLock.Smoothness = Utils.clampNumber(SilentAim.CameraLock.Smoothness, 0.01, 3, defaultSilentAim.CameraLock.Smoothness)
SilentAim.CameraLock.HoldReleaseDuration = Utils.clampNumber(SilentAim.CameraLock.HoldReleaseDuration, 0, 1.5, defaultSilentAim.CameraLock.HoldReleaseDuration)
SilentAim.CameraLock.SensitivityMultiplier = Utils.clampNumber(SilentAim.CameraLock.SensitivityMultiplier, 0.05, 2, defaultSilentAim.CameraLock.SensitivityMultiplier)

local pendingVisualSettings = {}

if savedConfig and type(savedConfig.Visuals) == "table" then
    local visuals = savedConfig.Visuals
    local espConfig = visuals.ESP
    if type(espConfig) == "table" then
        if espConfig.Enabled ~= nil then
            state.esp = espConfig.Enabled and true or false
        end
        local restoredFill = Utils.tableToColor(espConfig.Color)
        if restoredFill then
            espColor = restoredFill
        end
        local restoredOutline = Utils.tableToColor(espConfig.OutlineColor)
        if restoredOutline then
            espOutlineColor = restoredOutline
        end
    end

    local fovConfig = visuals.FOVCircle
    if type(fovConfig) == "table" then
        if type(fovConfig.Visible) == "boolean" then
            SilentAim.FOVVisible = fovConfig.Visible
        end
        local restoredFovColor = Utils.tableToColor(fovConfig.Color)
        if restoredFovColor then
            pendingVisualSettings.fovColor = restoredFovColor
        end
        if type(fovConfig.Radius) == "number" then
            SilentAim.FOVRadius = Utils.clampNumber(fovConfig.Radius, 50, 500, SilentAim.FOVRadius)
        end
    end

    local targetConfig = visuals.TargetBox
    if type(targetConfig) == "table" then
        local restoredTargetColor = Utils.tableToColor(targetConfig.Color)
        if restoredTargetColor then
            pendingVisualSettings.targetColor = restoredTargetColor
        end
    end
    
    if type(visuals.AdvancedESP) == "table" then
        Utils.deepMerge(VisualsSettings.ESP, visuals.AdvancedESP)
        -- Restore colors manually as deepMerge doesn't handle table->Color3 conversion automatically for all fields if they are arrays
        if type(visuals.AdvancedESP.BoxColor) == "table" then VisualsSettings.ESP.BoxColor = Utils.tableToColor(visuals.AdvancedESP.BoxColor) end
        if type(visuals.AdvancedESP.SkeletonColor) == "table" then VisualsSettings.ESP.SkeletonColor = Utils.tableToColor(visuals.AdvancedESP.SkeletonColor) end
        if type(visuals.AdvancedESP.NameColor) == "table" then VisualsSettings.ESP.NameColor = Utils.tableToColor(visuals.AdvancedESP.NameColor) end
        if type(visuals.AdvancedESP.TracerColor) == "table" then VisualsSettings.ESP.TracerColor = Utils.tableToColor(visuals.AdvancedESP.TracerColor) end
        if type(visuals.AdvancedESP.ArrowColor) == "table" then VisualsSettings.ESP.ArrowColor = Utils.tableToColor(visuals.AdvancedESP.ArrowColor) end
    end
end

if savedConfig and type(savedConfig.Combat) == "table" then
    if type(savedConfig.Combat.RageMode) == "boolean" then
        state.rageMode = savedConfig.Combat.RageMode
    end
end

if savedConfig and type(savedConfig.Bypass) == "table" then
    if type(savedConfig.Bypass.Movement) == "boolean" then
        bypassSettings.Movement = savedConfig.Bypass.Movement
    end
    if type(savedConfig.Bypass.SilentAim) == "boolean" then
        bypassSettings.SilentAim = savedConfig.Bypass.SilentAim
    end
end

local function getTeamForPlayer(player)
    if not player then return nil end
    if Teams then
        for _, team in ipairs(Teams:GetChildren()) do
            if team:IsA("Team") and team.Name == player.TeamColor.Name then
                return team
            end
        end
    end
    return player.Team
end

if savedConfig and type(savedConfig.Movement) == "table" then
    if type(savedConfig.Movement.WalkSpeed) == "number" then
        state.desiredWalkSpeed = Utils.clampNumber(savedConfig.Movement.WalkSpeed, 16, 500, state.desiredWalkSpeed)
    end
    if type(savedConfig.Movement.JumpPower) == "number" then
        state.desiredJumpPower = Utils.clampNumber(savedConfig.Movement.JumpPower, 50, 500, state.desiredJumpPower)
    end
    if type(savedConfig.Movement.Gravity) == "number" then
        state.desiredGravity = Utils.clampNumber(savedConfig.Movement.Gravity, 0, 196, state.desiredGravity)
    end
end

-- FOV Circle
local function createDrawing(kind)
    if typeof(Drawing) == "table" and typeof(Drawing.new) == "function" then
        local ok, object = pcall(Drawing.new, kind)
        if ok and object then
            return object
        end
    end

    local proxy = {}
    proxy.Remove = function() end
    return setmetatable(proxy, {
        __index = function(tbl, key)
            return rawget(tbl, key)
        end,
        __newindex = function(tbl, key, value)
            rawset(tbl, key, value)
        end
    })
end

local fovCircle = createDrawing("Circle")
fovCircle.Thickness = 2
fovCircle.NumSides = 64
fovCircle.Radius = 200
fovCircle.Filled = false
fovCircle.Visible = false
fovCircle.ZIndex = 999
fovCircle.Transparency = 1
fovCircle.Color = Color3.fromRGB(255, 255, 255)

if pendingVisualSettings.fovColor then
    fovCircle.Color = pendingVisualSettings.fovColor
end

-- Target Box
local targetBox = createDrawing("Square")
targetBox.Visible = false
targetBox.ZIndex = 999
targetBox.Color = Color3.fromRGB(255, 0, 0)
targetBox.Thickness = 3
targetBox.Size = Vector2.new(25, 25)
targetBox.Filled = false

if pendingVisualSettings.targetColor then
    targetBox.Color = pendingVisualSettings.targetColor
end

local function getSerializableSilentAim()
    local serialized = Utils.deepCopy(SilentAim)
    if type(serialized.CameraLock) ~= "table" then
        serialized.CameraLock = Utils.deepCopy(defaultSilentAim.CameraLock)
    end
    return serialized
end

local function buildConfigSnapshot()
    local snapshot = {
        SilentAim = getSerializableSilentAim(),
        Visuals = {
            ESP = {
                Enabled = state.esp,
                Color = Utils.colorToTable(espColor),
                OutlineColor = Utils.colorToTable(espOutlineColor)
            },
            FOVCircle = {
                Visible = SilentAim.FOVVisible,
                Color = Utils.colorToTable(fovCircle.Color),
                Radius = SilentAim.FOVRadius
            },
            TargetBox = {
                Color = Utils.colorToTable(targetBox.Color)
            },
            AdvancedESP = {
                Enabled = VisualsSettings.ESP.Enabled,
                Box = VisualsSettings.ESP.Box,
                BoxColor = colorToTable(VisualsSettings.ESP.BoxColor),
                BoxOutline = VisualsSettings.ESP.BoxOutline,
                HealthBar = VisualsSettings.ESP.HealthBar,
                Skeleton = VisualsSettings.ESP.Skeleton,
                SkeletonColor = colorToTable(VisualsSettings.ESP.SkeletonColor),
                Name = VisualsSettings.ESP.Name,
                NameColor = colorToTable(VisualsSettings.ESP.NameColor),
                Distance = VisualsSettings.ESP.Distance,
                Weapon = VisualsSettings.ESP.Weapon,
                Tracers = VisualsSettings.ESP.Tracers,
                TracerColor = colorToTable(VisualsSettings.ESP.TracerColor),
                TracerOrigin = VisualsSettings.ESP.TracerOrigin,
                OffscreenArrows = VisualsSettings.ESP.OffscreenArrows,
                ArrowColor = colorToTable(VisualsSettings.ESP.ArrowColor),
                ArrowRadius = VisualsSettings.ESP.ArrowRadius,
                TeamCheck = VisualsSettings.ESP.TeamCheck,
                TextSize = VisualsSettings.ESP.TextSize,
                Font = VisualsSettings.ESP.Font
            }
        },
        Combat = {
            RageMode = state.rageMode
        },
        Movement = {
            WalkSpeed = state.desiredWalkSpeed,
            JumpPower = state.desiredJumpPower,
            Gravity = state.desiredGravity
        },
        Bypass = deepCopy(bypassSettings)
    }
    return snapshot
end

local function saveConfigNow()
    if typeof(writefile) ~= "function" then
        return
    end
    local payload = buildConfigSnapshot()
    local okEncode, json = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    if not okEncode or type(json) ~= "string" then
        return
    end
    pcall(writefile, CONFIG_FILE_NAME, json)
end

local pendingSaveScheduled = false

queueConfigSave = function()
    if typeof(writefile) ~= "function" then
        return
    end
    if pendingSaveScheduled then
        return
    end
    pendingSaveScheduled = true
    task.delay(0.25, function()
        pendingSaveScheduled = false
        saveConfigNow()
    end)
end

local function enforceHumanoidProperty(propertyName, desiredValue)
    if not Humanoid or type(desiredValue) ~= "number" then
        return
    end
    local current = Humanoid[propertyName]
    if type(current) == "number" and math.abs(current - desiredValue) > 0.05 then
        Humanoid[propertyName] = desiredValue
    end
end

local function bindMovementBypass()
    if connections.walkSpeedBypass then
        connections.walkSpeedBypass:Disconnect()
        connections.walkSpeedBypass = nil
    end
    if connections.jumpPowerBypass then
        connections.jumpPowerBypass:Disconnect()
        connections.jumpPowerBypass = nil
    end

    if not bypassSettings.Movement or not Humanoid then
        return
    end

    enforceHumanoidProperty("WalkSpeed", state.desiredWalkSpeed)
    enforceHumanoidProperty("JumpPower", state.desiredJumpPower)

    connections.walkSpeedBypass = Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        enforceHumanoidProperty("WalkSpeed", state.desiredWalkSpeed)
    end)

    connections.jumpPowerBypass = Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        enforceHumanoidProperty("JumpPower", state.desiredJumpPower)
    end)
end

local function enforceGravity()
    if not bypassSettings.Movement or type(state.desiredGravity) ~= "number" then
        return
    end
    if math.abs(workspace.Gravity - state.desiredGravity) > 0.1 then
        workspace.Gravity = state.desiredGravity
    end
end

local function bindGravityBypass()
    if connections.gravityBypass then
        connections.gravityBypass:Disconnect()
        connections.gravityBypass = nil
    end

    if not bypassSettings.Movement then
        return
    end

    enforceGravity()
    connections.gravityBypass = workspace:GetPropertyChangedSignal("Gravity"):Connect(function()
        enforceGravity()
    end)
end

local function refreshMovementBypass()
    bindMovementBypass()
    bindGravityBypass()
end

local cameraHoldActive = false
local cameraHoldOptionList = {"Mouse Button 2", "Mouse Button 1", "Left Shift", "Right Shift", "E", "Q"}
local cameraHoldOptions = {
    ["Mouse Button 2"] = { kind = "UserInputType", value = Enum.UserInputType.MouseButton2 },
    ["Mouse Button 1"] = { kind = "UserInputType", value = Enum.UserInputType.MouseButton1 },
    ["Left Shift"] = { kind = "KeyCode", value = Enum.KeyCode.LeftShift },
    ["Right Shift"] = { kind = "KeyCode", value = Enum.KeyCode.RightShift },
    ["E"] = { kind = "KeyCode", value = Enum.KeyCode.E },
    ["Q"] = { kind = "KeyCode", value = Enum.KeyCode.Q }
}

if not cameraHoldOptions[SilentAim.CameraLock.HoldInput] then
    SilentAim.CameraLock.HoldInput = defaultSilentAim.CameraLock.HoldInput
end

refreshMovementBypass()

if Humanoid then
    Humanoid.WalkSpeed = state.desiredWalkSpeed
    Humanoid.JumpPower = state.desiredJumpPower
end

workspace.Gravity = state.desiredGravity
if bypassSettings.Movement then
    enforceGravity()
end

local function matchesCameraHoldInput(input)
    local descriptor = cameraHoldOptions[SilentAim.CameraLock.HoldInput]
    if not descriptor then return false end
    if descriptor.kind == "UserInputType" then
        return input.UserInputType == descriptor.value
    elseif descriptor.kind == "KeyCode" then
        return input.KeyCode == descriptor.value
    end
    return false
end

local cameraControls = {
    releaseToken = 0,
    smoothSlider = nil,
    sensitivitySlider = nil,
    holdToggle = nil,
    holdReleaseSlider = nil,
    holdDropdown = nil
}

local function cancelCameraHoldRelease()
    cameraControls.releaseToken += 1
    return cameraControls.releaseToken
end

local function activateCameraHold()
    cameraHoldActive = true
    cancelCameraHoldRelease()
end

local function deactivateCameraHold()
    cameraHoldActive = false
    cancelCameraHoldRelease()
end

local function scheduleCameraHoldRelease()
    local duration = math.max(SilentAim.CameraLock.HoldReleaseDuration or 0, 0)
    local token = cancelCameraHoldRelease()
    if duration <= 0 then
        cameraHoldActive = false
        return
    end
    task.delay(duration, function()
        if cameraControls.releaseToken ~= token then
            return
        end
        cameraHoldActive = false
    end)
end

local velocityTracker = {}
local velocityCleanupCounter = 0
local rageTargetHoldUntil = 0
local rageTargetCooldownUntil = 0
local spawnProtectionCooldowns = {}
local spawnProtectionFirstSeen = {}
local playerJoinTimes = {}
local trackedPlayers = {}
local lastRageTargetFound = os.clock()

local function handleEnemyCharacterAdded(player, character)
    spawnProtectionCooldowns[player] = nil
    spawnProtectionFirstSeen[player] = nil
end

local function markRageTargetLock()
    lastRageTargetFound = os.clock()
end

local function trackEnemyPlayer(player)
    if player == LocalPlayer or trackedPlayers[player] then
        return
    end
    trackedPlayers[player] = true
    playerJoinTimes[player] = playerJoinTimes[player] or os.clock()
    player.CharacterAdded:Connect(function(character)
        handleEnemyCharacterAdded(player, character)
    end)
    if player.Character then
        handleEnemyCharacterAdded(player, player.Character)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    trackEnemyPlayer(player)
    if not playerJoinTimes[player] then
        playerJoinTimes[player] = os.clock()
    end
end

Players.PlayerAdded:Connect(function(player)
    trackEnemyPlayer(player)
    playerJoinTimes[player] = os.clock()
end)

Players.PlayerRemoving:Connect(function(player)
    playerJoinTimes[player] = nil
    spawnProtectionCooldowns[player] = nil
    spawnProtectionFirstSeen[player] = nil
    trackedPlayers[player] = nil
end)

local function updateCameraOptionVisibility()
    local isCamera = SilentAim.Mode == "Camera Lock"
    local smooth = cameraControls.smoothSlider
    if smooth and smooth.Object then
        smooth.Object.Visible = isCamera
    end
    local sensitivity = cameraControls.sensitivitySlider
    if sensitivity and sensitivity.Object then
        sensitivity.Object.Visible = isCamera
    end
    local holdToggle = cameraControls.holdToggle
    if holdToggle and holdToggle.Object then
        holdToggle.Object.Visible = isCamera
    end
    local holdRelease = cameraControls.holdReleaseSlider
    if holdRelease and holdRelease.Object then
        holdRelease.Object.Visible = isCamera and SilentAim.CameraLock.HoldToLock
    end
    local holdDropdown = cameraControls.holdDropdown
    if holdDropdown and holdDropdown.Object then
        holdDropdown.Object.Visible = isCamera and SilentAim.CameraLock.HoldToLock
    end
end

local function setAimMode(mode)
    if mode ~= "Camera Lock" then
        mode = "Raycast"
    end
    SilentAim.Mode = mode
    if mode == "Raycast" then
        SilentAim.FOVVisible = false
        fovCircle.Visible = false
        deactivateCameraHold()
    end
    updateCameraOptionVisibility()
    queueConfigSave()
end

local function isAimAssistActive()
    return SilentAim.Enabled or state.rageMode
end

-- Helper Functions
local ignoredScriptNames = {
    CameraScript = true,
    CameraModule = true,
    VehicleCamera = true,
    VehicleController = true,
    MouseLockController = true,
    ControlScript = true,
    PopperCam = true,
    OrbitalCamera = true,
    ClassicCamera = true
}

local antiCheatKeywords = {
    "anticheat",
    "anti_cheat",
    "anti-cheat",
    "clientanticheat",
    "security",
    "cheat",
    "detector",
    "punish",
    "exploit",
    "acclient"
}

local playerModule

local function updatePlayerModule()
    local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    playerModule = playerScripts and playerScripts:FindFirstChild("PlayerModule") or nil
end

updatePlayerModule()

local function attachPlayerScriptsListeners()
    local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    if not playerScripts then return end

    playerScripts.ChildAdded:Connect(function(child)
        if child.Name == "PlayerModule" then
            playerModule = child
        end
    end)

    playerScripts.ChildRemoved:Connect(function(child)
        if child == playerModule then
            playerModule = nil
        end
    end)
end

attachPlayerScriptsListeners()

LocalPlayer.ChildAdded:Connect(function(child)
    if child.Name == "PlayerScripts" then
        task.delay(0, function()
            updatePlayerModule()
            attachPlayerScriptsListeners()
        end)
    end
end)

LocalPlayer.ChildRemoved:Connect(function(child)
    if child.Name == "PlayerScripts" then
        playerModule = nil
    end
end)

connections.cameraHoldBegan = UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if not SilentAim.Enabled or SilentAim.Mode ~= "Camera Lock" then return end
    if not SilentAim.CameraLock.HoldToLock then return end
    if matchesCameraHoldInput(input) then
        activateCameraHold()
    end
end)

connections.cameraHoldEnded = UserInputService.InputEnded:Connect(function(input)
    if not SilentAim.CameraLock.HoldToLock then return end
    if matchesCameraHoldInput(input) then
        scheduleCameraHoldRelease()
    end
end)

local SilentAimSystem = {}

function SilentAimSystem.shouldIgnoreCaller()
    local caller = getcallingscript and getcallingscript()
    if not caller then return false end
    local callerName = caller.Name or ""
    local lowerName = string.lower(callerName)

    if ignoredScriptNames[callerName] or ignoredScriptNames[lowerName] then
        return true
    end

    if playerModule and caller:IsDescendantOf(playerModule) then
        return true
    end

    if not bypassSettings.SilentAim then
        return false
    end

    for _, keyword in ipairs(antiCheatKeywords) do
        if string.find(lowerName, keyword, 1, true) then
            return true
        end
    end

    local parent = caller.Parent
    if parent then
        local parentName = parent.Name or ""
        local parentLower = string.lower(parentName)
        if ignoredScriptNames[parentName] or ignoredScriptNames[parentLower] then
            return true
        end
        for _, keyword in ipairs(antiCheatKeywords) do
            if string.find(parentLower, keyword, 1, true) then
                return true
            end
        end
    end

    return false
end

function SilentAimSystem.hitChance(percentage)
    return math.random(100) <= percentage
end

function SilentAimSystem.getAimPosition()
    local viewportSize = Camera and Camera.ViewportSize or Vector2.new(1920, 1080)
    return Vector2.new(viewportSize.X * 0.5, viewportSize.Y * 0.5)
end

function SilentAimSystem.worldToScreen(position)
    return Camera:WorldToViewportPoint(position)
end

function SilentAimSystem.isVisible(targetPart, origin)
    if not SilentAim.WallCheck then return true end

    origin = origin or (Camera and Camera.CFrame.Position)
    if not origin then return false end

    local direction = (targetPart.Position - origin)
    if direction.Magnitude <= 0 then return false end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetPart.Parent}
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil or result.Instance:IsDescendantOf(targetPart.Parent)
end

local currentTargetPart

local teamAttributeNames = {"Team", "team", "TeamId", "teamId", "Faction", "Side"}

function SilentAimSystem.playersShareAttribute(playerA, playerB, attributeNames)
    for _, attribute in ipairs(attributeNames) do
        local aValue = playerA:GetAttribute(attribute)
        local bValue = playerB:GetAttribute(attribute)
        if aValue ~= nil and bValue ~= nil and aValue == bValue then
            return true
        end
    end
    return false
end

function SilentAimSystem.isFriendlyPlayer(player)
    if not SilentAim.TeamCheck then
        return false
    end
    if not player then
        return false
    end
    if player == LocalPlayer then
        return true
    end

    local localTeam = getTeamForPlayer(LocalPlayer)
    local targetTeam = getTeamForPlayer(player)
    if localTeam and targetTeam then
        if localTeam == targetTeam then
            return true
        end
        if localTeam.TeamColor and targetTeam.TeamColor and localTeam.TeamColor == targetTeam.TeamColor then
            return true
        end
    end

    local localTeamColor = LocalPlayer.TeamColor
    local targetTeamColor = player.TeamColor
    if localTeamColor and targetTeamColor and localTeamColor == targetTeamColor then
        if not LocalPlayer.Neutral and not player.Neutral then
            return true
        end
    end

    if SilentAimSystem.playersShareAttribute(LocalPlayer, player, teamAttributeNames) then
        return true
    end

    return false
end

function SilentAimSystem.acquireClosestTarget()
    local closestPart = nil
    local shortestDistance = math.huge
    local mousePos = SilentAimSystem.getAimPosition()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if SilentAimSystem.isFriendlyPlayer(player) then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local targetPart = character:FindFirstChild(SilentAim.TargetPart)
        if not targetPart then continue end
        
        local distance3d = (targetPart.Position - Camera.CFrame.Position).Magnitude
        if distance3d > SilentAim.MaxDistance then continue end
        
        local screenPos, onScreen = SilentAimSystem.worldToScreen(targetPart.Position)
        if not onScreen then continue end
        
        if not SilentAimSystem.isVisible(targetPart) then continue end
        
        if SilentAim.TargetMode == "Distance" then
            if distance3d < shortestDistance then
                shortestDistance = distance3d
                closestPart = targetPart
            end
        else -- Mouse
            local distance2d = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if distance2d < SilentAim.FOVRadius and distance2d < shortestDistance then
                shortestDistance = distance2d
                closestPart = targetPart
            end
        end
    end
    
    currentTargetPart = closestPart
    return currentTargetPart
end

function SilentAimSystem.getClosestToMouse()
    return currentTargetPart or SilentAimSystem.acquireClosestTarget()
end

local lastHitChanceCheck = 0
local lastHitChancePass = true
local HIT_CHANCE_WINDOW = 0.03

function SilentAimSystem.shouldAllowHit()
    if SilentAim.Mode ~= "Raycast" then return false end
    if not isAimAssistActive() then return false end
    if SilentAim.HitChance >= 100 then return true end
    if SilentAim.HitChance <= 0 then return false end

    local now = os.clock()
    if now - lastHitChanceCheck > HIT_CHANCE_WINDOW then
        lastHitChancePass = SilentAimSystem.hitChance(SilentAim.HitChance)
        lastHitChanceCheck = now
    end
    return lastHitChancePass
end

function SilentAimSystem.updateVelocityEstimate(part)
    if typeof(part) ~= "Instance" then
        return Vector3.new()
    end

    local now = os.clock()
    local position = part.Position
    local cache = velocityTracker[part]
    local assemblyVelocity = part.AssemblyLinearVelocity or Vector3.new()

    if cache then
        local delta = math.max(now - cache.time, 1 / 240)
        local rawVelocity = (position - cache.position) / delta
        local speedBlend = math.clamp((assemblyVelocity.Magnitude - 80) / 320, 0, 1)
        local blendedVelocity = rawVelocity:Lerp(assemblyVelocity, speedBlend)
        local smoothing = math.clamp(delta * (assemblyVelocity.Magnitude > 150 and 12 or 6), 0.05, 1)
        local updatedVelocity = cache.velocity:Lerp(blendedVelocity, smoothing)
        cache.position = position
        cache.time = now
        cache.velocity = updatedVelocity
        return updatedVelocity
    end

    velocityTracker[part] = {
        position = position,
        time = now,
        velocity = assemblyVelocity
    }

    return assemblyVelocity
end

function SilentAimSystem.getPredictedPosition(part, origin)
    local position = part.Position
    if not SilentAim.Prediction then
        return position
    end

    local velocity = SilentAimSystem.updateVelocityEstimate(part)
    if velocity.Magnitude == 0 then
        velocity = part.Velocity or Vector3.new()
    end

    local humanoid = part.Parent and part.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0.01 then
            local projected = moveDirection.Unit * humanoid.WalkSpeed
            velocity = velocity:Lerp(projected, 0.35)
        end
    end

    local pingSeconds = 0
    if typeof(LocalPlayer.GetNetworkPing) == "function" then
        local ok, pingValue = pcall(LocalPlayer.GetNetworkPing, LocalPlayer)
        if ok and type(pingValue) == "number" then
            pingSeconds = math.clamp(pingValue, 0, 0.35)
        end
    end

    local localRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local timeAhead = SilentAim.PredictionAmount + pingSeconds

    if origin then
        local distance = (position - origin).Magnitude
        if distance > 0 then
            local travelTime = distance / 1500
            timeAhead = timeAhead + math.min(travelTime, 0.35)
        end
    end

    local targetSpeed = velocity.Magnitude
    if targetSpeed > 120 then
        local extra = math.clamp((targetSpeed - 120) / 450, 0, 0.5)
        timeAhead = timeAhead + extra
    end

    if localRootPart then
        local shooterVelocity = localRootPart.AssemblyLinearVelocity
        local relativeSpeed = (velocity - shooterVelocity).Magnitude
        if relativeSpeed > 150 then
            timeAhead = timeAhead + math.clamp((relativeSpeed - 150) / 500, 0, 0.45)
        end
        local shooterBoost = math.clamp(shooterVelocity.Magnitude / 750, 0, 0.35)
        timeAhead = timeAhead + shooterBoost
    end

    timeAhead = math.clamp(timeAhead, 0, 1.75)

    return position + (velocity * timeAhead)
end

function SilentAimSystem.resolveTargetSolution(origin, magnitude, skipChance)
    if SilentAim.Mode ~= "Raycast" then return end
    if not isAimAssistActive() then return end
    if not origin then return end
    if not skipChance and not SilentAimSystem.shouldAllowHit() then return end

    local targetPart = currentTargetPart
    if not targetPart or not targetPart.Parent then
        targetPart = SilentAimSystem.acquireClosestTarget()
    end
    if not targetPart then return end
    if not SilentAimSystem.isVisible(targetPart, origin) then return end

    local targetPosition = SilentAimSystem.getPredictedPosition(targetPart, origin)
    local direction = targetPosition - origin
    if direction.Magnitude <= 0 then return end

    local mag = magnitude
    if not mag or mag <= 0 then
        mag = direction.Magnitude
    end
    if mag <= 0 then return end

    currentTargetPart = targetPart
    return targetPart, targetPosition, direction.Unit * mag
end

function SilentAimSystem.adjustDirection(origin, direction)
    if SilentAim.Mode ~= "Raycast" then
        return direction, nil, nil
    end
    if typeof(origin) ~= "Vector3" or typeof(direction) ~= "Vector3" then
        return direction, nil, nil
    end
    local targetPart, targetPosition, newDirection = SilentAimSystem.resolveTargetSolution(origin, direction.Magnitude)
    if newDirection then
        return newDirection, targetPart, targetPosition
    end
    return direction, nil, nil
end

function SilentAimSystem.adjustRay(ray)
    if SilentAim.Mode ~= "Raycast" then
        return ray, nil, nil
    end
    if typeof(ray) ~= "Ray" then
        return ray, nil, nil
    end
    local targetPart, targetPosition, newDirection = SilentAimSystem.resolveTargetSolution(ray.Origin, ray.Direction and ray.Direction.Magnitude)
    if newDirection then
        return Ray.new(ray.Origin, newDirection), targetPart, targetPosition
    end
    return ray, nil, nil
end

local function hasAttributeFlag(instance, attrList)
    if not instance or type(attrList) ~= "table" then
        return false
    end
    for _, attribute in ipairs(attrList) do
        local ok, value = pcall(function()
            return instance:GetAttribute(attribute)
        end)
        if ok and value ~= nil then
            local valueType = typeof(value)
            if valueType == "boolean" then
                if value then
                    return true
                end
            elseif valueType == "number" then
                if math.abs(value) > 0.0001 then
                    return true
                end
            elseif valueType == "string" then
                local lower = string.lower(value)
                if lower == "true" or lower == "on" or lower == "enabled" or lower == "yes" or lower == "1" then
                    return true
                end
            end
        end
    end
    return false
end

local function isSpawnProtected(player, character, humanoid)
    if RageSettings.RespectForceFields and character and character:FindFirstChildOfClass("ForceField") then
        return true
    end
    local attrList = RageSettings.SpawnProtectionAttributes
    return hasAttributeFlag(humanoid, attrList) or hasAttributeFlag(player, attrList) or (character and hasAttributeFlag(character, attrList))
end

local RageSystem = {}

function RageSystem.getCharacterRoot(character)
    return character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso"))
end

function RageSystem.getWorkspaceFloor()
    local fallen = workspace and workspace.FallenPartsDestroyHeight
    return (type(fallen) == "number" and fallen > -1e6 and fallen) or (RageSettings.MinimumHeight or -25)
end

function RageSystem.isTargetOverVoid(targetRoot, targetCharacter)
    if not targetRoot or not workspace or targetRoot.Position.Y < RageSystem.getWorkspaceFloor() then
        return true
    end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {Character, targetCharacter}
    params.IgnoreWater = true
    local result = workspace:Raycast(targetRoot.Position, Vector3.new(0, -math.max(RageSettings.VoidRaycastLength or 0, 50), 0), params)
    return not result or (targetRoot.Position.Y - result.Position.Y) > math.max(RageSettings.VoidGroundTolerance or 0, 0)
end

function RageSystem.scanForRageTarget(params)
    params = params or {}
    local now = params.now or os.clock()
    local maxDistance = params.maxDistance or RageSettings.MaxDistance or 250
    local ignoreSpawnProtection = params.ignoreSpawnProtection
    local ignoreCooldown = params.ignoreCooldown
    local ignoreVoid = params.ignoreVoid
    local ignoreHeight = params.ignoreHeight
    local minHeight = nil
    if not ignoreHeight then
        minHeight = math.max(RageSystem.getWorkspaceFloor(), RageSettings.MinimumHeight or -25)
    end

    local closestRoot = nil
    local closestHumanoid = nil
    local bestScore = maxDistance
    local newPlayerBonus = math.max(RageSettings.NewPlayerPriorityBonus or 0, 0)

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then
            continue
        end
        if SilentAimSystem.isFriendlyPlayer(player) then
            continue
        end

        local character = player.Character
        if not character then
            continue
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            continue
        end
        
        local hState = humanoid:GetState()
        if hState == Enum.HumanoidStateType.Dead then
            continue
        end

        -- Removed ForceField check to target spawned players
        -- if not ignoreSpawnProtection and RageSettings.RespectForceFields then
        --     if character:FindFirstChildOfClass("ForceField") then
        --         continue
        --     end
        -- end

        local root = RageSystem.getCharacterRoot(character)
        if not root then
            continue
        end

        if minHeight and root.Position.Y < minHeight then
            continue
        end

        local distance = (root.Position - RootPart.Position).Magnitude
        if distance > maxDistance then
            continue
        end

        local score = distance
        if newPlayerBonus > 0 then
            local joinedAt = playerJoinTimes[player]
            if joinedAt and (now - joinedAt) <= math.max(RageSettings.NewPlayerWindow or 0, 0) then
                score = math.max(0, score - newPlayerBonus)
            end
        end

        if score < bestScore then
            bestScore = score
            closestRoot = root
            closestHumanoid = humanoid
        end
    end

    return closestRoot, closestHumanoid
end

function RageSystem.getRageTarget()
    if not RootPart or not RootPart.Parent then
        return nil, nil
    end

    local now = os.clock()
    local desperate = (now - lastRageTargetFound) >= (RageSettings.DesperateTargetDelay or 3)
    local maxDistance = RageSettings.MaxDistance or 250

    local targetRoot, targetHumanoid = RageSystem.scanForRageTarget({
        now = now,
        maxDistance = maxDistance,
        ignoreCooldown = desperate,
        ignoreSpawnProtection = desperate,
        ignoreVoid = false,
        ignoreHeight = false
    })

    if targetRoot then
        return targetRoot, targetHumanoid
    end

    if not desperate then
        return nil, nil
    end

    return RageSystem.scanForRageTarget({
        now = now,
        maxDistance = maxDistance * 1.5,
        ignoreCooldown = true,
        ignoreSpawnProtection = true,
        ignoreVoid = false,
        ignoreHeight = false
    })
end

function RageSystem.computeRageGoalCFrame(targetRoot)
    if not targetRoot then
        return nil
    end
    local targetPos = targetRoot.Position
    
    if RageSettings.PredictVelocity then
        local velocity = targetRoot.AssemblyLinearVelocity
        if velocity and velocity.Magnitude > 1 then
            local predTime = RageSettings.PredictionTime or 0.15
            targetPos = targetPos + (velocity * predTime)
        end
    end
    
    local targetLook = targetRoot.CFrame.LookVector
    
    local behindOffset = -targetLook * math.abs(RageSettings.ForwardOffset)
    local sideOffset = targetRoot.CFrame.RightVector * RageSettings.SideOffset
    local upOffset = Vector3.new(0, RageSettings.VerticalOffset, 0)
    
    local goalPosition = targetPos + behindOffset + sideOffset + upOffset
    
    if RageSettings.CheckCollision and workspace then
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {Character, targetRoot.Parent}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        rayParams.IgnoreWater = true
        
        local toGoal = goalPosition - targetPos
        local checkDist = math.min(toGoal.Magnitude, RageSettings.CollisionCheckDistance or 15)
        if checkDist > 0 then
            local result = workspace:Raycast(targetPos, toGoal.Unit * checkDist, rayParams)
            if result then
                local clearOffset = -targetLook * 3
                local clearUp = Vector3.new(0, 3, 0)
                goalPosition = targetPos + clearOffset + clearUp
            end
        end
    end
    
    return CFrame.new(goalPosition, targetPos)
end

function RageSystem.isSafeRagePosition(position)
    if not position then
        return false
    end
    if position.Y < (RageSettings.MinimumHeight or -25) then
        return false
    end
    if not workspace or not workspace.Terrain then
        return true
    end
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.IgnoreWater = true
    local result = workspace:Raycast(position, Vector3.new(0, -250, 0), rayParams)
    if result then
        return true
    end
    return position.Y >= (RageSettings.MinimumHeight or -25)
end

function RageSystem.getVoidFloorHeight()
    local buffer = math.max(RageSettings.VoidRecoveryHeight or 0, 0)
    local safeFloor = type(RageSettings.VoidSafeFloor) == "number" and RageSettings.VoidSafeFloor or 0
    local workspaceFloor = RageSystem.getWorkspaceFloor() + (RageSettings.GlobalFloorMargin or 0)
    return math.max(workspaceFloor + buffer, safeFloor)
end

function RageSystem.ensureGoalPosition(position)
    if not position then
        return nil
    end
    local floorY = RageSystem.getVoidFloorHeight()
    if position.Y < floorY then
        position = Vector3.new(position.X, floorY, position.Z)
    end
    return position
end

function RageSystem.clampRageGoalPosition(currentPosition, desiredPosition)
    if not currentPosition or not desiredPosition then
        return desiredPosition
    end
    local delta = desiredPosition - currentPosition
    local distance = delta.Magnitude
    if distance <= 0 then
        return desiredPosition
    end

    local maxStep = math.max(RageSettings.MaxStepDistance or 55, 1)
    if distance > maxStep then
        desiredPosition = currentPosition + delta.Unit * maxStep
        delta = desiredPosition - currentPosition
    end

    local maxRise = math.max(RageSettings.MaxRiseStep or 0, 0)
    if maxRise > 0 and delta.Y > maxRise then
        desiredPosition = Vector3.new(desiredPosition.X, currentPosition.Y + maxRise, desiredPosition.Z)
    end

    return desiredPosition
end

function RageSystem.updateLastSafeRageCFrame()
    if RootPart and RootPart.Parent and RageSystem.isSafeRagePosition(RootPart.Position) then
        lastSafeRageCFrame = RootPart.CFrame
    end
end

function RageSystem.recoverFromUnsafePosition()
    if not RootPart or not RootPart.Parent then
        return
    end
    local fallback = lastSafeRageCFrame
    if not fallback then
        local floorY = RageSystem.getVoidFloorHeight()
        fallback = CFrame.new(RootPart.Position.X, floorY, RootPart.Position.Z)
    end
    RootPart.CFrame = fallback
    RootPart.AssemblyLinearVelocity = Vector3.zero
    RootPart.AssemblyAngularVelocity = Vector3.zero
    lastSafeRageCFrame = fallback
    rageTargetCooldownUntil = os.clock() + 0.3
end

function RageSystem.sanitizeTargetVelocity(velocity)
    velocity = velocity or Vector3.zero
    local maxDown = math.abs(RageSettings.MaxFollowDownVelocity or 0)
    if maxDown > 0 and velocity.Y < -maxDown then
        velocity = Vector3.new(velocity.X, -maxDown, velocity.Z)
    end
    return velocity
end

function RageSystem.lockRageCamera(targetRoot)
    if not RageSettings.LockCamera or not Camera or not targetRoot then
        return
    end
    local origin = Camera.CFrame.Position
    local focus = targetRoot.Position + Vector3.new(0, RageSettings.CameraHeightOffset, 0)
    
    -- Check distance to avoid glitching when too close
    if (origin - focus).Magnitude < 2 then return end

    local desired = CFrame.lookAt(origin, focus)
    local smooth = math.clamp(RageSettings.CameraSmoothness or 0, 0, 1)
    
    -- Increase smoothness to reduce jitter
    smooth = math.max(smooth, 0.1) 
    
    if smooth <= 0 then
        Camera.CFrame = desired
    else
        Camera.CFrame = Camera.CFrame:Lerp(desired, smooth)
    end
end

function RageSystem.updateRageAimTarget(targetRoot)
    if not targetRoot or not targetRoot.Parent then
        return nil
    end
    local parentModel = targetRoot.Parent
    local preferred
    if SilentAim and SilentAim.TargetPart and parentModel:FindFirstChild(SilentAim.TargetPart) then
        preferred = parentModel:FindFirstChild(SilentAim.TargetPart)
    end
    local aimPart = preferred or parentModel:FindFirstChild("HumanoidRootPart") or targetRoot
    currentTargetPart = aimPart
    rageTargetHoldUntil = os.clock() + 0.25
    return aimPart
end

function RageSystem.getEquippedTool()
    if not Character then
        return nil
    end
    return Character:FindFirstChildOfClass("Tool")
end

function RageSystem.selectBackpackTool()
    if not LocalPlayer then
        return nil
    end
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then
        return nil
    end
    local priorities = RageSettings.ToolPriority
    if type(priorities) == "table" then
        for _, name in ipairs(priorities) do
            local tool = backpack:FindFirstChild(name)
            if tool and tool:IsA("Tool") then
                return tool
            end
        end
    end
    return backpack:FindFirstChildWhichIsA("Tool")
end

function RageSystem.ensureCombatTool()
    local equipped = RageSystem.getEquippedTool()
    if equipped then
        return equipped
    end
    if not RageSettings.AutoEquipTool or not Humanoid then
        return nil
    end
    local tool = RageSystem.selectBackpackTool()
    if tool then
        local ok = pcall(function()
            Humanoid:EquipTool(tool)
        end)
        if ok then
            return tool
        end
    end
    return nil
end

local lastRageShot = 0
local RAGE_SHOT_COOLDOWN = 0.05
local isArsenal = false
local arsenalDetected = false

function RageSystem.detectArsenal()
    return true
 end

function RageSystem.stopRageMode()
    if connections.rage then
        connections.rage:Disconnect()
        connections.rage = nil
    end
    rageTargetHoldUntil = 0
end

function RageSystem.rageAutoFire()
    if not RageSettings.AutoShoot then
        return
    end

    local now = tick()
    if now - lastRageShot < RAGE_SHOT_COOLDOWN then
        return
    end
    lastRageShot = now

    RageSystem.detectArsenal()
    
    local shots = (RageSettings.MultiShot and RageSettings.ShotBurst) or 1
    
    for i = 1, shots do
        task.spawn(function()
            if i > 1 then
                task.wait(0.02 * (i - 1))
            end
            
            -- Removed VirtualUser clicking to prevent screen glitching and spam
            -- Relying solely on Remote Events for Arsenal

            local tool = RageSystem.ensureCombatTool()
            if tool then
                -- Try standard activate first (sometimes needed for animation state)
                pcall(function()
                    if tool.Activate then
                        tool:Activate()
                    end
                end)
                
                -- Always try Arsenal remotes since this is the dedicated script
                pcall(function()
                    if tool:FindFirstChild("Fire") then
                        tool.Fire:FireServer()
                    end
                    if tool:FindFirstChild("Shoot") then
                        tool.Shoot:FireServer()
                    end
                    -- Some Arsenal guns use "Events" folder
                    if tool:FindFirstChild("Events") and tool.Events:FindFirstChild("Fire") then
                        tool.Events.Fire:FireServer()
                    end
                end)
            end
        end)
    end
end

function RageSystem.startRageMode()
    RageSystem.stopRageMode()
    if not state.rageMode then
        return
    end

    if not Character or not RootPart then
        return
    end
    
    local deathConnection
    if Humanoid then
        deathConnection = Humanoid.Died:Connect(function()
            RageSystem.stopRageMode()
            if state.rageMode then
                task.wait(0.5)
                RageSystem.startRageMode()
            end
        end)
    end

    connections.rage = RunService.Heartbeat:Connect(function()
        if not state.rageMode then
            RageSystem.stopRageMode()
            if deathConnection then deathConnection:Disconnect() end
            return
        end

        if state.fly then
            return
        end

        if not Character or not RootPart or not RootPart.Parent then
            RageSystem.stopRageMode()
            if deathConnection then deathConnection:Disconnect() end
            if state.rageMode then
                task.wait(0.5)
                RageSystem.startRageMode()
            end
            return
        end

        local humanoid = Humanoid
        if not humanoid or humanoid.Health <= 0 then
            return
        end

        local targetRoot, targetHumanoid = RageSystem.getRageTarget()
        if not targetRoot or not targetHumanoid then
            return
        end

        if targetHumanoid.Health <= 0 then
            return
        end

        local distance = (targetRoot.Position - RootPart.Position).Magnitude
        if distance > (RageSettings.MaxDistance or 250) then
            return
        end

        local targetPos = targetRoot.Position
        local targetLook = targetRoot.CFrame.LookVector
        local behindOffset = -targetLook * math.abs(RageSettings.ForwardOffset)
        local upOffset = Vector3.new(0, RageSettings.VerticalOffset, 0)
        local goalPosition = targetPos + behindOffset + upOffset
        local goalCF = CFrame.new(goalPosition, targetPos)
        
        local distance = (goalPosition - RootPart.Position).Magnitude
        if distance < 5 then
            RootPart.CFrame = goalCF
        else
            RootPart.CFrame = RootPart.CFrame:Lerp(goalCF, RageSettings.StepSmoothing)
        end

        RageSystem.updateRageAimTarget(targetRoot)
        RageSystem.lockRageCamera(targetRoot)
        RageSystem.rageAutoFire()
        
        -- ForceField Removal (Visual/Targeting)
        if targetRoot.Parent then
            local ff = targetRoot.Parent:FindFirstChildOfClass("ForceField")
            if ff then ff:Destroy() end
        end
    end)
end

if state.rageMode then
    RageSystem.startRageMode()
end

local function isRelatedInstance(instance, reference)
    if typeof(instance) ~= "Instance" or typeof(reference) ~= "Instance" then
        return false
    end
    return instance == reference or instance:IsDescendantOf(reference) or reference:IsDescendantOf(instance)
end

local function removeTargetFromList(list, targetModel)
    if type(list) ~= "table" or typeof(targetModel) ~= "Instance" then
        return list
    end
    local needsChange = false
    for _, item in ipairs(list) do
        if isRelatedInstance(item, targetModel) then
            needsChange = true
            break
        end
    end
    if not needsChange then
        return list
    end
    local newList = {}
    for _, item in ipairs(list) do
        if not isRelatedInstance(item, targetModel) then
            newList[#newList + 1] = item
        end
    end
    return newList
end

local function ensureTargetInList(list, targetModel)
    if typeof(targetModel) ~= "Instance" then
        return list
    end
    if type(list) ~= "table" then
        return {targetModel}
    end
    for _, item in ipairs(list) do
        if isRelatedInstance(item, targetModel) then
            return list
        end
    end
    local newList = {}
    for i = 1, #list do
        newList[i] = list[i]
    end
    newList[#newList + 1] = targetModel
    return newList
end

local function cloneRaycastParams(params, filterList)
    if typeof(params) ~= "RaycastParams" then
        return params
    end
    local newParams = RaycastParams.new()
    newParams.FilterType = params.FilterType
    newParams.IgnoreWater = params.IgnoreWater
    newParams.CollisionGroup = params.CollisionGroup
    local hasRespect, respectValue = pcall(function()
        return params.RespectCanCollide
    end)
    if hasRespect then
        pcall(function()
            newParams.RespectCanCollide = respectValue
        end)
    end
    newParams.FilterDescendantsInstances = filterList
    return newParams
end

local function adjustRaycastParams(params, targetModel)
    if typeof(params) ~= "RaycastParams" or typeof(targetModel) ~= "Instance" then
        return params
    end
    local filter = params.FilterDescendantsInstances
    if params.FilterType == Enum.RaycastFilterType.Include then
        local newFilter = ensureTargetInList(filter, targetModel)
        if newFilter ~= filter then
            return cloneRaycastParams(params, newFilter)
        end
    elseif params.FilterType == Enum.RaycastFilterType.Blacklist then
        local newFilter = removeTargetFromList(filter, targetModel)
        if newFilter ~= filter then
            return cloneRaycastParams(params, newFilter)
        end
    end
    return params
end

function SilentAimSystem.applyCameraLock(delta)
    if SilentAim.Mode ~= "Camera Lock" then return end
    if not SilentAim.Enabled then return end

    if SilentAim.CameraLock.HoldToLock and not cameraHoldActive then
        return
    end

    local targetPart = currentTargetPart
    if not targetPart or not targetPart.Parent then
        targetPart = SilentAimSystem.acquireClosestTarget()
    end
    if not targetPart then return end

    local cam = Camera
    if not cam then return end

    local origin = cam.CFrame.Position
    local targetPosition = SilentAimSystem.getPredictedPosition(targetPart, origin)
    local desired = CFrame.lookAt(origin, targetPosition)
    local responsiveness = math.max(SilentAim.CameraLock.Smoothness, 0.01)
    local deltaTime = math.max(delta or 1 / 60, 1 / 300)
    local alpha = 1 - math.exp(-responsiveness * deltaTime * 120)
    local adjustedAlpha = math.clamp(alpha * (SilentAim.CameraLock.SensitivityMultiplier or 1), 0.01, 1)
    Camera.CFrame = cam.CFrame:Lerp(desired, adjustedAlpha)
end

RunService.RenderStepped:Connect(function(delta)
    velocityCleanupCounter += 1
    if velocityCleanupCounter >= 60 then
        velocityCleanupCounter = 0
        for part in pairs(velocityTracker) do
            if typeof(part) ~= "Instance" or not part.Parent then
                velocityTracker[part] = nil
            end
        end
    end

    local now = os.clock()
    local rageTargetActive = state.rageMode and rageTargetHoldUntil > now
    if SilentAim.Enabled and not state.rageMode then
        SilentAimSystem.acquireClosestTarget()
    elseif not rageTargetActive then
        currentTargetPart = nil
    end

    local allowFOV = SilentAim.Mode ~= "Raycast"
    local mousePos = SilentAimSystem.getAimPosition()

    if allowFOV and SilentAim.FOVVisible then
        fovCircle.Visible = true
        fovCircle.Position = mousePos
        fovCircle.Radius = SilentAim.FOVRadius
    else
        fovCircle.Visible = false
    end

    if SilentAim.ShowTarget and isAimAssistActive() then
        local target = currentTargetPart
        if target then
            local screenPos, onScreen = SilentAimSystem.worldToScreen(target.Position)
            if onScreen then
                targetBox.Visible = true
                targetBox.Position = Vector2.new(screenPos.X - 12, screenPos.Y - 12)
            else
                targetBox.Visible = false
            end
        else
            targetBox.Visible = false
        end
    else
        targetBox.Visible = false
    end

    if SilentAim.Mode == "Camera Lock" then
        SilentAimSystem.applyCameraLock(delta)
    end
    
    -- Triggerbot
    if SilentAim.Triggerbot then
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        if target and target.Parent then
            local player = Players:GetPlayerFromCharacter(target.Parent)
            if player and player ~= LocalPlayer and not SilentAimSystem.isFriendlyPlayer(player) then
                local hum = target.Parent:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    task.delay(SilentAim.TriggerbotDelay, function()
                        mouse1click()
                    end)
                end
            end
        end
    end
    
    -- Bunny Hop
    if state.bhop and Humanoid and Humanoid.FloorMaterial == Enum.Material.Air then
        Humanoid.Jump = true
    end
    
    -- Recoil Control
    if state.recoilControl and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local strength = state.recoilStrength or 5
        if mousemoverel then
            mousemoverel(0, strength)
        end
    end
end)

local namecallHandlers = {
    FindPartOnRay = function(old, self, ray, ...)
        local newRay = ray
        newRay = select(1, SilentAimSystem.adjustRay(ray))
        return old(self, newRay, ...)
    end,
    FindPartOnRayWithIgnoreList = function(old, self, ray, ...)
        local newRay, targetPart = SilentAimSystem.adjustRay(ray)
        if targetPart then
            local targetModel = targetPart.Parent or targetPart
            local ignoreList = select(1, ...)
            local adjusted = removeTargetFromList(ignoreList, targetModel)
            if adjusted ~= ignoreList then
                return old(self, newRay, adjusted, select(2, ...))
            end
        end
        return old(self, newRay, ...)
    end,
    FindPartOnRayWithWhitelist = function(old, self, ray, ...)
        local newRay, targetPart = SilentAimSystem.adjustRay(ray)
        if targetPart then
            local targetModel = targetPart.Parent or targetPart
            local whitelist = select(1, ...)
            local adjusted = ensureTargetInList(whitelist, targetModel)
            if adjusted ~= whitelist then
                return old(self, newRay, adjusted, select(2, ...))
            end
        end
        return old(self, newRay, ...)
    end,
    Raycast = function(old, self, origin, direction, ...)
        local newDirection, targetPart = SilentAimSystem.adjustDirection(origin, direction)
        if targetPart then
            local targetModel = targetPart.Parent or targetPart
            local params = select(1, ...)
            local adjustedParams = adjustRaycastParams(params, targetModel)
            if adjustedParams ~= params then
                return old(self, origin, newDirection, adjustedParams, select(2, ...))
            end
        end
        return old(self, origin, newDirection, ...)
    end,
    ScreenPointToRay = function(old, self, ...)
        local ray = old(self, ...)
        return select(1, SilentAimSystem.adjustRay(ray))
    end,
    ViewportPointToRay = function(old, self, ...)
        local ray = old(self, ...)
        return select(1, SilentAimSystem.adjustRay(ray))
    end
}

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local handler = namecallHandlers[method]

    if handler and not checkcaller() then
        if not isAimAssistActive() or SilentAim.Mode ~= "Raycast" or SilentAimSystem.shouldIgnoreCaller() then
            return oldNamecall(self, ...)
        end
        return handler(oldNamecall, self, ...)
    end

    return oldNamecall(self, ...)
end)

local oldRayNew
if hookfunction and typeof(Ray) == "table" and typeof(Ray.new) == "function" then
    oldRayNew = hookfunction(Ray.new, function(origin, direction, ...)
        if not checkcaller() and isAimAssistActive() and SilentAim.Mode == "Raycast" and not SilentAimSystem.shouldIgnoreCaller() and typeof(origin) == "Vector3" and typeof(direction) == "Vector3" then
            local newDirection = select(1, SilentAimSystem.adjustDirection(origin, direction))
            if newDirection ~= direction then
                return oldRayNew(origin, newDirection, ...)
            end
        end
        return oldRayNew(origin, direction, ...)
    end)
end

-- Mouse Hook
local mouse = LocalPlayer:GetMouse()
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, index)
    if self == mouse and not checkcaller() and isAimAssistActive() and SilentAim.Mode == "Raycast" then
        if shouldIgnoreCaller() then
            return oldIndex(self, index)
        end
        if index == "Hit" or index == "hit" or index == "Target" or index == "target" then
            local origin = Camera and Camera.CFrame and Camera.CFrame.Position
            if origin then
                local targetPart, targetPosition = resolveTargetSolution(origin, 0, true)
                if targetPart and targetPosition then
                    if index == "Hit" or index == "hit" then
                        return CFrame.new(targetPosition)
                    else
                        return targetPart
                    end
                end
            end
        end
    end
    return oldIndex(self, index)
end)

-- ========== COMBAT TAB UI ==========

local CombatMainSection = CombatTab:CreateSection("Silent Aim Controls")

CombatMainSection:CreateToggle({
    Name = "Enable Silent Aim",
    CurrentValue = SilentAim.Enabled,
    Callback = function(value)
        SilentAim.Enabled = value
        if not value then
            deactivateCameraHold()
        end
        queueConfigSave()
    end
})

CombatMainSection:CreateDropdown({
    Name = "Aim Mode",
    Options = {"Raycast", "Camera Lock"},
    CurrentOption = {SilentAim.Mode},
    Callback = function(value)
        setAimMode(value[1] or value)
    end
})

CombatMainSection:CreateDropdown({
    Name = "Target Mode",
    Options = {"Mouse", "Distance"},
    CurrentOption = {SilentAim.TargetMode},
    Callback = function(value)
        SilentAim.TargetMode = value[1] or value
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Triggerbot",
    CurrentValue = SilentAim.Triggerbot,
    Callback = function(value)
        SilentAim.Triggerbot = value
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Recoil Control",
    CurrentValue = state.recoilControl,
    Callback = function(value)
        state.recoilControl = value
        queueConfigSave()
    end
})

CombatMainSection:CreateSlider({
    Name = "Recoil Strength",
    Range = {1, 20},
    Increment = 1,
    CurrentValue = state.recoilStrength,
    Callback = function(value)
        state.recoilStrength = value
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Team Check",
    CurrentValue = SilentAim.TeamCheck,
    Callback = function(value)
        SilentAim.TeamCheck = value
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Silent Aim AC Bypass",
    CurrentValue = bypassSettings.SilentAim,
    Callback = function(value)
        bypassSettings.SilentAim = value
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Wall Check",
    CurrentValue = SilentAim.WallCheck,
    Callback = function(value)
        SilentAim.WallCheck = value
        queueConfigSave()
    end
})

CombatMainSection:CreateSlider({
    Name = "Max Distance",
    Range = {100, 3000},
    Increment = 10,
    CurrentValue = SilentAim.MaxDistance,
    Callback = function(value)
        SilentAim.MaxDistance = value
        queueConfigSave()
    end
})

CombatMainSection:CreateDropdown({
    Name = "Target Part",
    Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    CurrentOption = {SilentAim.TargetPart},
    Callback = function(value)
        SilentAim.TargetPart = value[1] or value
        queueConfigSave()
    end
})

CombatMainSection:CreateSlider({
    Name = "Hit Chance %",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = SilentAim.HitChance,
    Callback = function(value)
        SilentAim.HitChance = value
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Prediction",
    CurrentValue = SilentAim.Prediction,
    Callback = function(value)
        SilentAim.Prediction = value
        queueConfigSave()
    end
})

CombatMainSection:CreateSlider({
    Name = "Prediction Amount",
    Range = {0.01, 0.5},
    Increment = 0.01,
    CurrentValue = SilentAim.PredictionAmount,
    Callback = function(value)
        SilentAim.PredictionAmount = math.clamp(value, 0.01, 0.5)
        queueConfigSave()
    end
})

CombatMainSection:CreateToggle({
    Name = "Rage Mode",
    CurrentValue = state.rageMode,
    Callback = function(value)
        state.rageMode = value
        if value then
            if RageSystem and RageSystem.startRageMode then
                RageSystem.startRageMode()
            else
                warn("RageSystem.startRageMode is missing")
            end
        else
            if RageSystem and RageSystem.stopRageMode then
                RageSystem.stopRageMode()
            end
        end
        queueConfigSave()
    end
})



local CombatVisualsSection = CombatTab:CreateSection("Visuals & FOV")

CombatVisualsSection:CreateToggle({
    Name = "Show FOV Circle",
    CurrentValue = SilentAim.FOVVisible,
    Callback = function(value)
        if SilentAim.Mode == "Raycast" and value then
            SilentAim.FOVVisible = false
            Luna:Notification({
                Title = "Silent Aim",
                Content = "FOV circle is disabled in Raycast mode.",
                Icon = "warning"
            })
            return
        end
        SilentAim.FOVVisible = value
        queueConfigSave()
    end
})

CombatVisualsSection:CreateSlider({
    Name = "FOV Radius",
    Range = {50, 500},
    Increment = 5,
    CurrentValue = SilentAim.FOVRadius,
    Callback = function(value)
        SilentAim.FOVRadius = value
        queueConfigSave()
    end
})

CombatVisualsSection:CreateColorPicker({
    Name = "FOV Color",
    Color = fovCircle.Color,
    Callback = function(color)
        fovCircle.Color = color
        queueConfigSave()
    end
})

local CameraSec = CombatTab:CreateSection("Camera Lock Settings")

cameraControls.smoothSlider = CameraSec:CreateSlider({
    Name = "Camera Smoothness",
    Range = {0.01, 3},
    Increment = 0.01,
    CurrentValue = SilentAim.CameraLock.Smoothness,
    Callback = function(value)
        SilentAim.CameraLock.Smoothness = math.clamp(value, 0.01, 3)
        queueConfigSave()
    end
})

cameraControls.sensitivitySlider = CameraSec:CreateSlider({
    Name = "Sensitivity Multiplier",
    Range = {0.05, 2},
    Increment = 0.05,
    CurrentValue = SilentAim.CameraLock.SensitivityMultiplier,
    Callback = function(value)
        SilentAim.CameraLock.SensitivityMultiplier = math.clamp(value, 0.05, 2)
        queueConfigSave()
    end
})

cameraControls.holdToggle = CameraSec:CreateToggle({
    Name = "Hold To Lock",
    CurrentValue = SilentAim.CameraLock.HoldToLock,
    Callback = function(value)
        SilentAim.CameraLock.HoldToLock = value
        if not value then
            deactivateCameraHold()
        end
        updateCameraOptionVisibility()
        queueConfigSave()
    end
})

cameraControls.holdReleaseSlider = CameraSec:CreateSlider({
    Name = "Hold Release Duration (s)",
    Range = {0, 1.5},
    Increment = 0.05,
    CurrentValue = SilentAim.CameraLock.HoldReleaseDuration,
    Callback = function(value)
        SilentAim.CameraLock.HoldReleaseDuration = math.clamp(value, 0, 1.5)
        cancelCameraHoldRelease()
        queueConfigSave()
    end
})

cameraControls.holdDropdown = CameraSec:CreateDropdown({
    Name = "Hold Input",
    Options = cameraHoldOptionList,
    CurrentOption = {SilentAim.CameraLock.HoldInput},
    Callback = function(value)
        local selected = value[1] or value
        if cameraHoldOptions[selected] then
            SilentAim.CameraLock.HoldInput = selected
            deactivateCameraHold()
            queueConfigSave()
        end
    end
})

setAimMode(SilentAim.Mode)

CombatVisualsSection:CreateToggle({
    Name = "Show Target Box",
    CurrentValue = SilentAim.ShowTarget,
    Callback = function(value)
        SilentAim.ShowTarget = value
        queueConfigSave()
    end
})

CombatVisualsSection:CreateColorPicker({
    Name = "Target Color",
    Color = targetBox.Color,
    Callback = function(color)
        targetBox.Color = color
        queueConfigSave()
    end
})



-- ========== MOVEMENT TAB ==========
local MovementTab = Window:CreateTab({
    Name = "Movement",
    Icon = "directions_run",
    ImageSource = "Material"
})

local MovementMainSection = MovementTab:CreateSection("Fly & Movement")

MovementMainSection:CreateToggle({
    Name = "Fly (WASD, E, Q)",
    CurrentValue = false,
    Callback = function(val)
        state.fly = val
        if not val then
            FlySystem.cleanupFlyState()
        else
            FlySystem.beginFly()
        end
        queueConfigSave()
    end
})

MovementMainSection:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 10},
    Increment = 0.5,
    CurrentValue = 1,
    Callback = function(v)
        state.flySpeed = v
    end
})

local flyModeOptions = {"BodyVelocity", "CFrame"}
MovementMainSection:CreateDropdown({
    Name = "Fly Mode",
    Options = flyModeOptions,
    CurrentOption = {state.flyMode},
    Callback = function(val)
        state.flyMode = val[1] or val
        if state.fly then
            FlySystem.beginFly()
        end
    end
})

MovementMainSection:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(val)
        state.noclip = val
        if connections.noclip then connections.noclip:Disconnect(); connections.noclip = nil end
        
        if val then
            connections.noclip = RunService.Stepped:Connect(function()
                for _, p in pairs(Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end)
        end
        queueConfigSave()
    end
})

local CharacterSection = MovementTab:CreateSection("Character Properties")

CharacterSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
    Increment = 1,
    CurrentValue = state.desiredWalkSpeed,
    Callback = function(value)
        state.desiredWalkSpeed = value
        if Humanoid then Humanoid.WalkSpeed = value end
        if bypassSettings.Movement then
            enforceHumanoidProperty("WalkSpeed", value)
        end
        queueConfigSave()
    end
})

CharacterSection:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 1,
    CurrentValue = state.desiredJumpPower,
    Callback = function(value)
        state.desiredJumpPower = value
        if Humanoid then Humanoid.JumpPower = value end
        if bypassSettings.Movement then
            enforceHumanoidProperty("JumpPower", value)
        end
        queueConfigSave()
    end
})

CharacterSection:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(val)
        state.infJump = val
        if connections.infJump then connections.infJump:Disconnect(); connections.infJump = nil end
        
        if val then
            connections.infJump = UserInputService.JumpRequest:Connect(function()
                if state.infJump and Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        end
        queueConfigSave()
    end
})

CharacterSection:CreateToggle({
    Name = "Bunny Hop",
    CurrentValue = state.bhop,
    Callback = function(val)
        state.bhop = val
        queueConfigSave()
    end
})

CharacterSection:CreateToggle({
    Name = "Movement Anti-Cheat Bypass",
    CurrentValue = bypassSettings.Movement,
    Callback = function(value)
        bypassSettings.Movement = value
        refreshMovementBypass()
        queueConfigSave()
    end
})

CharacterSection:CreateSlider({
    Name = "Hip Height",
    Range = {0, 50},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(v)
        if Humanoid then Humanoid.HipHeight = v end
    end
})





-- ========== ADVANCED DRAWING ESP ==========

local ESPSystem = {}
ESPSystem.Objects = {}

function ESPSystem.createDrawingObject(type, properties)
    local drawing = createDrawing(type)
    for prop, val in pairs(properties) do
        drawing[prop] = val
    end
    return drawing
end

function ESPSystem.removeDrawingObject(obj)
    if obj then
        obj.Visible = false
        if obj.Remove then obj:Remove() end
    end
end

function ESPSystem.clearESP(player)
    if ESPSystem.Objects[player] then
        for _, obj in pairs(ESPSystem.Objects[player]) do
            ESPSystem.removeDrawingObject(obj)
        end
        ESPSystem.Objects[player] = nil
    end
end

function ESPSystem.getBoundingBox(character)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local min, max = Vector2.new(math.huge, math.huge), Vector2.new(-math.huge, -math.huge)
    local parts = {rootPart, character:FindFirstChild("Head")}
    
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            table.insert(parts, part)
        end
    end

    for _, part in pairs(parts) do
        local cf = part.CFrame
        local size = part.Size
        local corners = {
            cf * CFrame.new(size.X/2, size.Y/2, size.Z/2),
            cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2),
            cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2),
            cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2),
            cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2),
            cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2),
            cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2),
            cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2)
        }
        
        for _, corner in pairs(corners) do
            local screenPos, onScreen = Camera:WorldToViewportPoint(corner.Position)
            if onScreen then
                min = Vector2.new(math.min(min.X, screenPos.X), math.min(min.Y, screenPos.Y))
                max = Vector2.new(math.max(max.X, screenPos.X), math.max(max.Y, screenPos.Y))
            end
        end
    end
    
    return min, max
end

function ESPSystem.updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")
        
        if not character or not rootPart or not humanoid or humanoid.Health <= 0 then
            ESPSystem.clearESP(player)
            continue
        end
        
        if VisualsSettings.ESP.TeamCheck and SilentAimSystem.isFriendlyPlayer(player) then
            ESPSystem.clearESP(player)
            continue
        end
        
        if not VisualsSettings.ESP.Enabled then
            ESPSystem.clearESP(player)
            continue
        end
        
        if not ESPSystem.Objects[player] then
            ESPSystem.Objects[player] = {
                Box = ESPSystem.createDrawingObject("Square", {Thickness = 1, Filled = false, ZIndex = 2}),
                BoxOutline = ESPSystem.createDrawingObject("Square", {Thickness = 3, Filled = false, ZIndex = 1, Color = Color3.new(0,0,0)}),
                HealthBar = ESPSystem.createDrawingObject("Square", {Filled = true, ZIndex = 2}),
                HealthBarOutline = ESPSystem.createDrawingObject("Square", {Thickness = 1, Filled = false, ZIndex = 1, Color = Color3.new(0,0,0)}),
                Name = ESPSystem.createDrawingObject("Text", {Center = true, Outline = true, Size = VisualsSettings.ESP.TextSize, Font = VisualsSettings.ESP.Font, ZIndex = 3}),
                Distance = ESPSystem.createDrawingObject("Text", {Center = true, Outline = true, Size = VisualsSettings.ESP.TextSize, Font = VisualsSettings.ESP.Font, ZIndex = 3}),
                Tracer = ESPSystem.createDrawingObject("Line", {Thickness = 1, ZIndex = 2}),
                Arrow = ESPSystem.createDrawingObject("Triangle", {Thickness = 1, Filled = true, ZIndex = 2})
            }
        end
        
        local objs = ESPSystem.Objects[player]
        local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
        
        if onScreen then
            -- Box
            if VisualsSettings.ESP.Box then
                local min, max = ESPSystem.getBoundingBox(character)
                if min and max then
                    local size = max - min
                    local position = min
                    
                    objs.Box.Visible = true
                    objs.Box.Size = size
                    objs.Box.Position = position
                    objs.Box.Color = VisualsSettings.ESP.BoxColor
                    
                    if VisualsSettings.ESP.BoxOutline then
                        objs.BoxOutline.Visible = true
                        objs.BoxOutline.Size = size
                        objs.BoxOutline.Position = position
                    else
                        objs.BoxOutline.Visible = false
                    end
                    
                    -- Health Bar
                    if VisualsSettings.ESP.HealthBar then
                        local healthPct = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                        local barHeight = size.Y * healthPct
                        local barWidth = 2
                        local barPos = Vector2.new(position.X - 5, position.Y + (size.Y - barHeight))
                        
                        objs.HealthBar.Visible = true
                        objs.HealthBar.Size = Vector2.new(barWidth, barHeight)
                        objs.HealthBar.Position = barPos
                        objs.HealthBar.Color = Color3.fromHSV(healthPct * 0.3, 1, 1)
                        
                        objs.HealthBarOutline.Visible = true
                        objs.HealthBarOutline.Size = Vector2.new(barWidth + 2, size.Y + 2)
                        objs.HealthBarOutline.Position = Vector2.new(position.X - 6, position.Y - 1)
                    else
                        objs.HealthBar.Visible = false
                        objs.HealthBarOutline.Visible = false
                    end
                else
                    objs.Box.Visible = false
                    objs.BoxOutline.Visible = false
                    objs.HealthBar.Visible = false
                    objs.HealthBarOutline.Visible = false
                end
            else
                objs.Box.Visible = false
                objs.BoxOutline.Visible = false
                objs.HealthBar.Visible = false
                objs.HealthBarOutline.Visible = false
            end
            
            -- Name & Distance
            local topPos = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0)) -- Approx head top
            local bottomPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
            
            if VisualsSettings.ESP.Name then
                objs.Name.Visible = true
                objs.Name.Text = player.Name
                objs.Name.Position = Vector2.new(topPos.X, topPos.Y - 15)
                objs.Name.Color = VisualsSettings.ESP.NameColor
                objs.Name.Size = VisualsSettings.ESP.TextSize
            else
                objs.Name.Visible = false
            end
            
            if VisualsSettings.ESP.Distance then
                objs.Distance.Visible = true
                objs.Distance.Text = math.floor(dist) .. "m"
                objs.Distance.Position = Vector2.new(bottomPos.X, bottomPos.Y + 5)
                objs.Distance.Color = Color3.new(1,1,1)
                objs.Distance.Size = VisualsSettings.ESP.TextSize
            else
                objs.Distance.Visible = false
            end
            
            -- Tracers
            if VisualsSettings.ESP.Tracers then
                objs.Tracer.Visible = true
                objs.Tracer.Color = VisualsSettings.ESP.TracerColor
                objs.Tracer.To = Vector2.new(vector.X, vector.Y)
                
                local origin = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Bottom
                if VisualsSettings.ESP.TracerOrigin == "Center" then
                    origin = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                elseif VisualsSettings.ESP.TracerOrigin == "Mouse" then
                    origin = UserInputService:GetMouseLocation()
                end
                objs.Tracer.From = origin
            else
                objs.Tracer.Visible = false
            end
            
            objs.Arrow.Visible = false
        else
            -- Offscreen
            objs.Box.Visible = false
            objs.BoxOutline.Visible = false
            objs.HealthBar.Visible = false
            objs.HealthBarOutline.Visible = false
            objs.Name.Visible = false
            objs.Distance.Visible = false
            objs.Tracer.Visible = false
            
            if VisualsSettings.ESP.OffscreenArrows then
                objs.Arrow.Visible = true
                objs.Arrow.Color = VisualsSettings.ESP.ArrowColor
                
                local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local relative = (rootPart.Position - Camera.CFrame.Position)
                local angle = math.atan2(relative.Z, relative.X) - math.atan2(Camera.CFrame.LookVector.Z, Camera.CFrame.LookVector.X)
                
                -- Adjust angle for camera rotation
                -- This is a simplified 2D projection, might need refinement for full 3D rotation support
                
                local radius = VisualsSettings.ESP.ArrowRadius
                local arrowPos = center + Vector2.new(math.cos(angle) * radius, math.sin(angle) * radius)
                
                -- Draw triangle pointing to target
                -- ... (Simplified for now, just a dot/small triangle)
                -- Implementing full arrow rotation math is complex in this snippet, leaving as TODO or simple indicator
                
                -- For now, just hide arrows to avoid visual glitches until full math is added
                objs.Arrow.Visible = false 
            else
                objs.Arrow.Visible = false
            end
        end
    end
end

RunService.RenderStepped:Connect(ESPSystem.updateESP)

-- ========== VISUALS TAB ==========
local VisualsTab = Window:CreateTab({
    Name = "Visuals",
    Icon = "visibility",
    ImageSource = "Material"
})

local function applyESP(character)
    if not character or not state.esp then return end
    task.spawn(function()
        if not character.Parent then character.AncestryChanged:Wait() end
        if not character.Parent then return end
        local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("Head", 5)
        if not head then return end

        local highlight = character:FindFirstChild("ESP")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "ESP"
            highlight.Adornee = character
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = character
            highlight:SetAttribute("ManagedByAero", true)
            highlight.AncestryChanged:Connect(function(_, parent)
                if parent == nil and state.esp and character.Parent then
                    task.delay(0.1, function() if character.Parent and state.esp then applyESP(character) end end)
                end
            end)
        end
        highlight.FillColor = espColor
        highlight.OutlineColor = espOutlineColor
        highlight.Enabled = true
    end)
end

local function removeESP(character)
    if character then local e = character:FindFirstChild("ESP") if e then e:Destroy() end end
end

connections.espPlayers = connections.espPlayers or {}

local function connectPlayerESP(player)
    if not player or player == LocalPlayer then return end
    if connections.espPlayers[player] then connections.espPlayers[player]:Disconnect() end
    connections.espPlayers[player] = player.CharacterAdded:Connect(function(character)
        if state.esp then applyESP(character) else removeESP(character) end
    end)
    if player.Character then if state.esp then applyESP(player.Character) else removeESP(player.Character) end end
end

local function disconnectPlayerESP(player)
    if connections.espPlayers[player] then
        connections.espPlayers[player]:Disconnect()
        connections.espPlayers[player] = nil
    end
end

local function refreshESPConnections()
    for player, conn in pairs(connections.espPlayers) do
        if not player or not conn or not player.Parent then
            if conn then conn:Disconnect() end
            connections.espPlayers[player] = nil
        end
    end
    if state.esp then for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer then connectPlayerESP(player) end end end
end

if not connections.espPlayerAdded then
    connections.espPlayerAdded = Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer and state.esp then connectPlayerESP(player) end
    end)
end

if not connections.espPlayerRemoving then
    connections.espPlayerRemoving = Players.PlayerRemoving:Connect(function(player)
        if connections.espPlayers[player] then connections.espPlayers[player]:Disconnect() connections.espPlayers[player] = nil end
    end)
end

if state.esp then
    refreshESPConnections()
end

local ESPSection = VisualsTab:CreateSection("ESP Settings")

ESPSection:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = VisualsSettings.ESP.Enabled,
    Callback = function(value)
        VisualsSettings.ESP.Enabled = value
        queueConfigSave()
    end
})

ESPSection:CreateToggle({
    Name = "Box ESP",
    CurrentValue = VisualsSettings.ESP.Box,
    Callback = function(value)
        VisualsSettings.ESP.Box = value
        queueConfigSave()
    end
})

ESPSection:CreateColorPicker({
    Name = "Box Color",
    Color = VisualsSettings.ESP.BoxColor,
    Callback = function(c)
        VisualsSettings.ESP.BoxColor = c
        queueConfigSave()
    end
})

ESPSection:CreateToggle({
    Name = "Health Bar",
    CurrentValue = VisualsSettings.ESP.HealthBar,
    Callback = function(value)
        VisualsSettings.ESP.HealthBar = value
        queueConfigSave()
    end
})

ESPSection:CreateToggle({
    Name = "Name ESP",
    CurrentValue = VisualsSettings.ESP.Name,
    Callback = function(value)
        VisualsSettings.ESP.Name = value
        queueConfigSave()
    end
})

ESPSection:CreateToggle({
    Name = "Distance ESP",
    CurrentValue = VisualsSettings.ESP.Distance,
    Callback = function(value)
        VisualsSettings.ESP.Distance = value
        queueConfigSave()
    end
})

ESPSection:CreateToggle({
    Name = "Tracers",
    CurrentValue = VisualsSettings.ESP.Tracers,
    Callback = function(value)
        VisualsSettings.ESP.Tracers = value
        queueConfigSave()
    end
})

ESPSection:CreateDropdown({
    Name = "Tracer Origin",
    Options = {"Bottom", "Center", "Mouse"},
    CurrentOption = {VisualsSettings.ESP.TracerOrigin},
    Callback = function(value)
        VisualsSettings.ESP.TracerOrigin = value[1] or value
        queueConfigSave()
    end
})

ESPSection:CreateToggle({
    Name = "Team Check",
    CurrentValue = VisualsSettings.ESP.TeamCheck,
    Callback = function(value)
        VisualsSettings.ESP.TeamCheck = value
        queueConfigSave()
    end
})

-- Legacy Chams (Highlight)
local ChamsSection = VisualsTab:CreateSection("Chams (Highlight)")

ChamsSection:CreateToggle({
    Name = "Enable Chams",
    CurrentValue = state.esp,
    Callback = function(value)
        state.esp = value
        if value then
            refreshESPConnections()
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    if player.Character then
                        removeESP(player.Character)
                    end
                    disconnectPlayerESP(player)
                end
            end
        end
        queueConfigSave()
    end
})

ChamsSection:CreateColorPicker({
    Name = "Chams Fill Color",
    Color = espColor,
    Callback = function(c)
        espColor = c
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local e = p.Character:FindFirstChild("ESP")
                if e and e:IsA("Highlight") then e.FillColor = espColor end
            end
        end
    end
})

ChamsSection:CreateColorPicker({
    Name = "Chams Outline Color",
    Color = espOutlineColor,
    Callback = function(c)
        espOutlineColor = c
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local e = p.Character:FindFirstChild("ESP")
                if e and e:IsA("Highlight") then e.OutlineColor = espOutlineColor end
            end
        end
    end
})

local CameraSection = VisualsTab:CreateSection("Camera")

connections.nameplates = connections.nameplates or {}

local function applyNameplate(character, player)
    if not character or not player or character:FindFirstChild("IY_NAMEPLATE") then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local holder = Instance.new("BillboardGui")
    holder.Name = "IY_NAMEPLATE"
    holder.Adornee = head
    holder.Size = UDim2.new(0, 150, 0, 50)
    holder.StudsOffset = Vector3.new(0, 2.2, 0)
    holder.AlwaysOnTop = true
    holder.Parent = character
    
    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.Text = player.Name
end

local function removeNameplate(character)
    if not character then return end
    local inst = character:FindFirstChild("IY_NAMEPLATE")
    if inst then inst:Destroy() end
end

ESPSection:CreateToggle({
    Name = "Nameplates",
    CurrentValue = false,
    Callback = function(v)
        state.nameplates = v
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if v then
                    if p.Character then applyNameplate(p.Character, p) end
                    if not connections.nameplates[p] then
                        connections.nameplates[p] = p.CharacterAdded:Connect(function(c)
                            if state.nameplates then applyNameplate(c, p) end
                        end)
                    end
                else
                    if p.Character then removeNameplate(p.Character) end
                    if connections.nameplates[p] then
                        connections.nameplates[p]:Disconnect()
                        connections.nameplates[p] = nil
                    end
                end
            end
        end
    end
})

-- ========== GAME TAB ==========
local GameTab = Window:CreateTab({
    Name = "Game",
    Icon = "games",
    ImageSource = "Material"
})

local GameSection = GameTab:CreateSection("Game Settings")

GameSection:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(v)
        state.antiAFK = v
        if connections.antiAFK then
            connections.antiAFK:Disconnect()
            connections.antiAFK = nil
        end
        if v then
            connections.antiAFK = LocalPlayer.Idled:Connect(function()
                if state.antiAFK and VirtualUser then
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end
            end)
        end
        queueConfigSave()
    end
})

GameSection:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

GameSection:CreateSlider({
    Name = "Gravity",
    Range = {0, 196},
    Increment = 1,
    CurrentValue = state.desiredGravity,
    Callback = function(value)
        state.desiredGravity = value
        workspace.Gravity = value
        if bypassSettings.Movement then
            enforceGravity()
        end
        queueConfigSave()
    end
})




            


OtherSection:CreateToggle({
    Name = "Music",
    CurrentValue = false,
    Callback = function(v)
        local sound = state.musicSound
        if v then
            if not sound or not sound.Parent then
                sound = Instance.new("Sound")
                sound.Name = "AeroMusic"
                sound.SoundId = "rbxassetid://142376088"
                sound.Looped = true
                sound.Volume = 0.5
                sound.Parent = workspace
                sound:Play()
                sound.Loaded:Connect(function()
                    print("Music loaded successfully!")
                end)
                sound.SoundFailedToLoad:Connect(function(id, err)
                    warn("Music failed: " .. err)
                end)
                state.musicSound = sound
            end
        else
            if sound and sound.Parent then
                sound:Stop()
                sound:Destroy()
            end
            state.musicSound = nil
        end
    end
})

-- Character Added Handler
LocalPlayer.CharacterAdded:Connect(function(c)
    task.wait(0.1)
    Character = c
    Humanoid = c:FindFirstChild("Humanoid") or c:WaitForChild("Humanoid")
    RootPart = c:FindFirstChild("HumanoidRootPart") or c:WaitForChild("HumanoidRootPart")

    if Humanoid then
        Humanoid.WalkSpeed = state.desiredWalkSpeed
        Humanoid.JumpPower = state.desiredJumpPower
    end

    refreshMovementBypass()

    if state.rageMode then
        if RageSystem and RageSystem.startRageMode then
            RageSystem.startRageMode()
        end
    end
    
    if state.noclip and connections.noclip then
        connections.noclip:Disconnect()
        connections.noclip = RunService.Stepped:Connect(function()
            for _, p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end)
    end
    
    if state.esp then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then applyESP(p.Character) end
        end
    end
end)

-- Startup
pcall(function()
    if Luna and Luna.LoadAutoLoadConfig then Luna:LoadAutoLoadConfig() end
end)

-- Startup Notifications
task.spawn(function()
    Luna:Notification({Title = "Aero Hub", Content = "Script Loaded Successfully", Icon = "check_circle", Duration = 3})
end)


