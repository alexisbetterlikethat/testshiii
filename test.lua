--[[ 
    AERO HUB GUI - FIXED & UPDATED
    - Works on all executors (Solara, Fluxus, Delta, Hydrogen, Arceus X, etc.)
    - Mobile/PC compatible (Touch drag added)
    - Webhook logger removed for safety
    - Improved Velocity Desync logic
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- ==========================================
-- COMPATIBILITY POLYFILLS
-- ==========================================
if not task then
    getgenv().task = {}
    
    task.spawn = function(f, ...)
        return coroutine.resume(coroutine.create(f), ...)
    end
    
    task.wait = function(t)
        return wait(t)
    end
    
    task.delay = function(t, f, ...)
        return delay(t, f, ...)
    end
end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera
local http = game:GetService("HttpService") -- Defined here for the webhook

-- ==========================================
-- DEBUGGING SYSTEM
-- ==========================================
local function debugLog(message, level)
    level = level or "INFO"
    local prefix = "[AeroHub] [" .. level .. "] "
    local fullMessage = prefix .. tostring(message)
    
    -- Standard Roblox Output
    if level == "ERROR" then
        warn(fullMessage)
    else
        print(fullMessage)
    end
    
    -- External Console Support (if available)
    if rconsoleprint then
        pcall(function()
            rconsoleprint(fullMessage .. "\n")
        end)
    end
end

debugLog("Script started. Polyfills applied: " .. (task and "Yes" or "No"), "INFO")

-- ========================================== 
-- ILLUSION VARIABLES
-- ========================================== 
local Character = nil
local Humanoid = nil
local RootPart = nil
local IsEffectActive = false
local DesyncHeartbeat = nil
local DesyncRenderStepped = nil
local LocalClone = nil
local Clone = nil -- The actual clone of the character
local WalkTrack = nil -- AnimationTrack for the clone's walking
local LocalDesyncPos = nil -- Stores the last known desync position
local GhostCFrame = nil -- Where the server thinks we are
local RealCFrame = nil -- Where we actually are
local stopIllusion -- Forward declaration

-- Helper to safely initialize Character variables
local function initializeCharacter(newChar)
    debugLog("Initializing character: " .. tostring(newChar), "INFO")
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid", 5) 
    RootPart = newChar:WaitForChild("HumanoidRootPart", 5)
    
    if not Humanoid or not RootPart then
        debugLog("Failed to find Humanoid or RootPart", "ERROR")
        return
    end

    -- Clean up any previous effect when character is initialized
    if IsEffectActive then
        debugLog("Cleaning up previous effect during init", "INFO")
        local oldEffectState = IsEffectActive
        pcall(stopIllusion) 
        -- If Desync was on, restart it immediately for the new character
        if oldEffectState and getgenv and getgenv().DesyncEnabled then
            debugLog("Restarting Desync for new character", "INFO")
            task.wait(0.2) -- Small wait for character setup
            pcall(startIllusion)
        end
    end
end

local function createLocalClone()
    if not player.Character then return nil end
    player.Character.Archivable = true
    local clone = player.Character:Clone()
    if not clone then
        debugLog("Failed to clone character", "ERROR")
        return nil
    end
    clone.Name = "Desync_Illusion"
    clone.Parent = Workspace
    
    for _, obj in pairs(clone:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("Sound") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            obj.CanCollide = false
            obj.Anchored = true
            obj.Transparency = 0.5
            obj.Color = Color3.fromRGB(100, 100, 255)
            obj.Material = Enum.Material.ForceField
        elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            obj:Destroy()
        end
    end
    
    if RootPart then
        clone:SetPrimaryPartCFrame(RootPart.CFrame)
    end
    
    return clone
end

-- ========================================== 
-- DESYNC LOGIC (VELOCITY METHOD + ANIMATION STOPPER)
-- ==========================================
-- Sets up and starts the clone/illusion
local function startIllusion()
    debugLog("Attempting to start Velocity Desync...", "INFO")
    if not Character or not RootPart or IsEffectActive then 
        debugLog("Cannot start illusion: Char="..tostring(Character).." Root="..tostring(RootPart).." Active="..tostring(IsEffectActive), "WARN")
        return 
    end

    IsEffectActive = true
    debugLog("Velocity Desync active", "INFO")

    -- 1. Create Visual Clone
    if LocalClone then LocalClone:Destroy() end
    LocalClone = createLocalClone()
    
    -- 2. Velocity Desync & Animation Stopper
    -- We spam high velocity on Heartbeat (Physics step) to confuse the server
    -- and reset it on RenderStepped (Visual step) so the client doesn't fling.
    
    DesyncHeartbeat = RunService.Heartbeat:Connect(function()
        if IsEffectActive and RootPart and RootPart.Parent then
            -- A. Velocity Spam (The Core Desync)
            -- Apply massive velocity to desync server position
            RootPart.AssemblyLinearVelocity = Vector3.new(20000, 0, 20000) 
            RootPart.AssemblyAngularVelocity = Vector3.new(20000, 0, 20000)
            
            -- B. Animation Stopper
            -- Stop animations to freeze the server-side hitbox pose
            if Humanoid then
                for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
        end
    end)
    
    DesyncRenderStepped = RunService.RenderStepped:Connect(function()
        if IsEffectActive and RootPart and RootPart.Parent then
            -- Reset velocity for the client so we can move normally
            RootPart.AssemblyLinearVelocity = Vector3.zero
            RootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    
    if getgenv then
        getgenv().DesyncEnabled = true
        if RootPart then
            getgenv().DesyncPosition = RootPart.Position
        end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Aero Hub";
        Text = "Velocity Desync Enabled";
        Duration = 3;
    })
end

-- Cleans up the illusion and restores the player's visibility
stopIllusion = function()
    debugLog("Stopping illusion...", "INFO")
    if not IsEffectActive then 
        debugLog("Illusion already stopped", "INFO")
        return 
    end
    IsEffectActive = false
    
    if DesyncHeartbeat then
        DesyncHeartbeat:Disconnect()
        DesyncHeartbeat = nil
    end
    
    if DesyncRenderStepped then
        DesyncRenderStepped:Disconnect()
        DesyncRenderStepped = nil
    end
    
    if LocalClone then
        LocalClone:Destroy()
        LocalClone = nil
    end
    
    if RootPart then
        RootPart.AssemblyLinearVelocity = Vector3.zero
        RootPart.AssemblyAngularVelocity = Vector3.zero
    end
    
    if getgenv then
        getgenv().DesyncEnabled = false
        getgenv().DesyncPosition = nil
    end
end

local function handleCharacter(newChar)
    if IsEffectActive then
        stopIllusion()
    end
    task.wait(0.1)
    initializeCharacter(newChar)
    
    -- If Desync is currently toggled ON (for respawns), immediately restart the effect
    if getgenv and getgenv().DesyncEnabled then
        pcall(startIllusion)
    end
end


player.CharacterAdded:Connect(handleCharacter)
if player.Character then
    handleCharacter(player.Character)
end

-- ==========================================
-- ANTI-AFK (Anti-Kick)
-- ==========================================
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    debugLog("Anti-AFK: Simulating input to prevent kick", "INFO")
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
-- ==========================================
-- HELICOPTER (SPIN BOT) LOGIC
-- ==========================================
local HELICOPTER_ENABLED = false
local helicopterConnections = {}
local helicopterBodyAngularVelocity = nil

local function disableHelicopter()
    if not HELICOPTER_ENABLED then return end
    HELICOPTER_ENABLED = false
    
    for _, conn in pairs(helicopterConnections) do
        if conn then conn:Disconnect() end
    end
    helicopterConnections = {}
    
    if helicopterBodyAngularVelocity then
        helicopterBodyAngularVelocity:Destroy()
        helicopterBodyAngularVelocity = nil
    end
end

local function enableHelicopter()
    if HELICOPTER_ENABLED then return end
    
    local char = player.Character
    if not char then return end
    
    local rootPart = char:WaitForChild("HumanoidRootPart", 5)
    if not rootPart or rootPart.Anchored then return end
    
    HELICOPTER_ENABLED = true
    
    -- Create rotation force
    helicopterBodyAngularVelocity = Instance.new("BodyAngularVelocity")
    helicopterBodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    helicopterBodyAngularVelocity.AngularVelocity = Vector3.new(0, 50, 0) -- Speed 50
    helicopterBodyAngularVelocity.Parent = rootPart
    
    -- Fling loop
    helicopterConnections.loop = RunService.Heartbeat:Connect(function()
        if not HELICOPTER_ENABLED or not rootPart or rootPart.Parent ~= char then return end
        
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local otherRoot = otherPlayer.Character.HumanoidRootPart
                local dist = (otherRoot.Position - rootPart.Position).Magnitude
                
                if dist < 8 then
                    local dir = (otherRoot.Position - rootPart.Position).Unit
                    local flingForce = dir * 100 + Vector3.new(0, 50, 0)
                    otherRoot.AssemblyLinearVelocity = flingForce
                end
            end
        end
    end)
    
    -- Cleanup on death
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        helicopterConnections.died = hum.Died:Connect(disableHelicopter)
    end
end

-- ==========================================
-- PLATFORM (RISE) LOGIC
-- ==========================================
local platformPart = nil
local platformActive = false
local isRising = false
local platformConnection = nil

local function destroyPlatform()
    if platformPart then platformPart:Destroy() platformPart = nil end
    platformActive = false
    isRising = false
    if platformConnection then platformConnection:Disconnect() platformConnection = nil end
end

local function canRise()
    if not platformPart then return false end
    local origin = platformPart.Position + Vector3.new(0, platformPart.Size.Y/2, 0)
    local direction = Vector3.new(0, 2, 0)
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {platformPart, player.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    return not Workspace:Raycast(origin, direction, rayParams)
end

local function enablePlatform()
    if platformActive then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    platformActive = true
    
    platformPart = Instance.new("Part")
    platformPart.Size = Vector3.new(6, 0.5, 6)
    platformPart.Anchored = true
    platformPart.CanCollide = true
    platformPart.Transparency = 0.3
    platformPart.Material = Enum.Material.Neon
    platformPart.Color = Color3.fromRGB(100, 200, 255)
    platformPart.Position = root.Position - Vector3.new(0, root.Size.Y/2 + platformPart.Size.Y/2, 0)
    platformPart.Parent = Workspace
    
    isRising = true
    platformConnection = RunService.Heartbeat:Connect(function(dt)
        if platformPart and platformActive then
            local currentPos = platformPart.Position
            local newXZ = Vector3.new(root.Position.X, currentPos.Y, root.Position.Z)
            
            if isRising and canRise() then
                platformPart.Position = newXZ + Vector3.new(0, dt * 5, 0) -- Rise Speed 5
            else
                isRising = false
                platformPart.Position = newXZ
            end
        end
    end)
    
    char:WaitForChild("Humanoid").Died:Connect(destroyPlatform)
end

local function disablePlatform()
    destroyPlatform()
end

-- ==========================================
-- GRAPPLE FLY LOGIC
-- ==========================================
local grappleFlightEnabled = false
local grappleFlightConnection = nil
local flightPart = nil

local function disableGrappleFlight()
    if not grappleFlightEnabled then return end
    grappleFlightEnabled = false
    
    if grappleFlightConnection then grappleFlightConnection:Disconnect() grappleFlightConnection = nil end
    if flightPart then flightPart:Destroy() flightPart = nil end
    
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

local function enableGrappleFlight()
    if grappleFlightEnabled then return end
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    
    grappleFlightEnabled = true
    
    -- Invisible part for flight physics
    flightPart = Instance.new("Part")
    flightPart.Size = Vector3.new(2, 1, 2)
    flightPart.Transparency = 1
    flightPart.CanCollide = false
    flightPart.Massless = true
    flightPart.Parent = Workspace
    
    local weld = Instance.new("Weld")
    weld.Part0 = root
    weld.Part1 = flightPart
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = flightPart
    
    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVel.P = 2000
    bodyVel.Parent = flightPart
    
    local speed = 150
    
    grappleFlightConnection = RunService.Heartbeat:Connect(function()
        if not grappleFlightEnabled or not char.Parent then return end
        
        local dir = Vector3.zero
        local camCF = Workspace.CurrentCamera.CFrame
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
        
        if dir.Magnitude > 0 then
            dir = dir.Unit * speed
        end
        
        bodyVel.Velocity = dir
        hum:ChangeState(Enum.HumanoidStateType.Physics)
    end)
    
    hum.Died:Connect(disableGrappleFlight)
end

-- ==========================================
-- FLING (PATCHED) LOGIC
-- ==========================================
local FLING_ENABLED = false
local flingConnection = nil
local flingOldIndex = nil
local flingDesyncState = {}

local function disableFling()
    if not FLING_ENABLED then return end
    FLING_ENABLED = false
    
    if flingConnection then flingConnection:Disconnect() flingConnection = nil end
    
    if flingOldIndex then
        hookmetamethod(game, "__index", function(self, key)
            return flingOldIndex(self, key)
        end)
        flingOldIndex = nil
    end
    
    flingDesyncState = {}
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

local function enableFling()
    if FLING_ENABLED then return end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    FLING_ENABLED = true
    
    -- Hook __index to spoof CFrame
    local success, err = pcall(function()
        flingOldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
            if FLING_ENABLED and not checkcaller() and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if key == "CFrame" and self == player.Character.HumanoidRootPart then
                    return flingDesyncState[1] or CFrame.new()
                end
            end
            return flingOldIndex(self, key)
        end))
    end)
    
    if not success then
        debugLog("Hookmetamethod failed (Executor not supported?)", "WARN")
        FLING_ENABLED = false
        return
    end
    
    flingConnection = RunService.Heartbeat:Connect(function()
        if not FLING_ENABLED or not player.Character then return end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        flingDesyncState[1] = hrp.CFrame
        
        -- Spoof CFrame and Velocity
        local spoofCF = hrp.CFrame * CFrame.Angles(math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)))
        hrp.CFrame = spoofCF
        hrp.AssemblyLinearVelocity = Vector3.new(10000, 10000, 10000) -- High velocity for fling
        
        RunService.RenderStepped:Wait()
        
        if player.Character and hrp.Parent == player.Character then
            hrp.CFrame = flingDesyncState[1]
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
    end)
    
    char:WaitForChild("Humanoid").Died:Connect(disableFling)
end

-- ==========================================
-- INVISIBILITY LOGIC
-- ==========================================
local function setInvisibility(enabled)
    local char = player.Character
    if not char then return end
    
    if enabled then
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") then
                pcall(function() sethiddenproperty(v, "NetworkIsSleeping", true) end)
                v.Transparency = 0.5 -- Visual feedback for local player
            end
        end
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            pcall(function() sethiddenproperty(hum, "OverrideDefaultCollisions", true) end)
        end
    else
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") then
                pcall(function() sethiddenproperty(v, "NetworkIsSleeping", false) end)
                v.Transparency = 0
            end
        end
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            pcall(function() sethiddenproperty(hum, "OverrideDefaultCollisions", false) end)
        end
    end
end

-- ==========================================
-- MOBILE DESYNC LOGIC
-- ==========================================
local MOBILE_DESYNC_ENABLED = false

local function enableMobileDesync()
    if MOBILE_DESYNC_ENABLED then return end
    MOBILE_DESYNC_ENABLED = true
    
    pcall(function()
        setfflag("S2PhysicsSenderRate", "-100")
        setfflag("PhysicsSkipNonRealTimeHumanoidForceCalc2", "True")
        setfflag("WorldStepMax", -2147483648)
    end)
    debugLog("Mobile Desync Enabled (Flags set)", "INFO")
end

local function disableMobileDesync()
    if not MOBILE_DESYNC_ENABLED then return end
    MOBILE_DESYNC_ENABLED = false
    
    pcall(function()
        setfflag("S2PhysicsSenderRate", "60")
        setfflag("PhysicsSkipNonRealTimeHumanoidForceCalc2", "False")
        setfflag("WorldStepMax", -1)
    end)
    debugLog("Mobile Desync Disabled", "INFO")
end

-- ==========================================
-- RAGDOLL DESYNC LOGIC
-- ==========================================
local RAGDOLL_DESYNC_ENABLED = false

local function enableRagdollDesync()
    if RAGDOLL_DESYNC_ENABLED then return end
    RAGDOLL_DESYNC_ENABLED = true
    
    -- Attempt to disable RagdollController
    for _, module in ipairs(getloadedmodules()) do
        if module.Name == "RagdollController" or module.Name == "Ragdoll" then
            local success, result = pcall(require, module)
            if success and type(result) == "table" then
                -- Try to stop or disable it
                if result.Stop then result:Stop() end
                if result.Disable then result:Disable() end
                debugLog("Disabled Ragdoll Module: " .. module.Name, "INFO")
            end
        end
    end
end

local function disableRagdollDesync()
    if not RAGDOLL_DESYNC_ENABLED then return end
    RAGDOLL_DESYNC_ENABLED = false
    -- Cannot easily re-enable without re-requiring or restarting, 
    -- but we'll log it.
    debugLog("Ragdoll Desync Disabled (Rejoin to fully reset)", "WARN")
end

-- ==========================================
-- SERVER HOP LOGIC
-- ==========================================
local TeleportService = game:GetService("TeleportService")

local function getServerList()
    local success, result = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local response = http:GetAsync(url)
        return http:JSONDecode(response)
    end)
    return (success and result and result.data) or {}
end

local function joinBiggestServer()
    local servers = getServerList()
    local best, maxP = nil, 0
    for _, s in ipairs(servers) do
        if s.id ~= game.JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers and s.playing > maxP then
            best, maxP = s, s.playing
        end
    end
    if best then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, best.id, player)
    else
        debugLog("No better server found", "WARN")
    end
end

local function joinSmallestServer()
    local servers = getServerList()
    local best, minP = nil, math.huge
    for _, s in ipairs(servers) do
        if s.id ~= game.JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers and s.playing < minP then
            best, minP = s, s.playing
        end
    end
    if best then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, best.id, player)
    else
        debugLog("No better server found", "WARN")
    end
end

local function rejoinServer()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end

debugLog("Anti-AFK Enabled", "INFO")

-- ========================================== 
-- GUI HELPER FUNCTIONS
-- ========================================== 
local function new(class, props, parent)
    local obj = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            if k ~= "Parent" then
                obj[k] = v
            end
        end
        if props.Parent then obj.Parent = props.Parent end
    end
    if parent then obj.Parent = parent end
    return obj
end

local function addHoverEffect(guiObject)
    if not guiObject then return end
    local originalPos = guiObject.Position
    guiObject:SetAttribute("BaseY", originalPos.Y.Offset)
    guiObject.MouseEnter:Connect(function()
        local currentY = guiObject:GetAttribute("BaseY") or originalPos.Y.Offset
        TweenService:Create(guiObject, TweenInfo.new(0.2), {Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale, currentY + 3)}):Play()
    end)
    guiObject.MouseLeave:Connect(function()
        local currentY = guiObject:GetAttribute("BaseY") or originalPos.Y.Offset
        TweenService:Create(guiObject, TweenInfo.new(0.2), {Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale, currentY)}):Play()
    end)
end

-- UPDATED: Touch Support for Mobile
local canDrag = false
local function makeDraggable(frame)
    local dragging = false
    local dragStart, startPos
    local dragSpeed = 0.15
    
    local function inputStart(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and (canDrag or frame.Name == "MinimizedIcon") then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end
    
    frame.InputBegan:Connect(inputStart)
    
    local dragInput
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(frame, TweenInfo.new(dragSpeed), {Position = targetPos}):Play()
        end
    end)
end

-- ========================================== 
-- MAIN GUI SETUP
-- ========================================== 
if game.CoreGui:FindFirstChild("AeroHubUI") then
    game.CoreGui.AeroHubUI:Destroy()
end

-- Using CoreGui if available (more secure), else PlayerGui
local parentTarget = game:GetService("CoreGui")
if not pcall(function() local x = parentTarget.Name end) then
    parentTarget = playerGui
end

local screenGui = new("ScreenGui", {Name="AeroHubUI", ResetOnSpawn=false, IgnoreGuiInset=true}, parentTarget)

local minimizedIcon = new("ImageButton", {
    Name = "MinimizedIcon",
    Size = UDim2.new(0, 0, 0, 0),
    Position = UDim2.new(0.1, 0, 0.1, 0),
    BackgroundColor3 = Color3.fromRGB(20, 20, 30),
    Image = "rbxassetid://6031280883",
    ImageColor3 = Color3.fromRGB(120, 80, 255),
    AutoButtonColor = false,
    Visible = false,
    Parent = screenGui,
    ZIndex = 100
})
new("UICorner", {CornerRadius = UDim.new(1, 0)}, minimizedIcon)
new("UIStroke", {Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Parent = minimizedIcon})
makeDraggable(minimizedIcon)

local panel = new("Frame", {
    Name="Panel",
    Size=UDim2.new(0,500,0,750), -- Increased height again
    Position=UDim2.new(0.5,0,0.5,-375),
    AnchorPoint=Vector2.new(0.5, 0),
    BackgroundColor3=Color3.fromRGB(12,12,20),
    BorderSizePixel=0,
    ClipsDescendants=true,
    ZIndex=50,
    Parent = screenGui
})
new("UICorner", {CornerRadius=UDim.new(0,20)}, panel)
makeDraggable(panel)

local glow = new("UIStroke", {
    Color=Color3.fromRGB(120,80,255),
    Thickness=4,
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
    LineJoinMode=Enum.LineJoinMode.Round,
    Parent=panel
})

local hue=0
RunService.RenderStepped:Connect(function(dt)
    hue=(hue+dt*0.2)%1
    glow.Color=Color3.fromHSV(hue,0.9,1)
    minimizedIcon.ImageColor3 = Color3.fromHSV(hue, 0.9, 1)
end)

local contentElements = {}

local titleLabel = new("TextLabel", {
    Text="Aero Hub (Fixed)",
    Font=Enum.Font.GothamBold,
    TextSize=16,
    TextColor3=Color3.fromRGB(200,200,255),
    BackgroundTransparency=1,
    Size=UDim2.new(0, 150, 0, 20),
    Position=UDim2.new(0.5, -75, 0, 12),
    Parent=panel,
    ZIndex=60
})
addHoverEffect(titleLabel)
table.insert(contentElements, titleLabel)

-- DESYNC SECTION
local desyncLabel = new("TextLabel", {
    Text="DeSync",
    Font=Enum.Font.GothamBold,
    TextSize=28,
    TextColor3=Color3.fromRGB(255,0,255),
    BackgroundTransparency=1,
    Size=UDim2.new(1,0,0,40),
    Position=UDim2.new(0,0,0.08,0),
    TextScaled=false,
    Parent=panel,
    ZIndex=60
})
addHoverEffect(desyncLabel)
table.insert(contentElements, desyncLabel)

local hueLabel=0
RunService.RenderStepped:Connect(function(dt)
    hueLabel=(hueLabel+dt*0.5)%1
    desyncLabel.TextColor3=Color3.fromHSV(hueLabel,0.9,1)
end)

local toggleFrame = new("Frame", {
    Size=UDim2.new(0,120,0,60),
    BackgroundColor3=Color3.fromRGB(40,40,60),
    Position=UDim2.new(0.5,-60,0.15,0),
    Parent=panel,
    ZIndex=60
})
new("UICorner", {CornerRadius=UDim.new(0,30)}, toggleFrame)
table.insert(contentElements, toggleFrame)

local knob = new("Frame", {
    Size=UDim2.new(0,56,0,56),
    Position=UDim2.new(0,4,0,2),
    BackgroundColor3=Color3.fromRGB(255,255,255),
    Parent=toggleFrame,
    ZIndex=61
})
new("UICorner", {CornerRadius=UDim.new(1,0)}, knob)

local symbol = new("TextLabel", {
    Text="X",
    Font=Enum.Font.GothamBlack,
    TextSize=32,
    TextColor3=Color3.fromRGB(255,50,50),
    BackgroundTransparency=1,
    AnchorPoint=Vector2.new(0.5, 0.5),
    Position=UDim2.new(0.5, 0, 0.5, 0),
    Size=UDim2.new(1,0,1,0),
    Rotation=0,
    Parent=knob,
    ZIndex=62
})
addHoverEffect(symbol)

-- VISUALIZER SECTION
local visLabel = new("TextLabel", {
    Text="Visualize Pos",
    Font=Enum.Font.GothamBold,
    TextSize=24,
    TextColor3=Color3.fromRGB(100,255,255),
    BackgroundTransparency=1,
    Size=UDim2.new(1,0,0,30),
    Position=UDim2.new(0,0,0.28,0),
    TextScaled=false,
    Parent=panel,
    ZIndex=60
})
addHoverEffect(visLabel)
table.insert(contentElements, visLabel)

local visToggleFrame = new("Frame", {
    Size=UDim2.new(0,100,0,50),
    BackgroundColor3=Color3.fromRGB(40,40,60),
    Position=UDim2.new(0.5,-50,0.34,0),
    Parent=panel,
    ZIndex=60
})
new("UICorner", {CornerRadius=UDim.new(0,25)}, visToggleFrame)
table.insert(contentElements, visToggleFrame)

local visKnob = new("Frame", {
    Size=UDim2.new(0,46,0,46),
    Position=UDim2.new(0,2,0,2),
    BackgroundColor3=Color3.fromRGB(255,255,255),
    Parent=visToggleFrame,
    ZIndex=61
})
new("UICorner", {CornerRadius=UDim.new(1,0)}, visKnob) -- Vis Symbol
local visSymbol = new("TextLabel", {
    Text="X",
    Font=Enum.Font.GothamBlack,
    TextSize=24,
    TextColor3=Color3.fromRGB(255,50,50),
    BackgroundTransparency=1,
    AnchorPoint=Vector2.new(0.5, 0.5),
    Position=UDim2.new(0.5, 0, 0.5, 0),
    Size=UDim2.new(1,0,1,0),
    Rotation=0,
    Parent=visKnob,
    ZIndex=62
})
addHoverEffect(visSymbol)

-- 3. LAG SWITCH SECTION
-- Label
local lagLabel = new("TextLabel",{ Text="Lag Switch (Freeze)", Font=Enum.Font.GothamBold, TextSize=24, TextColor3=Color3.fromRGB(255,100,100), BackgroundTransparency=1, Size=UDim2.new(1,0,0,30), Position=UDim2.new(0,0,0.45,0), TextScaled=false, Parent=panel, ZIndex=60 })
addHoverEffect(lagLabel)
table.insert(contentElements, lagLabel)

-- Lag Toggle Frame
local lagToggleFrame = new("Frame",{ Size=UDim2.new(0,100,0,50), BackgroundColor3=Color3.fromRGB(40,40,60), Position=UDim2.new(0.5,-50,0.51,0), Parent=panel, ZIndex=60 })
new("UICorner",{CornerRadius=UDim.new(0,25)}, lagToggleFrame)
table.insert(contentElements, lagToggleFrame)

-- Lag Knob
local lagKnob = new("Frame",{ Size=UDim2.new(0,46,0,46), Position=UDim2.new(0,2,0,2), BackgroundColor3=Color3.fromRGB(255,255,255), Parent=lagToggleFrame, ZIndex=61 })
new("UICorner",{CornerRadius=UDim.new(1,0)}, lagKnob)

-- Lag Symbol
local lagSymbol = new("TextLabel",{ Text="X", Font=Enum.Font.GothamBlack, TextSize=24, TextColor3=Color3.fromRGB(255,50,50), BackgroundTransparency=1, AnchorPoint=Vector2.new(0.5, 0.5), Position=UDim2.new(0.5, 0, 0.5, 0), Size=UDim2.new(1,0,1,0), Rotation=0, Parent=lagKnob, ZIndex=62 })
addHoverEffect(lagSymbol)


-- MOVEMENT SECTION
local moveLabel = new("TextLabel", {
    Text="Movement & Tools",
    Font=Enum.Font.GothamBold,
    TextSize=24,
    TextColor3=Color3.fromRGB(50,255,100),
    BackgroundTransparency=1,
    Size=UDim2.new(1,0,0,30),
    Position=UDim2.new(0,0,0.62,0),
    TextScaled=false,
    Parent=panel,
    ZIndex=60
})
addHoverEffect(moveLabel)
table.insert(contentElements, moveLabel)

-- Helper for small toggles
local function createSmallToggle(text, pos, callback)
    local frame = new("Frame", {
        Size=UDim2.new(0, 140, 0, 40),
        Position=pos,
        BackgroundColor3=Color3.fromRGB(30,30,40),
        Parent=panel,
        ZIndex=60
    })
    new("UICorner", {CornerRadius=UDim.new(0,10)}, frame)
    
    local label = new("TextLabel", {
        Text=text,
        Font=Enum.Font.GothamBold,
        TextSize=14,
        TextColor3=Color3.fromRGB(200,200,200),
        BackgroundTransparency=1,
        Size=UDim2.new(0.7, 0, 1, 0),
        Position=UDim2.new(0, 10, 0, 0),
        TextXAlignment=Enum.TextXAlignment.Left,
        Parent=frame,
        ZIndex=61
    })
    
    local toggleBtn = new("Frame", {
        Size=UDim2.new(0, 30, 0, 30),
        Position=UDim2.new(1, -35, 0.5, -15),
        BackgroundColor3=Color3.fromRGB(50,50,50),
        Parent=frame,
        ZIndex=61
    })
    new("UICorner", {CornerRadius=UDim.new(0,8)}, toggleBtn)
    
    local state = false
    local function update()
        state = not state
        local targetColor = state and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(50,50,50)
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3=targetColor}):Play()
        callback(state)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            update()
        end
    end)
    
    return frame
end

-- Toggles
createSmallToggle("Spin Bot", UDim2.new(0.1, 0, 0.68, 0), function(s) if s then enableHelicopter() else disableHelicopter() end end)
createSmallToggle("Platform", UDim2.new(0.55, 0, 0.68, 0), function(s) if s then enablePlatform() else disablePlatform() end end)
createSmallToggle("Grapple Fly", UDim2.new(0.1, 0, 0.76, 0), function(s) if s then enableGrappleFlight() else disableGrappleFlight() end end)

-- New Exploits Toggles
createSmallToggle("Fling (Patched)", UDim2.new(0.55, 0, 0.76, 0), function(s) if s then enableFling() else disableFling() end end)
createSmallToggle("Invisibility", UDim2.new(0.1, 0, 0.84, 0), function(s) setInvisibility(s) end)
createSmallToggle("Mobile Desync", UDim2.new(0.55, 0, 0.84, 0), function(s) if s then enableMobileDesync() else disableMobileDesync() end end)
createSmallToggle("Ragdoll Desync", UDim2.new(0.1, 0, 0.92, 0), function(s) if s then enableRagdollDesync() else disableRagdollDesync() end end)

-- Server Hop Buttons
local function createButton(text, pos, color, callback)
    local btn = new("TextButton", {
        Text=text,
        Font=Enum.Font.GothamBold,
        TextSize=12,
        TextColor3=Color3.fromRGB(255,255,255),
        BackgroundColor3=color,
        Size=UDim2.new(0, 90, 0, 30),
        Position=pos,
        Parent=panel,
        AutoButtonColor=true,
        ZIndex=60
    })
    new("UICorner", {CornerRadius=UDim.new(0,8)}, btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createButton("Big Server", UDim2.new(0.55, 0, 0.92, 0), Color3.fromRGB(100, 100, 200), joinBiggestServer)
createButton("Small Server", UDim2.new(0.75, 0, 0.92, 0), Color3.fromRGB(100, 200, 100), joinSmallestServer)
createButton("Rejoin", UDim2.new(0.55, 0, 0.98, 0), Color3.fromRGB(200, 100, 100), rejoinServer)

local noteLabel = new("TextLabel", {
    Text="Server sees your 'Clone' (Blue Ghost)\nYou move freely.",
    Font=Enum.Font.Gotham,
    TextSize=12,
    TextColor3=Color3.fromRGB(150, 150, 160),
    BackgroundTransparency=1,
    Size=UDim2.new(0, 400, 0, 20),
    Position=UDim2.new(0.5, 0, 1.05, 0), -- Moved down further
    AnchorPoint=Vector2.new(0.5, 0),
    Parent=panel,
    ZIndex=60
})
table.insert(contentElements, noteLabel)

-- TOGGLE LOGIC
local isOn = false
local isAnimating = false

local function clearUnwantedScripts(char)
    for _, script in ipairs(char:GetDescendants()) do
        if script:IsA("Script") or script:IsA("LocalScript") then
            script:Destroy()
        end
    end
end

local function toggle()
    if isAnimating or not canDrag then return end
    isAnimating = true
    isOn = not isOn
    
    -- UPDATE DESYNC STATE AND CLONE ILLUSION
    if isOn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local pos = player.Character.HumanoidRootPart.Position
        LocalDesyncPos = pos
        debugLog("Desync Toggled ON. Position: " .. tostring(pos), "INFO")
        clearUnwantedScripts(player.Character)
        
        if getgenv then
            getgenv().DesyncEnabled = true
            getgenv().DesyncPosition = pos
        end
        
        -- >>> START CLONE ILLUSION
        local success, err = pcall(startIllusion) 
        if not success then debugLog("Error starting illusion: " .. tostring(err), "ERROR") end
        
    else
        LocalDesyncPos = nil
        debugLog("Desync Toggled OFF", "INFO")
        
        if getgenv then
            getgenv().DesyncEnabled = false
            getgenv().DesyncPosition = nil
            pcall(stopIllusion) 
        end
    end
    
    local targetPos = isOn and UDim2.new(1, -60, 0, 2) or UDim2.new(0, 4, 0, 2)
    TweenService:Create(knob, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position=targetPos}):Play()
    
    local targetColor = isOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 60)
    TweenService:Create(toggleFrame, TweenInfo.new(0.4), {BackgroundColor3=targetColor}):Play()
    
    local spinTween = TweenService:Create(symbol, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = symbol.Rotation + 360})
    spinTween:Play()
    
    task.delay(0.2, function()
        symbol.Text = isOn and "✔️" or "X"
        symbol.TextColor3 = isOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(255, 50, 50)
    end)
    
    spinTween.Completed:Wait()
    isAnimating = false
end

local function connectToggle(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggle()
    end
end

toggleFrame.InputBegan:Connect(connectToggle)
knob.InputBegan:Connect(connectToggle)
symbol.InputBegan:Connect(connectToggle)

-- VISUALIZER LOGIC
local isVisOn = false
local isVisAnimating = false
local visualizerPart = nil

local function updateVisualizer()
    if not isVisOn then
        if visualizerPart then
            visualizerPart:Destroy()
            visualizerPart = nil
        end
        return
    end
    
    if not visualizerPart then
        visualizerPart = Instance.new("Part")
        visualizerPart.Name = "DesyncVisualizer"
        visualizerPart.Shape = Enum.PartType.Ball
        visualizerPart.Size = Vector3.new(2, 2, 2)
        visualizerPart.Color = Color3.fromRGB(0, 255, 255)
        visualizerPart.Material = Enum.Material.Neon
        visualizerPart.Transparency = 0.3
        visualizerPart.Anchored = true
        visualizerPart.CanCollide = false
        visualizerPart.CastShadow = false
        visualizerPart.Parent = Workspace
    end
    
    local targetPos = nil
    if getgenv and getgenv().DesyncPosition then
        targetPos = getgenv().DesyncPosition
    end
    
    if not targetPos and LocalClone and LocalClone.PrimaryPart then
        targetPos = LocalClone.PrimaryPart.Position
    end
    
    if not targetPos and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        targetPos = player.Character.HumanoidRootPart.Position
    end
    
    if targetPos then
        visualizerPart.Position = targetPos
    end
end

RunService.RenderStepped:Connect(function()
    pcall(updateVisualizer)
end)

local function toggleVis()
    if isVisAnimating or not canDrag then return end
    isVisAnimating = true
    isVisOn = not isVisOn
    
    local targetPos = isVisOn and UDim2.new(1, -48, 0, 2) or UDim2.new(0, 2, 0, 2)
    TweenService:Create(visKnob, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position=targetPos}):Play()
    
    local targetColor = isVisOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 60)
    TweenService:Create(visToggleFrame, TweenInfo.new(0.4), {BackgroundColor3=targetColor}):Play()
    
    local spinTween = TweenService:Create(visSymbol, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = visSymbol.Rotation + 360})
    spinTween:Play()
    
    task.delay(0.2, function()
        visSymbol.Text = isVisOn and "✔️" or "X"
        visSymbol.TextColor3 = isVisOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(255, 50, 50)
    end)
    
    spinTween.Completed:Wait()
    isVisAnimating = false
end

local function connectVisToggle(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleVis()
    end
end

visToggleFrame.InputBegan:Connect(connectVisToggle)
visKnob.InputBegan:Connect(connectVisToggle)
visSymbol.InputBegan:Connect(connectVisToggle)

-- LAG SWITCH LOGIC
local isLagOn = false
local isLagAnimating = false

local function toggleLag()
    if isLagAnimating or not canDrag then return end
    isLagAnimating = true
    isLagOn = not isLagOn
    
    debugLog("Lag Switch Toggled: " .. tostring(isLagOn), "INFO")
    
    if isLagOn then
        -- Enable Lag (Freeze)
        if settings() and settings().Network then
            settings().Network.IncomingReplicationLag = 10000 -- High lag
        end
    else
        -- Disable Lag (Unfreeze)
        if settings() and settings().Network then
            settings().Network.IncomingReplicationLag = 0
        end
    end
    
    local targetPos = isLagOn and UDim2.new(1, -48, 0, 2) or UDim2.new(0, 2, 0, 2)
    TweenService:Create(lagKnob, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position=targetPos}):Play()
    local targetColor = isLagOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 60)
    TweenService:Create(lagToggleFrame, TweenInfo.new(0.4), {BackgroundColor3=targetColor}):Play()
    local spinTween = TweenService:Create(lagSymbol, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = lagSymbol.Rotation + 360})
    spinTween:Play()
    task.delay(0.2, function()
        lagSymbol.Text = isLagOn and "✔️" or "X"
        lagSymbol.TextColor3 = isLagOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(255, 50, 50)
    end)
    spinTween.Completed:Wait()
    isLagAnimating = false
end
local function connectLagToggle(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleLag() end
end
lagToggleFrame.InputBegan:Connect(connectLagToggle)
lagKnob.InputBegan:Connect(connectLagToggle)
lagSymbol.InputBegan:Connect(connectLagToggle)


-- TOP BAR BUTTONS
local topBar = new("Frame", {
    Size=UDim2.new(1,0,0,50),
    BackgroundTransparency=1,
    Parent=panel,
    ZIndex=70
})

local minBtn = new("TextButton", {
    Text="-",
    Font=Enum.Font.GothamBlack,
    TextSize=24,
    TextColor3=Color3.fromRGB(50, 50, 50),
    BackgroundColor3=Color3.fromRGB(255, 220, 50),
    Size=UDim2.new(0,30,0,30),
    Position=UDim2.new(1,-80,0,10),
    Parent=topBar,
    AutoButtonColor = true,
    ZIndex=71
})
new("UICorner", {CornerRadius=UDim.new(1,0)}, minBtn)
addHoverEffect(minBtn)
table.insert(contentElements, minBtn)

local closeBtn = new("TextButton", {
    Text="X",
    Font=Enum.Font.GothamBlack,
    TextSize=18,
    TextColor3=Color3.fromRGB(255, 255, 255),
    BackgroundColor3=Color3.fromRGB(255, 80, 80),
    Size=UDim2.new(0,30,0,30),
    Position=UDim2.new(1,-40,0,10),
    Parent=topBar,
    AutoButtonColor = true,
    ZIndex=71
})
new("UICorner", {CornerRadius=UDim.new(1,0)}, closeBtn)
addHoverEffect(closeBtn)
table.insert(contentElements, closeBtn)

local fpsLabel = new("TextLabel", {
    Text="FPS: 0",
    Font=Enum.Font.GothamBold,
    TextSize=18,
    TextColor3=Color3.fromRGB(255,255,255),
    BackgroundTransparency=1,
    Size=UDim2.new(0,100,0,30),
    Position=UDim2.new(0.5,-50,1,-40),
    Parent=panel,
    ZIndex=60
})
addHoverEffect(fpsLabel)
table.insert(contentElements, fpsLabel)

local lastFrame=os.clock()
local frameCount=0
RunService.RenderStepped:Connect(function()
    frameCount=frameCount+1
    if os.clock()-lastFrame>=1 then
        fpsLabel.Text="FPS: "..frameCount
        frameCount=0
        lastFrame=os.clock()
    end
end)

-- MINIMIZE / CLOSE LOGIC
local function restorePanel()
    TweenService:Create(minimizedIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    minimizedIcon.Visible = false
    panel.Visible = true
    panel.Size = UDim2.new(0,0,0,0)
    TweenService:Create(panel, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0,500,0,450)}):Play()
end

local function minimizePanel()
    TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    panel.Visible = false
    minimizedIcon.Visible = true
    TweenService:Create(minimizedIcon, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0,50,0,50)}):Play()
end

minBtn.MouseButton1Click:Connect(minimizePanel)
minimizedIcon.MouseButton1Click:Connect(restorePanel)

closeBtn.MouseButton1Click:Connect(function()
    pcall(stopIllusion)
    TweenService:Create(panel, TweenInfo.new(0.3), {Size=UDim2.new(0,0,0,0), BackgroundTransparency=1}):Play()
    TweenService:Create(minimizedIcon, TweenInfo.new(0.3), {Size=UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    screenGui:Destroy()
    if visualizerPart then
        visualizerPart:Destroy()
    end
end)

-- PARTICLES
local particleContainer = new("Frame", {
    Name = "ParticleLayer",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 51,
    Parent = panel
})

local function spawnParticle()
    local dotSize = 4
    local startX = math.random(12, 488)
    local startYScale = 1.05
    local dot = new("Frame", {
        Size = UDim2.new(0, dotSize, 0, dotSize),
        Position = UDim2.new(0, startX, startYScale, 0),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ZIndex = 52,
        Parent = particleContainer
    })
    new("UICorner", {CornerRadius = UDim.new(1, 0)}, dot)
    
    local blur = new("ImageLabel", {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(0, startX-4, startYScale, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://4818765533",
        ImageColor3 = Color3.new(1, 1, 1),
        ImageTransparency = 0.7,
        ZIndex = 52,
        Parent = particleContainer
    })
    
    local lifetime = math.random(6, 8)
    local driftX = math.random(-13, 13)
    local endY = 0.25
    
    TweenService:Create(dot, TweenInfo.new(lifetime, Enum.EasingStyle.Linear), {
        Position = UDim2.new(0, startX + driftX, endY, 0),
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(blur, TweenInfo.new(lifetime, Enum.EasingStyle.Linear), {
        Position = UDim2.new(0, startX + driftX - 4, endY, 0),
        ImageTransparency = 1
    }):Play()
    
    task.delay(lifetime, function()
        if dot and dot.Parent then dot:Destroy() end
        if blur and blur.Parent then blur:Destroy() end
    end)
end

task.spawn(function()
    while screenGui and screenGui.Parent do
        if panel.Visible then
            spawnParticle()
            task.wait(math.random(900, 1500) / 1000)
        else
            task.wait(0.5)
        end
    end
end)

-- INTRO ANIMATION
task.spawn(function()
    panel.Size = UDim2.new(0,0,0,0)
    panel.Visible = true
    for _, element in ipairs(contentElements) do
        if element:IsA("TextLabel") or element:IsA("TextButton") then
            element.TextTransparency = 1
        end
        if element:IsA("Frame") or element:IsA("TextButton") then
            element.BackgroundTransparency = 1
        end
    end
    task.wait(0.2)
    local panelTween = TweenService:Create(panel, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 450)})
    panelTween:Play()
    panelTween.Completed:Wait()
    for _, element in ipairs(contentElements) do
        if element:IsA("TextLabel") or element:IsA("TextButton") then
            TweenService:Create(element, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        end
        if element == toggleFrame or element == visToggleFrame or element == lagToggleFrame or element == minBtn or element == closeBtn then 
            TweenService:Create(element, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play() 
        end
        task.wait(0.1)
    end
    canDrag = true
end)
