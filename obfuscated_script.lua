-- Advanced Aimbot Detection - More sensitive
print("=== ADVANCED CHEAT SPY ===")
print("Monitoring with higher sensitivity for aimbot")
print("=====================================\n")

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

log("INIT", "Advanced spy started")

-- Track camera with high sensitivity
task.spawn(function()
    local Camera = workspace.CurrentCamera
    local lastCFrame = Camera.CFrame
    local lastPosition = Camera.CFrame.Position
    local lastLookVector = Camera.CFrame.LookVector
    
    local totalRotation = 0
    local frameCount = 0
    local suspiciousMovements = 0
    
    while task.wait(0.016) do -- 60 FPS monitoring
        pcall(function()
            local currentCFrame = Camera.CFrame
            local currentPosition = currentCFrame.Position
            local currentLookVector = currentCFrame.LookVector
            
            frameCount = frameCount + 1
            
            -- Detect ANY camera rotation
            local rotationAngle = math.deg(math.acos(math.clamp(
                currentLookVector:Dot(lastLookVector), -1, 1
            )))
            
            if rotationAngle > 0.1 then -- Very sensitive threshold
                totalRotation = totalRotation + rotationAngle
                
                -- Look for smooth, consistent movements (aimbot signature)
                if rotationAngle > 0.5 and rotationAngle < 10 then
                    suspiciousMovements = suspiciousMovements + 1
                    
                    if suspiciousMovements % 30 == 0 then
                        log("AIMBOT", string.format("Smooth tracking detected (%.2f° movement)", rotationAngle))
                    end
                end
                
                -- Log large snaps
                if rotationAngle > 15 then
                    log("AIMBOT", string.format("Camera snap: %.1f degrees", rotationAngle))
                end
            end
            
            -- Report every 5 seconds if camera moved
            if frameCount % 300 == 0 and totalRotation > 1 then
                log("CAMERA", string.format("Total rotation in 5s: %.1f degrees", totalRotation))
                totalRotation = 0
            end
            
            lastCFrame = currentCFrame
            lastPosition = currentPosition
            lastLookVector = currentLookVector
        end)
    end
end)

-- Monitor mouse input
task.spawn(function()
    local UserInputService = game:GetService("UserInputService")
    local mouseDownTime = 0
    local isAiming = false
    
    while task.wait(0.1) do
        pcall(function()
            local mouseDown = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            
            if mouseDown and not isAiming then
                log("INPUT", "Mouse1 DOWN - Aimbot may activate")
                isAiming = true
                mouseDownTime = tick()
            elseif not mouseDown and isAiming then
                local duration = tick() - mouseDownTime
                log("INPUT", string.format("Mouse1 UP (held %.1fs)", duration))
                isAiming = false
            end
        end)
    end
end)

-- Monitor player positions for targeting
task.spawn(function()
    local Player = game:GetService("Players").LocalPlayer
    
    while task.wait(0.5) do
        pcall(function()
            local Camera = workspace.CurrentCamera
            local screenCenter = Vector2.new(
                Camera.ViewportSize.X / 2,
                Camera.ViewportSize.Y / 2
            )
            
            -- Find closest player to crosshair
            local closestDist = math.huge
            local closestPlayer = nil
            
            for _, otherPlayer in pairs(game:GetService("Players"):GetPlayers()) do
                if otherPlayer ~= Player and otherPlayer.Character then
                    local head = otherPlayer.Character:FindFirstChild("Head")
                    if head then
                        local screenPos, onScreen = Camera:WorldToScreenPoint(head.Position)
                        
                        if onScreen then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                            
                            if dist < closestDist then
                                closestDist = dist
                                closestPlayer = otherPlayer
                            end
                        end
                    end
                end
            end
            
            if closestPlayer and closestDist < 200 then
                log("TARGET", string.format("Player '%s' near crosshair (%.0fpx away)", 
                    closestPlayer.Name, closestDist))
            end
        end)
    end
end)

-- Standard ESP monitoring
task.spawn(function()
    local lastESPCount = 0
    local lastFOVState = false
    
    while task.wait(1) do
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local playerGui = player:FindFirstChild("PlayerGui")
            
            if playerGui then
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
                end
            end
            
            local highlights = 0
            for _, otherPlayer in pairs(game:GetService("Players"):GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    if otherPlayer.Character:FindFirstChildOfClass("Highlight") then
                        highlights = highlights + 1
                    end
                end
            end
            
            if highlights ~= lastESPCount then
                log("ESP", string.format("Glow ESP: %d players", highlights))
                lastESPCount = highlights
            end
        end)
    end
end)

print("\n=== Commands ===")
print("logs() - Show all logs")
print("copy() - Copy to clipboard")
print("clear() - Clear logs")

getgenv().logs = function()
    print("\n========== ALL LOGS ==========")
    for i, entry in ipairs(logs) do
        print(string.format("[%d] %s", i, entry))
    end
    print(string.format("========== %d total ==========\n", #logs))
end

getgenv().copy = function()
    local output = "========== ADVANCED CHEAT SPY ==========\n"
    output = output .. string.format("Total: %d events\n\n", #logs)
    
    for i, entry in ipairs(logs) do
        output = output .. entry .. "\n"
    end
    
    output = output .. "\n========== END ==========\n"
    
    if setclipboard then
        setclipboard(output)
        print(string.format("✓ %d logs copied!", #logs))
    else
        print(output)
    end
end

getgenv().clear = function()
    logs = {}
    print("✓ Cleared")
end
