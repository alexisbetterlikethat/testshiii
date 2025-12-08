-- Improved Rivals Script
-- Based on MinirickHub structure + Aero performance optimizations
-- Key: MiniRivals99

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Settings
local Settings = {
    Combat = {
        SilentAim = false,
        AimbotEnabled = false,
        AutoShoot = false,
        ShowFOV = true,
        FOVRadius = 150,
        Smoothness = 0.15,
        TeamCheck = true,
        VisibilityCheck = false,
        MaxDistance = 500,
        TargetPart = "Head",
        Prediction = true,
        PredictionAmount = 0.12,
        StickToTarget = true, -- Keeps targeting same player
    },
    ESP = {
        Enabled = false,
        Glow = true,
        Box = false,
        Tracers = false,
        Distance = false,
        GlowColor = Color3.fromRGB(255, 50, 50),
        BoxColor = Color3.fromRGB(255, 255, 255),
        TracerColor = Color3.fromRGB(255, 0, 0),
        MaxDistance = 800,
    },
    Movement = {
        InfiniteJump = false,
        WalkSpeed = 16,
        JumpPower = 50,
    },
    Visual = {
        RainbowFOV = false,
        RainbowESP = false,
        FOVThickness = 2,
        RainbowSpeed = 0.002,
    }
}

-- State
local CurrentTarget = nil
local LastTargetTime = 0
local AimbotActive = false
local FOVCircle = nil
local ESPObjects = {}

-- Utility Functions
local function isAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") 
        and player.Character.Humanoid.Health > 0 
        and player.Character:FindFirstChild("HumanoidRootPart")
end

local function getTargetPart(player)
    if not player.Character then return nil end
    return player.Character:FindFirstChild(Settings.Combat.TargetPart) 
        or player.Character:FindFirstChild("HumanoidRootPart")
end

local function getPredictedPosition(part)
    if not Settings.Combat.Prediction or not part then
        return part and part.Position
    end
    local velocity = part.AssemblyLinearVelocity or part.Velocity or Vector3.zero
    return part.Position + (velocity * Settings.Combat.PredictionAmount)
end

local function isVisible(origin, target)
    if not Settings.Combat.VisibilityCheck then return true end
    
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    
    local result = Workspace:Raycast(origin, target - origin, rayParams)
    return not result or result.Instance:IsDescendantOf(Players:GetPlayerFromCharacter(result.Instance.Parent).Character)
end

local function getClosestPlayerInFOV(preferTarget)
    local closest = nil
    local closestDistance = math.huge
    local mousePos = UserInputService.TouchEnabled and 
        Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) or
        Vector2.new(Mouse.X, Mouse.Y)
    
    -- Sticky targeting: prefer keeping current target if still valid
    if Settings.Combat.StickToTarget and preferTarget and isAlive(preferTarget) then
        local part = getTargetPart(preferTarget)
        if part then
            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local distance2D = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                local distance3D = (part.Position - Camera.CFrame.Position).Magnitude
                
                if distance2D <= Settings.Combat.FOVRadius and distance3D <= Settings.Combat.MaxDistance then
                    if isVisible(Camera.CFrame.Position, part.Position) then
                        return preferTarget -- Keep current target
                    end
                end
            end
        end
    end
    
    -- Find new target
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) then
            if Settings.Combat.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPart = getTargetPart(player)
            if targetPart then
                local distance3D = (targetPart.Position - Camera.CFrame.Position).Magnitude
                
                if distance3D <= Settings.Combat.MaxDistance then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    
                    if onScreen then
                        local distance2D = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        
                        if distance2D <= Settings.Combat.FOVRadius then
                            if isVisible(Camera.CFrame.Position, targetPart.Position) then
                                -- Score system: prioritize closer targets
                                local score = (distance2D / Settings.Combat.FOVRadius) * 0.7 + 
                                            (distance3D / Settings.Combat.MaxDistance) * 0.3
                                
                                if score < closestDistance then
                                    closestDistance = score
                                    closest = player
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closest
end

-- FOV Circle Setup
local function createFOVCircle()
    if not Drawing then
        warn("Drawing library not available")
        return
    end
    
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = Settings.Visual.FOVThickness
    FOVCircle.NumSides = 64
    FOVCircle.Radius = Settings.Combat.FOVRadius
    FOVCircle.Filled = false
    FOVCircle.Visible = Settings.Combat.ShowFOV
    FOVCircle.Color = Color3.fromRGB(0, 200, 255)
    FOVCircle.Transparency = 0.7
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end

-- Silent Aim Hook (intercepts Mouse.Hit for weapon raycast redirection)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if Settings.Combat.SilentAim and (method == "FireServer" or method == "InvokeServer") then
        local args = {...}
        
        -- Check if this is a weapon fire event
        if typeof(self) == "Instance" and self:IsA("RemoteEvent") then
            local target = CurrentTarget
            if target and isAlive(target) then
                local part = getTargetPart(target)
                if part then
                    local predictedPos = getPredictedPosition(part)
                    
                    -- Replace the target position in arguments
                    for i, arg in ipairs(args) do
                        if typeof(arg) == "Vector3" then
                            args[i] = predictedPos
                            break
                        elseif typeof(arg) == "CFrame" then
                            args[i] = CFrame.new(predictedPos)
                            break
                        end
                    end
                    
                    return oldNamecall(self, unpack(args))
                end
            end
        end
    end
    
    return oldNamecall(self, ...)
end)

-- Aimbot (Camera manipulation)
local function performAimbot(deltaTime)
    if not Settings.Combat.AimbotEnabled then return end
    
    local target = getClosestPlayerInFOV(CurrentTarget)
    CurrentTarget = target
    
    if target and isAlive(target) then
        local targetPart = getTargetPart(target)
        if targetPart then
            local predictedPos = getPredictedPosition(targetPart)
            local targetDirection = (predictedPos - Camera.CFrame.Position).Unit
            local currentDirection = Camera.CFrame.LookVector
            
            -- Smooth interpolation
            local smoothFactor = math.clamp(Settings.Combat.Smoothness * deltaTime * 60, 0, 1)
            local newDirection = currentDirection:Lerp(targetDirection, smoothFactor)
            
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + newDirection)
        end
    end
end

-- ESP System
local function clearESP()
    for _, objects in pairs(ESPObjects) do
        if objects.Highlight then objects.Highlight:Destroy() end
        if objects.Box then objects.Box:Remove() end
        if objects.Tracer then objects.Tracer:Remove() end
        if objects.Distance then objects.Distance:Remove() end
    end
    ESPObjects = {}
end

local function updateESP()
    if not Settings.ESP.Enabled then
        clearESP()
        return
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) then
            local char = player.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            local distance = root and (root.Position - Camera.CFrame.Position).Magnitude or math.huge
            
            if distance <= Settings.ESP.MaxDistance then
                if not ESPObjects[player] then
                    ESPObjects[player] = {}
                end
                
                -- Glow ESP (Highlight)
                if Settings.ESP.Glow then
                    if not ESPObjects[player].Highlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = char
                        highlight.FillColor = Settings.ESP.GlowColor
                        highlight.OutlineColor = Settings.ESP.GlowColor
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = char
                        ESPObjects[player].Highlight = highlight
                    end
                    
                    if Settings.Visual.RainbowESP then
                        local hue = (tick() * Settings.Visual.RainbowSpeed) % 1
                        ESPObjects[player].Highlight.FillColor = Color3.fromHSV(hue, 1, 1)
                        ESPObjects[player].Highlight.OutlineColor = Color3.fromHSV(hue, 1, 1)
                    end
                elseif ESPObjects[player].Highlight then
                    ESPObjects[player].Highlight:Destroy()
                    ESPObjects[player].Highlight = nil
                end
                
                -- Box/Tracer ESP (requires Drawing library)
                if Drawing and root then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    
                    if onScreen then
                        -- Box ESP
                        if Settings.ESP.Box then
                            if not ESPObjects[player].Box then
                                ESPObjects[player].Box = Drawing.new("Square")
                                ESPObjects[player].Box.Thickness = 1
                                ESPObjects[player].Box.Filled = false
                            end
                            
                            local head = char:FindFirstChild("Head")
                            local headPos = head and Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                            local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 2.5, 0))
                            
                            local height = math.abs(headPos.Y - legPos.Y)
                            local width = height * 0.6
                            
                            ESPObjects[player].Box.Size = Vector2.new(width, height)
                            ESPObjects[player].Box.Position = Vector2.new(headPos.X - width/2, headPos.Y)
                            ESPObjects[player].Box.Color = Settings.ESP.BoxColor
                            ESPObjects[player].Box.Visible = true
                        elseif ESPObjects[player].Box then
                            ESPObjects[player].Box.Visible = false
                        end
                        
                        -- Tracer ESP
                        if Settings.ESP.Tracers then
                            if not ESPObjects[player].Tracer then
                                ESPObjects[player].Tracer = Drawing.new("Line")
                                ESPObjects[player].Tracer.Thickness = 1
                            end
                            
                            ESPObjects[player].Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            ESPObjects[player].Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            ESPObjects[player].Tracer.Color = Settings.ESP.TracerColor
                            ESPObjects[player].Tracer.Visible = true
                        elseif ESPObjects[player].Tracer then
                            ESPObjects[player].Tracer.Visible = false
                        end
                        
                        -- Distance ESP
                        if Settings.ESP.Distance then
                            if not ESPObjects[player].Distance then
                                ESPObjects[player].Distance = Drawing.new("Text")
                                ESPObjects[player].Distance.Size = 13
                                ESPObjects[player].Distance.Center = true
                                ESPObjects[player].Distance.Outline = true
                            end
                            
                            ESPObjects[player].Distance.Text = string.format("%dm", math.floor(distance))
                            ESPObjects[player].Distance.Position = Vector2.new(screenPos.X, screenPos.Y)
                            ESPObjects[player].Distance.Color = Color3.fromRGB(255, 255, 255)
                            ESPObjects[player].Distance.Visible = true
                        elseif ESPObjects[player].Distance then
                            ESPObjects[player].Distance.Visible = false
                        end
                    end
                end
            else
                -- Player out of range
                if ESPObjects[player] then
                    if ESPObjects[player].Highlight then ESPObjects[player].Highlight:Destroy() end
                    if ESPObjects[player].Box then ESPObjects[player].Box:Remove() end
                    if ESPObjects[player].Tracer then ESPObjects[player].Tracer:Remove() end
                    if ESPObjects[player].Distance then ESPObjects[player].Distance:Remove() end
                    ESPObjects[player] = nil
                end
            end
        end
    end
end

-- Main Loop
RunService.RenderStepped:Connect(function(deltaTime)
    -- Update FOV Circle
    if FOVCircle then
        FOVCircle.Visible = Settings.Combat.ShowFOV
        FOVCircle.Radius = Settings.Combat.FOVRadius
        FOVCircle.Thickness = Settings.Visual.FOVThickness
        
        if Settings.Visual.RainbowFOV then
            local hue = (tick() * Settings.Visual.RainbowSpeed) % 1
            FOVCircle.Color = Color3.fromHSV(hue, 1, 1)
        else
            FOVCircle.Color = Color3.fromRGB(0, 200, 255)
        end
        
        if UserInputService.TouchEnabled then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        else
            FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        end
    end
    
    -- Update targeting
    if Settings.Combat.SilentAim or Settings.Combat.AimbotEnabled then
        CurrentTarget = getClosestPlayerInFOV(CurrentTarget)
    end
    
    -- Perform aimbot
    performAimbot(deltaTime)
    
    -- Update ESP
    updateESP()
end)

-- Movement Features
UserInputService.JumpRequest:Connect(function()
    if Settings.Movement.InfiniteJump and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- UI Setup
createFOVCircle()

local Window = Fluent:CreateWindow({
    Title = "Improved Rivals | v2.5",
    SubTitle = "by Community",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.K
})

-- Combat Tab
local CombatTab = Window:AddTab({Title = "Combat", Icon = "crosshair"})

CombatTab:AddSection("Aimbot")

CombatTab:AddToggle("SilentAim", {
    Title = "Silent Aim",
    Description = "Redirects weapon shots to target",
    Default = false,
    Callback = function(value)
        Settings.Combat.SilentAim = value
    end
})

CombatTab:AddToggle("Aimbot", {
    Title = "Aimbot (Camera)",
    Description = "Smoothly aims camera at target",
    Default = false,
    Callback = function(value)
        Settings.Combat.AimbotEnabled = value
    end
})

CombatTab:AddToggle("ShowFOV", {
    Title = "Show FOV Circle",
    Default = true,
    Callback = function(value)
        Settings.Combat.ShowFOV = value
    end
})

CombatTab:AddSlider("FOVRadius", {
    Title = "FOV Radius",
    Description = "Size of aim circle",
    Default = 150,
    Min = 50,
    Max = 400,
    Rounding = 0,
    Callback = function(value)
        Settings.Combat.FOVRadius = value
    end
})

CombatTab:AddSlider("Smoothness", {
    Title = "Aim Smoothness",
    Description = "Lower = faster, Higher = smoother",
    Default = 0.15,
    Min = 0.05,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        Settings.Combat.Smoothness = value
    end
})

CombatTab:AddToggle("Prediction", {
    Title = "Prediction",
    Description = "Predict enemy movement",
    Default = true,
    Callback = function(value)
        Settings.Combat.Prediction = value
    end
})

CombatTab:AddToggle("StickToTarget", {
    Title = "Sticky Targeting",
    Description = "Keep targeting same player",
    Default = true,
    Callback = function(value)
        Settings.Combat.StickToTarget = value
    end
})

-- ESP Tab
local ESPTab = Window:AddTab({Title = "ESP", Icon = "eye"})

ESPTab:AddToggle("ESPEnabled", {
    Title = "Enable ESP",
    Default = false,
    Callback = function(value)
        Settings.ESP.Enabled = value
    end
})

ESPTab:AddToggle("GlowESP", {
    Title = "Glow ESP",
    Description = "Highlight players through walls",
    Default = true,
    Callback = function(value)
        Settings.ESP.Glow = value
    end
})

ESPTab:AddToggle("BoxESP", {
    Title = "Box ESP",
    Default = false,
    Callback = function(value)
        Settings.ESP.Box = value
    end
})

ESPTab:AddToggle("TracersESP", {
    Title = "Tracers",
    Default = false,
    Callback = function(value)
        Settings.ESP.Tracers = value
    end
})

ESPTab:AddToggle("DistanceESP", {
    Title = "Distance",
    Default = false,
    Callback = function(value)
        Settings.ESP.Distance = value
    end
})

-- Movement Tab
local MovementTab = Window:AddTab({Title = "Movement", Icon = "activity"})

MovementTab:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Description = "Jump infinitely in the air",
    Default = false,
    Callback = function(value)
        Settings.Movement.InfiniteJump = value
    end
})

-- Config Tab
local ConfigTab = Window:AddTab({Title = "Config", Icon = "palette"})

ConfigTab:AddToggle("RainbowFOV", {
    Title = "Rainbow FOV",
    Default = false,
    Callback = function(value)
        Settings.Visual.RainbowFOV = value
    end
})

ConfigTab:AddToggle("RainbowESP", {
    Title = "Rainbow ESP",
    Default = false,
    Callback = function(value)
        Settings.Visual.RainbowESP = value
    end
})

Fluent:Notify({
    Title = "Script Loaded",
    Content = "Improved Rivals v2.5 ready!",
    Duration = 5
})
