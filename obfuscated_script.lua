-- Delta Executor Compatible Cheat Monitor
print("=== CHEAT SPY (Delta Compatible) ===")

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

log("INIT", "Monitoring started - load your cheat now")

-- Main monitoring loop with full error protection
task.spawn(function()
    local lastFOVState = false
    local lastESPCount = 0
    
    while true do
        local success, err = pcall(function()
            -- Get player safely
            local player = game:GetService("Players").LocalPlayer
            if not player then return end
            
            -- Check PlayerGui for cheat elements
            local playerGui = player:FindFirstChild("PlayerGui")
            if playerGui then
                -- Look for FOV circle
                local fovGui = playerGui:FindFirstChild("AimbotFOV")
                if fovGui then
                    local isVisible = fovGui.Enabled
                    if isVisible and not lastFOVState then
                        log("AIMBOT", "FOV Circle enabled")
                        lastFOVState = true
                    elseif not isVisible and lastFOVState then
                        log("AIMBOT", "FOV Circle disabled")
                        lastFOVState = false
                    end
                    
                    if isVisible then
                        local frame = fovGui:FindFirstChild("Frame")
                        if frame then
                            local radius = frame.Size.X.Offset / 2
                            log("AIMBOT", string.format("FOV size: %d pixels", radius))
                        end
                    end
                end
                
                -- Check for other cheat GUIs
                for _, gui in pairs(playerGui:GetChildren()) do
                    if gui:IsA("ScreenGui") and 
                       (gui.Name:lower():find("esp") or 
                        gui.Name:lower():find("cheat") or
                        gui.Name:lower():find("hack")) then
                        log("UI", string.format("Cheat GUI found: %s", gui.Name))
                    end
                end
            end
            
            -- Count ESP elements on players
            local highlights = 0
            local beams = 0
            local boxes = 0
            
            for _, otherPlayer in pairs(game:GetService("Players"):GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local char = otherPlayer.Character
                    
                    -- Glow ESP
                    if char:FindFirstChildOfClass("Highlight") then
                        highlights = highlights + 1
                    end
                    
                    -- Tracers and boxes
                    for _, descendant in pairs(char:GetDescendants()) do
                        if descendant:IsA("Beam") then
                            beams = beams + 1
                        elseif descendant:IsA("BoxHandleAdornment") then
                            boxes = boxes + 1
                        end
                    end
                end
            end
            
            local totalESP = highlights + beams + boxes
            if totalESP > 0 and totalESP ~= lastESPCount then
                log("ESP", string.format("Active - Glow:%d Tracers:%d Boxes:%d", 
                    highlights, beams, boxes))
                lastESPCount = totalESP
            elseif totalESP == 0 and lastESPCount > 0 then
                log("ESP", "Disabled")
                lastESPCount = 0
            end
            
            -- Check for infinite jump by monitoring humanoid
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local state = humanoid:GetState()
                    if state == Enum.HumanoidStateType.Jumping then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root and root.AssemblyLinearVelocity.Y > 20 then
                            log("CHEAT", "Possible infinite jump")
                        end
                    end
                end
            end
        end)
        
        if not success then
            -- Silently ignore errors from Delta protections
        end
        
        task.wait(1)
    end
end)

print("=== SPY RUNNING ===")
print("Type: dumpLogs() to copy results")

getgenv().dumpLogs = function()
    local output = "========== CHEAT SPY LOGS ==========\n"
    output = output .. string.format("Total entries: %d\n\n", #logs)
    
    for i, entry in ipairs(logs) do
        output = output .. entry .. "\n"
    end
    
    output = output .. "\n========== END LOGS ==========\n"
    
    if setclipboard then
        setclipboard(output)
        print(string.format("✓ Copied %d logs to clipboard!", #logs))
    else
        print(output)
    end
end

getgenv().clearLogs = function()
    logs = {}
    print("✓ Logs cleared")
end

getgenv().showLogs = function()
    print("\n=== LOGS ===")
    for i, entry in ipairs(logs) do
        print(entry)
    end
    print(string.format("=== %d total ===\n", #logs))
end
