-- FIXED Cheat Spy - Run this BEFORE loading the cheat script
print("=== CHEAT SPY ACTIVE ===")

local logs = {}

local function log(category, message, data)
    local entry = {
        time = os.date("%X"),
        category = category,
        message = message,
        data = data or ""
    }
    table.insert(logs, entry)
    print(string.format("[%s] [%s] %s: %s", entry.time, category, message, tostring(data)))
end

-- Store original functions
local originals = {}

-- Hook Instance.new to detect ESP elements
originals.InstanceNew = Instance.new
Instance.new = function(className, parent)
    local obj = originals.InstanceNew(className, parent)
    
    if className == "Highlight" then
        log("ESP", "Glow ESP created", parent and parent.Name or "unknown")
    elseif className == "BoxHandleAdornment" then
        log("ESP", "Box ESP created", parent and parent.Name or "unknown")
    elseif className == "Beam" then
        log("ESP", "Tracer created", parent and parent.Name or "unknown")
    elseif className == "BillboardGui" then
        log("ESP", "Billboard created (Distance?)", parent and parent.Name or "unknown")
    elseif className == "ScreenGui" then
        log("UI", "ScreenGui created", parent and parent.Name or "unknown")
    elseif className == "Frame" and parent and parent.Name == "AimbotFOV" then
        log("AIMBOT", "FOV Circle Frame created", "")
    end
    
    return obj
end

-- Hook HttpGet to see downloads
originals.HttpGet = game.HttpGet
game.HttpGet = function(self, url)
    log("DOWNLOAD", "Fetching", url)
    local result = originals.HttpGet(self, url)
    log("DOWNLOAD", "Downloaded", #result .. " chars")
    return result
end

-- Hook loadstring
originals.loadstring = loadstring
loadstring = function(source)
    log("EXEC", "Loadstring called", #source .. " chars")
    return originals.loadstring(source)
end

-- Monitor Camera for aimbot
local Camera = workspace.CurrentCamera
local lastCFrame = Camera.CFrame
local cframeChanges = 0

game:GetService("RunService").RenderStepped:Connect(function()
    if Camera.CFrame ~= lastCFrame then
        local posDiff = (Camera.CFrame.Position - lastCFrame.Position).Magnitude
        local rotDiff = math.deg(math.acos(Camera.CFrame.LookVector:Dot(lastCFrame.LookVector)))
        
        if rotDiff > 5 then
            cframeChanges = cframeChanges + 1
            if cframeChanges % 60 == 0 then
                log("AIMBOT", "Camera snap detected", string.format("Rotation: %.2f degrees", rotDiff))
            end
        end
        
        lastCFrame = Camera.CFrame
    end
end)

-- Monitor for FOV circle and ESP elements
task.spawn(function()
    while task.wait(2) do
        local PlayerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        if not PlayerGui then continue end
        
        -- Check for FOV circle
        local fovGui = PlayerGui:FindFirstChild("AimbotFOV")
        if fovGui and fovGui:IsA("ScreenGui") then
            local frame = fovGui:FindFirstChild("Frame")
            if frame then
                local stroke = frame:FindFirstChild("UIStroke")
                if stroke then
                    log("AIMBOT", "FOV Active", string.format("Size: %d, Color: %s", 
                        frame.Size.X.Offset / 2,
                        tostring(stroke.Color)))
                end
            end
        end
        
        -- Count ESP elements
        local highlights = 0
        local beams = 0
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local char = player.Character
                if char:FindFirstChildOfClass("Highlight") then
                    highlights = highlights + 1
                end
                
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("Beam") then
                        beams = beams + 1
                    end
                end
            end
        end
        
        if highlights > 0 then
            log("ESP", "Glow ESP active", highlights .. " players")
        end
        if beams > 0 then
            log("ESP", "Tracers active", beams .. " tracers")
        end
    end
end)

-- Monitor mouse for aimbot activation
local Mouse = game.Players.LocalPlayer:GetMouse()
local isMouseDown = false

Mouse.Button1Down:Connect(function()
    isMouseDown = true
    log("INPUT", "Mouse1 Down", "Possible aimbot activation")
end)

Mouse.Button1Up:Connect(function()
    isMouseDown = false
    log("INPUT", "Mouse1 Up", "")
end)

-- Monitor character humanoid for infinite jump
local function watchCharacter(char)
    local humanoid = char:WaitForChild("Humanoid")
    local jumpCount = 0
    local lastJumpTime = 0
    
    humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Jumping then
            jumpCount = jumpCount + 1
            local currentTime = tick()
            
            if currentTime - lastJumpTime < 0.5 and jumpCount > 2 then
                log("CHEAT", "Infinite Jump detected", "Jump #" .. jumpCount)
            end
            
            lastJumpTime = currentTime
            
            task.delay(1, function()
                jumpCount = 0
            end)
        end
    end)
end

if game.Players.LocalPlayer.Character then
    watchCharacter(game.Players.LocalPlayer.Character)
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    log("PLAYER", "Character spawned", "")
    watchCharacter(char)
end)

print("=== SPY READY ===")
print("Load your cheat now!")
print("Type dumpLogs() to see all captured logs")

-- Command to dump all logs
getgenv().dumpLogs = function()
    print("\n========== CAPTURED LOGS ==========")
    for i, entry in ipairs(logs) do
        print(string.format("[%d] [%s] [%s] %s: %s", 
            i,
            entry.time,
            entry.category,
            entry.message,
            entry.data
        ))
    end
    print("========== END LOGS (" .. #logs .. " entries) ==========\n")
end

getgenv().clearLogs = function()
    logs = {}
    print("Logs cleared!")
end
