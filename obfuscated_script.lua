-- ULTRA MINIMAL Cheat Monitor - No event connections at all
print("=== CHEAT SPY ACTIVE ===")

local logs = {}

local function log(category, message)
    local entry = string.format("[%s] [%s] %s", 
        os.date("%X"),
        category,
        message
    )
    table.insert(logs, entry)
    print(entry)
end

local Player = game:GetService("Players").LocalPlayer

log("INIT", "Spy started - load your cheat now")

-- Main monitoring loop - uses task.spawn instead of Connect
task.spawn(function()
    local Camera = workspace.CurrentCamera
    local lastCFrame = Camera.CFrame
    local lastFOVState = false
    local lastESPCount = 0
    local snapCount = 0
    
    while task.wait(0.5) do
        -- Monitor camera for aimbot
        local currentCFrame = Camera.CFrame
        if currentCFrame ~= lastCFrame then
            local angle = math.deg(math.acos(math.clamp(
                currentCFrame.LookVector:Dot(lastCFrame.LookVector), -1, 1
            )))
            
            if angle > 15 then
                snapCount = snapCount + 1
                if snapCount % 10 == 0 then
                    log("AIMBOT", string.format("Camera snap (%.1f degrees)", angle))
                end
            end
            lastCFrame = currentCFrame
        end
        
        -- Check for FOV circle
        local success, playerGui = pcall(function()
            return Player:FindFirstChild("PlayerGui")
        end)
        
        if success and playerGui then
            local fovGui = playerGui:FindFirstChild("AimbotFOV")
            if fovGui then
                local frame = fovGui:FindFirstChild("Frame")
                if frame then
                    local isVisible = fovGui.Enabled
                    if isVisible and not lastFOVState then
                        local radius = frame.Size.X.Offset / 2
                        log("AIMBOT", string.format("FOV Circle ON (radius: %d)", radius))
                        lastFOVState = true
                    elseif not isVisible and lastFOVState then
                        log("AIMBOT", "FOV Circle OFF")
                        lastFOVState = false
                    end
                end
            end
        end
        
        -- Count ESP elements
        local highlights = 0
        local beams = 0
        local boxes = 0
        
        local playersSuccess, players = pcall(function()
            return game:GetService("Players"):GetPlayers()
        end)
        
        if playersSuccess then
            for _, player in pairs(players) do
                if player ~= Player then
                    local charSuccess, char = pcall(function()
                        return player.Character
                    end)
                    
                    if charSuccess and char then
                        -- Glow ESP
                        for _, obj in pairs(char:GetChildren()) do
                            if obj:IsA("Highlight") then
                                highlights = highlights + 1
                            end
                        end
                        
                        -- Tracers and boxes
                        for _, obj in pairs(char:GetDescendants()) do
                            if obj:IsA("Beam") then
                                beams = beams + 1
                            elseif obj:IsA("BoxHandleAdornment") then
                                boxes = boxes + 1
                            end
                        end
                    end
                end
            end
        end
        
        local totalESP = highlights + beams + boxes
        if totalESP > 0 and totalESP ~= lastESPCount then
            log("ESP", string.format("Glow:%d Tracers:%d Boxes:%d", highlights, beams, boxes))
            lastESPCount = totalESP
        elseif totalESP == 0 and lastESPCount > 0 then
            log("ESP", "All ESP disabled")
            lastESPCount = 0
        end
    end
end)

-- Monitor for infinite jump
task.spawn(function()
    while task.wait(0.3) do
        local charSuccess, char = pcall(function()
            return Player.Character
        end)
        
        if charSuccess and char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local state = humanoid:GetState()
                
                -- Simple detection: if jumping while already in freefall
                if state == Enum.HumanoidStateType.Jumping then
                    local rootPart = char:FindFirstChild("HumanoidRootPart")
                    if rootPart and rootPart.Velocity.Y > 0 then
                        log("CHEAT", "Infinite Jump detected")
                        task.wait(2) -- Cooldown to avoid spam
                    end
                end
            end
        end
    end
end)

-- Monitor for new GUIs
task.spawn(function()
    local knownGuis = {}
    
    while task.wait(1) do
        local success, playerGui = pcall(function()
            return Player:FindFirstChild("PlayerGui")
        end)
        
        if success and playerGui then
            for _, gui in pairs(playerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and not knownGuis[gui.Name] then
                    log("UI", string.format("New GUI: %s", gui.Name))
                    knownGuis[gui.Name] = true
                end
            end
        end
    end
end)

print("=== SPY READY ===")
print("Commands: dumpLogs() | clearLogs() | showLogs()")

-- Safe commands
getgenv().dumpLogs = function()
    local output = "=== CHEAT SPY LOGS ===\n"
    output = output .. string.format("Total: %d events\n\n", #logs)
    
    for i, entry in ipairs(logs) do
        output = output .. entry .. "\n"
    end
    
    output = output .. "\n=== END LOGS ===\n"
    
    local success, err = pcall(function()
        setclipboard(output)
    end)
    
    if success then
        print(string.format("✓ %d logs copied to clipboard!", #logs))
    else
        print(output)
        warn("Clipboard not available - printed above")
    end
end

getgenv().clearLogs = function()
    local count = #logs
    logs = {}
    print(string.format("✓ Cleared %d logs", count))
end

getgenv().showLogs = function()
    print("\n=== LAST 15 LOGS ===")
    local start = math.max(1, #logs - 14)
    for i = start, #logs do
        print(logs[i])
    end
    print(string.format("=== %d total logs ===\n", #logs))
end
