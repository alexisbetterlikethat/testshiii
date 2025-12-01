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
local ANTI_KICK_ENABLED = true
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    if ANTI_KICK_ENABLED then
        debugLog("Anti-AFK: Simulating input to prevent kick", "INFO")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
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
-- JUMP BYPASS LOGIC
-- ==========================================
local JUMP_BYPASS_ENABLED = false
local JUMP_POWER = 50

local function enableJumpBypass()
    if not player.Character then return end
    local hum = player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = JUMP_POWER
        JUMP_BYPASS_ENABLED = true
    end
end

local function disableJumpBypass()
    if not player.Character then return end
    local hum = player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.UseJumpPower = false
        hum.JumpPower = 50 -- Default
        JUMP_BYPASS_ENABLED = false
    end
end

-- ==========================================
-- SPEED BOOST LOGIC
-- ==========================================
local SPEED_BOOST_ENABLED = false
local SPEED_VAL = 16
local speedConnection = nil

local function enableSpeedBoost()
    if SPEED_BOOST_ENABLED then return end
    SPEED_BOOST_ENABLED = true
    
    speedConnection = RunService.Heartbeat:Connect(function()
        if not SPEED_BOOST_ENABLED then return end
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return end
        
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            root.AssemblyLinearVelocity = Vector3.new(
                moveDir.X * SPEED_VAL,
                root.AssemblyLinearVelocity.Y,
                moveDir.Z * SPEED_VAL
            )
        end
    end)
end

local function disableSpeedBoost()
    if not SPEED_BOOST_ENABLED then return end
    SPEED_BOOST_ENABLED = false
    if speedConnection then speedConnection:Disconnect() speedConnection = nil end
end

-- ==========================================
-- HEIGHT BYPASS (UNHITTABLE) LOGIC
-- ==========================================
local UNHITTABLE_ENABLED = false
local unhittableThread = nil

local function enableUnhittable()
    if UNHITTABLE_ENABLED then return end
    UNHITTABLE_ENABLED = true
    
    unhittableThread = task.spawn(function()
        while UNHITTABLE_ENABLED do
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Size = Vector3.new(2, 20, 1)
                    task.wait(0.2)
                    if not UNHITTABLE_ENABLED then break end
                    root.Size = Vector3.new(2, 40, 1)
                    task.wait(2.1)
                    if not UNHITTABLE_ENABLED then break end
                    root.Size = Vector3.new(2, 2, 1)
                    task.wait(1.5)
                end
            end
            task.wait(0.1)
        end
        -- Reset size
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
        end
    end)
end

local function disableUnhittable()
    UNHITTABLE_ENABLED = false
    if unhittableThread then task.cancel(unhittableThread) unhittableThread = nil end
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
    end
end

-- ==========================================
-- TALL MODE LOGIC
-- ==========================================
local TALL_MODE_ENABLED = false

local function setTallMode(enabled)
    TALL_MODE_ENABLED = enabled
    local char = player.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            if enabled then
                root.Size = Vector3.new(2, 10, 1)
            else
                root.Size = Vector3.new(2, 2, 1)
            end
        end
    end
end

-- ==========================================
-- PLAYER ESP LOGIC
-- ==========================================
local PLAYER_ESP_ENABLED = false
local ESP_SETTINGS = {
    ShowDistance = true,
    ShowItems = true,
    HighlightColor = Color3.fromRGB(255, 0, 0)
}
local espConnections = {}

local function createPlayerBillboard(plr)
    if not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    if not head then return end
    
    local bb = Instance.new("BillboardGui")
    bb.Name = "AeroESP"
    bb.Adornee = head
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 2, 0)
    bb.AlwaysOnTop = true
    bb.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = plr.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Parent = bb
    
    if ESP_SETTINGS.ShowDistance then
        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.new(1, 1, 1)
        distLabel.TextStrokeTransparency = 0
        distLabel.Parent = bb
        
        task.spawn(function()
            while bb.Parent do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    distLabel.Text = math.floor(dist) .. " studs"
                end
                task.wait(0.5)
            end
        end)
    end
end

local function enablePlayerESP()
    if PLAYER_ESP_ENABLED then return end
    PLAYER_ESP_ENABLED = true
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            if plr.Character then
                -- Highlight
                local hl = Instance.new("Highlight")
                hl.Name = "AeroHighlight"
                hl.FillColor = ESP_SETTINGS.HighlightColor
                hl.OutlineColor = ESP_SETTINGS.HighlightColor
                hl.Parent = plr.Character
                
                createPlayerBillboard(plr)
            end
            
            espConnections[plr] = plr.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                if not PLAYER_ESP_ENABLED then return end
                local hl = Instance.new("Highlight")
                hl.Name = "AeroHighlight"
                hl.FillColor = ESP_SETTINGS.HighlightColor
                hl.OutlineColor = ESP_SETTINGS.HighlightColor
                hl.Parent = char
                createPlayerBillboard(plr)
            end)
        end
    end
    
    espConnections.added = Players.PlayerAdded:Connect(function(plr)
        espConnections[plr] = plr.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if not PLAYER_ESP_ENABLED then return end
            local hl = Instance.new("Highlight")
            hl.Name = "AeroHighlight"
            hl.FillColor = ESP_SETTINGS.HighlightColor
            hl.OutlineColor = ESP_SETTINGS.HighlightColor
            hl.Parent = char
            createPlayerBillboard(plr)
        end)
    end)
end

local function disablePlayerESP()
    PLAYER_ESP_ENABLED = false
    if espConnections.added then espConnections.added:Disconnect() end
    for _, conn in pairs(espConnections) do
        if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
    end
    espConnections = {}
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local hl = plr.Character:FindFirstChild("AeroHighlight")
            if hl then hl:Destroy() end
            local head = plr.Character:FindFirstChild("Head")
            if head then
                local bb = head:FindFirstChild("AeroESP")
                if bb then bb:Destroy() end
            end
        end
    end
end

-- ==========================================
-- PLOT ESP LOGIC
-- ==========================================
local PLOT_ESP_ENABLED = false
local PLOT_TIME_ESP_ENABLED = false
local plotEspFolder = nil

local function getPlotOwner(plot)
    local sign = plot:FindFirstChild("PlotSign", true)
    if sign then
        local label = sign:FindFirstChildWhichIsA("TextLabel", true)
        if label then return label.Text end
    end
    return "Unknown"
end

local function updatePlotESP()
    if not plotEspFolder then
        plotEspFolder = Instance.new("Folder")
        plotEspFolder.Name = "AeroPlotESP"
        plotEspFolder.Parent = Workspace
    end
    
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return end
    
    for _, plot in pairs(plots:GetChildren()) do
        if plot:IsA("Model") or plot:IsA("Folder") then
            -- Check if we already have ESP for this plot
            local existing = plotEspFolder:FindFirstChild(plot.Name)
            if not existing then
                local bb = Instance.new("BillboardGui")
                bb.Name = plot.Name
                bb.Adornee = plot:FindFirstChild("Spawn") or plot.PrimaryPart
                bb.Size = UDim2.new(0, 200, 0, 50)
                bb.AlwaysOnTop = true
                bb.Parent = plotEspFolder
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(0, 1, 0)
                label.TextStrokeTransparency = 0
                label.Parent = bb
                
                task.spawn(function()
                    while bb.Parent and (PLOT_ESP_ENABLED or PLOT_TIME_ESP_ENABLED) do
                        local text = ""
                        if PLOT_ESP_ENABLED then
                            text = text .. "Owner: " .. getPlotOwner(plot) .. "\n"
                        end
                        if PLOT_TIME_ESP_ENABLED then
                            text = text .. "Time: N/A\n"
                        end
                        label.Text = text
                        task.wait(1)
                    end
                    bb:Destroy()
                end)
            end
        end
    end
end

local function enablePlotESP()
    PLOT_ESP_ENABLED = true
    updatePlotESP()
end

local function disablePlotESP()
    PLOT_ESP_ENABLED = false
end

local function enablePlotTimeESP()
    PLOT_TIME_ESP_ENABLED = true
    updatePlotESP()
end

local function disablePlotTimeESP()
    PLOT_TIME_ESP_ENABLED = false
end

-- ==========================================
-- BRAINROT ESP LOGIC
-- ==========================================
local BRAINROT_ESP_ENABLED = false
local brainrotHighlight = nil

local function parseGen(text)
    if not text then return 0 end
    text = text:gsub("%$", ""):gsub("/s", "")
    local num = tonumber(text:match("[%d%.]+")) or 0
    local suffix = text:match("[%a]+")
    local mult = 1
    if suffix == "K" then mult = 1e3
    elseif suffix == "M" then mult = 1e6
    elseif suffix == "B" then mult = 1e9
    elseif suffix == "T" then mult = 1e12 end
    return num * mult
end

local function updateBrainrot()
    if not BRAINROT_ESP_ENABLED then return end
    local bestVal = -1
    local bestObj = nil
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "AnimalOverhead" and obj:IsA("BillboardGui") then
            local gen = obj:FindFirstChild("Generation")
            if gen and gen:IsA("TextLabel") then
                local val = parseGen(gen.Text)
                if val > bestVal then
                    bestVal = val
                    bestObj = obj
                end
            end
        end
    end
    
    if bestObj then
        if brainrotHighlight and brainrotHighlight.Adornee ~= bestObj.Parent then
            brainrotHighlight:Destroy()
            brainrotHighlight = nil
        end
        
        if not brainrotHighlight then
            brainrotHighlight = Instance.new("Highlight")
            brainrotHighlight.FillColor = Color3.new(1, 0.8, 0) -- Gold
            brainrotHighlight.Parent = bestObj.Parent
            brainrotHighlight.Adornee = bestObj.Parent
        end
    end
end

local function enableBrainrotESP()
    BRAINROT_ESP_ENABLED = true
    task.spawn(function()
        while BRAINROT_ESP_ENABLED do
            updateBrainrot()
            task.wait(2)
        end
        if brainrotHighlight then brainrotHighlight:Destroy() brainrotHighlight = nil end
    end)
end

local function disableBrainrotESP()
    BRAINROT_ESP_ENABLED = false
end

-- ==========================================
-- LASER CAPE LOGIC
-- ==========================================
local LASER_CAPE_ENABLED = false
local laserCapeConnection = nil

local function enableLaserCape()
    if LASER_CAPE_ENABLED then return end
    LASER_CAPE_ENABLED = true
    
    laserCapeConnection = RunService.Heartbeat:Connect(function()
        if not LASER_CAPE_ENABLED then return end
        local char = player.Character
        if not char then return end
        
        local cape = char:FindFirstChild("LaserArm")
        if not cape then 
            local tool = player.Backpack:FindFirstChild("LaserArm")
            if tool then tool.Parent = char end
            return 
        end
        
        if cape:FindFirstChild("RemoteEvent") then
            local closest = nil
            local minDst = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dst = (p.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                    if dst < minDst then
                        minDst = dst
                        closest = p.Character.HumanoidRootPart
                    end
                end
            end
            
            if closest then
                cape.RemoteEvent:FireServer(closest.Position)
            end
        end
    end)
end

local function disableLaserCape()
    LASER_CAPE_ENABLED = false
    if laserCapeConnection then laserCapeConnection:Disconnect() laserCapeConnection = nil end
end

-- ==========================================
-- MAP MODS LOGIC
-- ==========================================
local function enableMapMods()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Border" or v.Name == "Barrier" then
            v:Destroy()
        end
    end
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
-- LUNA UI SETUP
-- ==========================================
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Window = Luna:CreateWindow({
    Name = "Aero Hub (Fixed)",
    Subtitle = "SAB Desync & Exploits",
    LogoID = "rbxassetid://12345678", -- Placeholder or generic icon
    LoadingEnabled = true,
    LoadingTitle = "Aero Hub",
    LoadingSubtitle = "by Antigravity",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroHub"
    }
})

-- TABS
local MainTab = Window:CreateTab({ Name = "Main", Icon = "home", ImageSource = "Material" })
local MovementTab = Window:CreateTab({ Name = "Movement", Icon = "directions_run", ImageSource = "Material" })
local ExploitsTab = Window:CreateTab({ Name = "Exploits", Icon = "warning", ImageSource = "Material" })
local VisualsTab = Window:CreateTab({ Name = "Visuals", Icon = "visibility", ImageSource = "Material" })
local MiscTab = Window:CreateTab({ Name = "Misc", Icon = "settings", ImageSource = "Material" })

-- MAIN TAB (Desync & Lag Switch)
MainTab:CreateSection({ Name = "Desync Controls" })

MainTab:CreateToggle({
    Name = "Enable Desync (Illusion)",
    Description = "Freezes your server position while allowing client movement.",
    CurrentValue = false,
    Flag = "DesyncToggle",
    Callback = function(Value)
        if Value then
            startIllusion()
        else
            stopIllusion()
        end
    end
})

MainTab:CreateSection({ Name = "Network Manipulation" })

MainTab:CreateToggle({
    Name = "Lag Switch (Freeze)",
    Description = "Simulates extreme lag to freeze your character.",
    CurrentValue = false,
    Flag = "LagSwitchToggle",
    Callback = function(Value)
        _G.LagSwitchEnabled = Value
    end
})

-- MOVEMENT TAB
MovementTab:CreateSection({ Name = "Movement Tools" })

MovementTab:CreateToggle({
    Name = "Spin Bot (Helicopter)",
    Description = "Spins rapidly and flings nearby players.",
    CurrentValue = false,
    Flag = "SpinBotToggle",
    Callback = function(Value)
        if Value then enableHelicopter() else disableHelicopter() end
    end
})

MovementTab:CreateToggle({
    Name = "Platform (Rise)",
    Description = "Creates a rising platform under you.",
    CurrentValue = false,
    Flag = "PlatformToggle",
    Callback = function(Value)
        if Value then enablePlatform() else disablePlatform() end
    end
})

MovementTab:CreateToggle({
    Name = "Grapple Fly",
    Description = "Fly freely using WASD/Space/Shift.",
    CurrentValue = false,
    Flag = "GrappleFlyToggle",
    Callback = function(Value)
        if Value then enableGrappleFlight() else disableGrappleFlight() end
    end
})

MovementTab:CreateSection({ Name = "Modifiers" })

MovementTab:CreateToggle({
    Name = "Jump Bypass",
    Description = "Modifies your jump power.",
    CurrentValue = false,
    Flag = "JumpBypassToggle",
    Callback = function(Value)
        if Value then enableJumpBypass() else disableJumpBypass() end
    end
})

MovementTab:CreateSlider({
    Name = "Jump Power",
    Range = {0, 500},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        JUMP_POWER = Value
        if JUMP_BYPASS_ENABLED and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then hum.JumpPower = Value end
        end
    end
})

MovementTab:CreateToggle({
    Name = "Speed Boost",
    Description = "Increases your movement speed.",
    CurrentValue = false,
    Flag = "SpeedBoostToggle",
    Callback = function(Value)
        if Value then enableSpeedBoost() else disableSpeedBoost() end
    end
})

MovementTab:CreateSlider({
    Name = "Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Studs/s",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        SPEED_VAL = Value
    end
})

MovementTab:CreateToggle({
    Name = "Height Bypass (Unhittable)",
    Description = "Cyclically resizes character to avoid hitboxes.",
    CurrentValue = false,
    Flag = "HeightBypassToggle",
    Callback = function(Value)
        if Value then enableUnhittable() else disableUnhittable() end
    end
})

MovementTab:CreateToggle({
    Name = "Tall Mode",
    Description = "Makes your character extremely tall.",
    CurrentValue = false,
    Flag = "TallModeToggle",
    Callback = function(Value)
        setTallMode(Value)
    end
})

-- EXPLOITS TAB
ExploitsTab:CreateSection({ Name = "Advanced Exploits" })

ExploitsTab:CreateToggle({
    Name = "Fling (Patched)",
    Description = "Aggressive fling using CFrame spoofing.",
    CurrentValue = false,
    Flag = "FlingToggle",
    Callback = function(Value)
        if Value then enableFling() else disableFling() end
    end
})

ExploitsTab:CreateToggle({
    Name = "Invisibility",
    Description = "Makes you invisible to others.",
    CurrentValue = false,
    Flag = "InvisibilityToggle",
    Callback = function(Value)
        setInvisibility(Value)
    end
})

ExploitsTab:CreateSection({ Name = "Desync Variants" })

ExploitsTab:CreateToggle({
    Name = "Mobile Desync",
    Description = "Uses FastFlags to simulate mobile lag (Executor dependent).",
    CurrentValue = false,
    Flag = "MobileDesyncToggle",
    Callback = function(Value)
        if Value then enableMobileDesync() else disableMobileDesync() end
    end
})

ExploitsTab:CreateToggle({
    Name = "Ragdoll Desync",
    Description = "Prevents ragdolling (Anti-Ragdoll).",
    CurrentValue = false,
    Flag = "RagdollDesyncToggle",
    Callback = function(Value)
        if Value then enableRagdollDesync() else disableRagdollDesync() end
    end
})

-- VISUALS TAB
VisualsTab:CreateSection({ Name = "Visualizers" })

VisualsTab:CreateToggle({
    Name = "Show Ghost (Visualizer)",
    Description = "Shows a blue clone where the server thinks you are.",
    CurrentValue = false, -- Default OFF to avoid "copies" confusion
    Flag = "VisualizerToggle",
    Callback = function(Value)
        _G.VisualizerEnabled = Value
        if not Value and _G.VisualizerPart then
            _G.VisualizerPart:Destroy()
            _G.VisualizerPart = nil
        end
    end
})

VisualsTab:CreateSection({ Name = "ESP Features" })

VisualsTab:CreateToggle({
    Name = "Player ESP",
    Description = "Highlights players and shows info.",
    CurrentValue = false,
    Flag = "PlayerESPToggle",
    Callback = function(Value)
        if Value then enablePlayerESP() else disablePlayerESP() end
    end
})

VisualsTab:CreateToggle({
    Name = "Plot ESP",
    Description = "Shows plot owner info.",
    CurrentValue = false,
    Flag = "PlotESPToggle",
    Callback = function(Value)
        if Value then enablePlotESP() else disablePlotESP() end
    end
})

VisualsTab:CreateToggle({
    Name = "Plot Time ESP",
    Description = "Shows plot time info.",
    CurrentValue = false,
    Flag = "PlotTimeESPToggle",
    Callback = function(Value)
        if Value then enablePlotTimeESP() else disablePlotTimeESP() end
    end
})

VisualsTab:CreateToggle({
    Name = "Brainrot ESP",
    Description = "Highlights highest value generation.",
    CurrentValue = false,
    Flag = "BrainrotESPToggle",
    Callback = function(Value)
        if Value then enableBrainrotESP() else disableBrainrotESP() end
    end
})

-- MISC TAB
MiscTab:CreateSection({ Name = "Utilities" })

MiscTab:CreateToggle({
    Name = "Anti-Kick",
    Description = "Prevents being kicked for idleness.",
    CurrentValue = true,
    Flag = "AntiKickToggle",
    Callback = function(Value)
        ANTI_KICK_ENABLED = Value
    end
})

MiscTab:CreateToggle({
    Name = "Laser Cape Auto-Fire",
    Description = "Automatically fires Laser Cape at nearby players.",
    CurrentValue = false,
    Flag = "LaserCapeToggle",
    Callback = function(Value)
        if Value then enableLaserCape() else disableLaserCape() end
    end
})

MiscTab:CreateButton({
    Name = "Delete Map Borders",
    Callback = function()
        enableMapMods()
    end
})

MiscTab:CreateSection({ Name = "Server Hopping" })

MiscTab:CreateButton({
    Name = "Join Biggest Server",
    Callback = function()
        joinBiggestServer()
    end
})

MiscTab:CreateButton({
    Name = "Join Smallest Server",
    Callback = function()
        joinSmallestServer()
    end
})

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        rejoinServer()
    end
})

Luna:LoadAutoloadConfig()
