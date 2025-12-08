-- PASSIVE Cheat Monitor - No hooks, just observation
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
local RunService = game:GetService("RunService")

log("INIT", "Spy started - waiting for cheat to load...")

-- Monitor camera for aimbot
local Camera = workspace.CurrentCamera
local lastCFrame = Camera.CFrame
local snapCount = 0

RunService.RenderStepped:Connect(function()
    local current = Camera.CFrame
    
    if current ~= lastCFrame then
        local angle = math.deg(math.acos(math.clamp(
            current.LookVector:Dot(lastCFrame.LookVector), -1, 1
        )))
        
        if angle > 15 then
            snapCount = snapCount + 1
            if snapCount % 20 == 0 then
                log("AIMBOT", string.format("Camera snap detected (%.1f°)", angle))
            end
        end
    end
    
    lastCFrame = current
end)

-- Scan for ESP and GUI elements every 2 seconds
task.spawn(function()
    local lastFOVState = false
    local lastESPCount = 0
    
    while task.wait(2) do
        -- Check PlayerGui for FOV circle
        local playerGui = Player:FindFirstChild("PlayerGui")
        if playerGui then
            local fovGui = playerGui:FindFirstChild("AimbotFOV")
            if fovGui then
                local frame = fovGui:FindFirstChild("Frame")
                if frame then
                    local isVisible = fovGui.Enabled
                    if isVisible and not lastFOVState then
                        local radius = frame.Size.X.Offset / 2
                        log("AIMBOT", string.format("FOV Circle enabled (Radius: %d)", radius))
                        lastFOVState = true
                    elseif not isVisible and lastFOVState then
                        log("AIMBOT", "FOV Circle disabled")
                        lastFOVState = false
                    end
                end
            end
        end
        
        -- Count ESP elements
        local highlights = 0
        local beams = 0
        local boxes = 0
        local billboards = 0
        
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character then
                local char = player.Character
                
                -- Glow ESP (Highlight)
                for _, obj in pairs(char:GetChildren()) do
                    if obj:IsA("Highlight") then
                        highlights = highlights + 1
                    end
                end
                
                -- Tracers and Box ESP
                for _, obj in pairs(char:GetDescendants()) do
                    if obj:IsA("Beam") then
                        beams = beams + 1
                    elseif obj:IsA("BoxHandleAdornment") then
                        boxes = boxes + 1
                    elseif obj:IsA("BillboardGui") then
                        billboards = billboards + 1
                    end
                end
            end
        end
        
        local totalESP = highlights + beams + boxes + billboards
        
        if totalESP > 0 and totalESP ~= lastESPCount then
            log("ESP", string.format("Active - Glow:%d Tracers:%d Boxes:%d Distance:%d", 
                highlights, beams, boxes, billboards))
            lastESPCount = totalESP
        elseif totalESP == 0 and lastESPCount > 0 then
            log("ESP", "All ESP disabled")
            lastESPCount = 0
        end
    end
end)

-- Monitor for infinite jump
local function watchCharacter(char)
    task.wait(1)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local midairJumps = 0
    local lastState = Enum.HumanoidStateType.Freefall
    
    humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Jumping then
            -- Check if jumping while in air
            if old == Enum.HumanoidStateType.Freefall or 
               old == Enum.HumanoidStateType.Jumping then
                midairJumps = midairJumps + 1
                if midairJumps == 1 then
                    log("CHEAT", "Infinite Jump detected (mid-air jump)")
                end
            else
                midairJumps = 0
            end
        elseif new == Enum.HumanoidStateType.Landed then
            if midairJumps > 0 then
                midairJumps = 0
            end
        end
        
        lastState = new
    end)
end

if Player.Character then
    watchCharacter(Player.Character)
end

Player.CharacterAdded:Connect(function(char)
    log("PLAYER", "Character respawned")
    watchCharacter(char)
end)

-- Watch for new GUIs being added
Player:WaitForChild("PlayerGui").ChildAdded:Connect(function(gui)
    if gui:IsA("ScreenGui") then
        log("UI", string.format("New GUI added: %s", gui.Name))
    end
end)

print("=== SPY READY ===")
print("Load your cheat now, then use the cheat features")
print("Type: dumpLogs() to copy all logs to clipboard")

-- Commands
getgenv().dumpLogs = function()
    local output = "========== CHEAT SPY LOGS ==========\n"
    output = output .. string.format("Captured %d events\n\n", #logs)
    
    for i, entry in ipairs(logs) do
        output = output .. entry .. "\n"
    end
    
    output = output .. "\n========== END ==========\n"
    
    if setclipboard then
        setclipboard(output)
        print(string.format("✓ %d logs copied to clipboard!", #logs))
    else
        print(output)
        warn("setclipboard not available")
    end
end

getgenv().clearLogs = function()
    local count = #logs
    logs = {}
    print(string.format("✓ Cleared %d logs", count))
end

getgenv().showLogs = function()
    print("\n=== RECENT LOGS ===")
    local start = math.max(1, #logs - 20)
    for i = start, #logs do
        print(logs[i])
    end
    print(string.format("=== Showing last %d of %d logs ===\n", math.min(20, #logs), #logs))
end
