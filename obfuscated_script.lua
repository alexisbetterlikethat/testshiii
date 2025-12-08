-- Run this BEFORE loading the cheat script
-- This will log all important operations

print("=== CHEAT SPY ACTIVE ===")

local logs = {}

local function log(category, message, data)
    local entry = {
        time = tick(),
        category = category,
        message = message,
        data = data
    }
    table.insert(logs, entry)
    print(string.format("[%s] %s: %s", category, message, tostring(data)))
end

-- Hook UserInputService for infinite jump detection
local UIS = game:GetService("UserInputService")
local oldJumpConnect = UIS.JumpRequest.Connect

UIS.JumpRequest.Connect = function(self, callback)
    log("HOOK", "JumpRequest connected", "Infinite Jump likely active")
    
    local wrappedCallback = function(...)
        log("EVENT", "JumpRequest fired", {...})
        local char = game.Players.LocalPlayer.Character
        if char then
            log("ACTION", "Character found", char.Name)
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                log("ACTION", "Humanoid state before", humanoid:GetState())
            end
        end
        
        local result = callback(...)
        
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                log("ACTION", "Humanoid state after", humanoid:GetState())
            end
        end
        
        return result
    end
    
    return oldJumpConnect(self, wrappedCallback)
end

-- Hook Mouse for aimbot detection
local mouse = game.Players.LocalPlayer:GetMouse()
local oldButton1Down = mouse.Button1Down
local oldButton1Up = mouse.Button1Up

mouse.Button1Down = newproxy and function(...)
    log("INPUT", "Mouse clicked", "Aimbot may activate")
    return oldButton1Down(...)
end or oldButton1Down

-- Hook Camera for aimbot detection
local camera = workspace.CurrentCamera
local oldCameraType = camera.CameraType

-- Monitor camera CFrame changes
local lastCFrame = camera.CFrame
game:GetService("RunService").RenderStepped:Connect(function()
    if camera.CFrame ~= lastCFrame then
        local rotationDiff = (camera.CFrame - lastCFrame).Rotation
        if rotationDiff.Magnitude > 0.1 then
            log("AIMBOT", "Camera snapped", rotationDiff.Magnitude)
        end
        lastCFrame = camera.CFrame
    end
end)

-- Hook Instance.new for ESP detection
local oldNew = Instance.new
Instance.new = function(className, parent)
    if className == "Highlight" then
        log("ESP", "Highlight created (Glow ESP)", parent and parent.Name or "nil")
    elseif className == "BoxHandleAdornment" then
        log("ESP", "BoxHandleAdornment created (Box ESP)", parent and parent.Name or "nil")
    elseif className == "Beam" then
        log("ESP", "Beam created (Tracers)", parent and parent.Name or "nil")
    elseif className == "BillboardGui" then
        log("ESP", "BillboardGui created (Distance ESP)", parent and parent.Name or "nil")
    elseif className == "ScreenGui" and parent == game.Players.LocalPlayer:WaitForChild("PlayerGui") then
        log("UI", "ScreenGui created", className)
    end
    
    return oldNew(className, parent)
end

-- Hook Players service to see ESP player tracking
local Players = game:GetService("Players")
local oldGetPlayers = Players.GetPlayers

Players.GetPlayers = function(self)
    local players = oldGetPlayers(self)
    log("ESP", "GetPlayers called", #players .. " players")
    return players
end

-- Monitor for FOV circle
task.spawn(function()
    while task.wait(1) do
        local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            local fovGui = playerGui:FindFirstChild("AimbotFOV")
            if fovGui then
                log("AIMBOT", "FOV Circle detected", "Enabled: " .. tostring(fovGui.Enabled))
                
                local frame = fovGui:FindFirstChild("Frame")
                if frame then
                    local stroke = frame:FindFirstChild("UIStroke")
                    if stroke then
                        log("AIMBOT", "FOV Circle size", frame.Size.X.Offset / 2)
                        log("AIMBOT", "FOV Circle color", stroke.Color)
                    end
                end
            end
        end
    end
end)

-- Hook loadstring to capture dynamically loaded code
local oldLoadstring = loadstring
loadstring = function(source)
    log("LOADSTRING", "Code loaded", #source .. " characters")
    if #source < 1000 then
        print("Source code:", source)
    end
    return oldLoadstring(source)
end

-- Hook HttpGet to see what's downloaded
local oldHttpGet = game.HttpGet
game.HttpGet = function(self, url)
    log("DOWNLOAD", "HttpGet", url)
    return oldHttpGet(self, url)
end

print("=== SPY READY - Load your script now ===")
print("=== Use /logs to dump all captured data ===")

-- Command to dump logs
getgenv().dumpLogs = function()
    print("\n=== DUMPING ALL LOGS ===")
    for i, entry in ipairs(logs) do
        print(string.format("[%d] [%.2f] [%s] %s: %s", 
            i, 
            entry.time, 
            entry.category, 
            entry.message, 
            tostring(entry.data)
        ))
    end
    print("=== END LOGS ===\n")
end

-- After loading the cheat, type: dumpLogs() in console
