-- MINIMAL Cheat Spy - Won't crash your game
print("=== CHEAT SPY ACTIVE ===")

local logs = {}

local function log(category, message, data)
    local entry = string.format("[%s] [%s] %s: %s", 
        os.date("%X"),
        category,
        message,
        tostring(data or "")
    )
    table.insert(logs, entry)
    print(entry)
end

-- Hook Instance.new to detect cheat elements
local oldNew = Instance.new
Instance.new = function(className, parent)
    local obj = oldNew(className, parent)
    
    -- Detect ESP
    if className == "Highlight" then
        log("ESP", "Glow ESP created", parent and parent.Name or "?")
    elseif className == "BoxHandleAdornment" then
        log("ESP", "Box ESP created", parent and parent.Name or "?")
    elseif className == "Beam" then
        log("ESP", "Tracer beam created", parent and parent.Name or "?")
    elseif className == "BillboardGui" then
        log("ESP", "Distance label created", parent and parent.Name or "?")
    elseif className == "ScreenGui" then
        log("UI", "GUI created", obj.Name)
    elseif className == "UIStroke" then
        log("AIMBOT", "FOV circle stroke", "Color: " .. tostring(obj.Color))
    end
    
    return obj
end

-- Hook HttpGet
local oldHttpGet = game.HttpGet
game.HttpGet = function(self, url)
    log("DOWNLOAD", "Fetching", url)
    local result = oldHttpGet(self, url)
    log("DOWNLOAD", "Got", #result .. " characters")
    return result
end

-- Hook loadstring
local oldLoadstring = loadstring
loadstring = function(source)
    log("EXEC", "Loading code", #source .. " chars")
    return oldLoadstring(source)
end

-- Monitor for cheat activity passively
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- Watch for camera snapping (aimbot)
local lastCFrame = workspace.CurrentCamera.CFrame
local snapCount = 0

RunService.RenderStepped:Connect(function()
    local currentCFrame = workspace.CurrentCamera.CFrame
    
    if currentCFrame ~= lastCFrame then
        local rotation = math.deg(math.acos(
            math.clamp(currentCFrame.LookVector:Dot(lastCFrame.LookVector), -1, 1)
        ))
        
        if rotation > 10 then
            snapCount = snapCount + 1
            if snapCount % 30 == 0 then
                log("AIMBOT", "Camera snap", string.format("%.1f degrees", rotation))
            end
        end
    end
    
    lastCFrame = currentCFrame
end)

-- Watch for ESP elements being added
task.spawn(function()
    while task.wait(3) do
        local highlights = 0
        local beams = 0
        local boxes = 0
        
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character then
                -- Count highlights (glow ESP)
                if player.Character:FindFirstChildOfClass("Highlight") then
                    highlights = highlights + 1
                end
                
                -- Count beams (tracers)
                for _, obj in pairs(player.Character:GetDescendants()) do
                    if obj:IsA("Beam") then
                        beams = beams + 1
                    elseif obj:IsA("BoxHandleAdornment") then
                        boxes = boxes + 1
                    end
                end
            end
        end
        
        if highlights > 0 or beams > 0 or boxes > 0 then
            log("ESP", "Active", string.format("Glow:%d Tracers:%d Boxes:%d", highlights, beams, boxes))
        end
        
        -- Check for FOV circle
        local playerGui = Player:FindFirstChild("PlayerGui")
        if playerGui then
            local fovGui = playerGui:FindFirstChild("AimbotFOV")
            if fovGui then
                local frame = fovGui:FindFirstChild("Frame")
                if frame and frame.Visible then
                    log("AIMBOT", "FOV circle visible", "Radius: " .. (frame.Size.X.Offset / 2))
                end
            end
        end
    end
end)

-- Watch for infinite jump
local function monitorCharacter(char)
    task.wait(1)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local airJumps = 0
    local lastState = humanoid:GetState()
    
    humanoid.StateChanged:Connect(function(_, new)
        if new == Enum.HumanoidStateType.Jumping then
            if lastState == Enum.HumanoidStateType.Freefall or 
               lastState == Enum.HumanoidStateType.Jumping then
                airJumps = airJumps + 1
                if airJumps >= 2 then
                    log("CHEAT", "Infinite Jump active", "Air jump #" .. airJumps)
                end
            else
                airJumps = 0
            end
        elseif new == Enum.HumanoidStateType.Landed then
            airJumps = 0
        end
        lastState = new
    end)
end

if Player.Character then
    monitorCharacter(Player.Character)
end

Player.CharacterAdded:Connect(function(char)
    log("PLAYER", "Character spawned", "")
    monitorCharacter(char)
end)

print("=== SPY READY - Load cheat now ===")

-- Dump logs to clipboard
getgenv().dumpLogs = function()
    local output = "========== CHEAT SPY LOGS ==========\n"
    output = output .. "Total entries: " .. #logs .. "\n\n"
    
    for i, entry in ipairs(logs) do
        output = output .. string.format("[%d] %s\n", i, entry)
    end
    
    output = output .. "\n========== END LOGS =========="
    
    -- Copy to clipboard
    if setclipboard then
        setclipboard(output)
        print("✓ Logs copied to clipboard! (" .. #logs .. " entries)")
    else
        print(output)
        print("⚠ setclipboard not available - logs printed above")
    end
    
    return output
end

getgenv().clearLogs = function()
    logs = {}
    print("✓ Logs cleared!")
end

print("Commands: dumpLogs() | clearLogs()")
