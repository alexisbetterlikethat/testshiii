--[[
    AERO HUB - GAME DUMPER (REWRITTEN)
    Focus: Stability, Speed, and Utility.
]]

local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Window = Luna:CreateWindow({
    Name = "Aero Dumper",
    Subtitle = "Reliable Game Analysis",
    LogoID = "6031097225",
    LoadingEnabled = false,
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroDumper"
    }
})

local Tab = Window:CreateTab({
    Name = "Dumper",
    Icon = "save",
    ImageSource = "Material"
})

-- Configuration
local Config = {
    DumpScripts = true,
    DumpRemotes = true,
    DumpHierarchy = true,
    SaveToFile = true
}

-- Utility Functions
local function safeDecompile(scriptObj)
    if not decompile then return "-- Decompiler not supported" end
    local success, source = pcall(decompile, scriptObj)
    if success then return source end
    return "-- Decompilation failed"
end

local function getPath(obj)
    local success, path = pcall(function() return obj:GetFullName() end)
    if success then return path end
    return obj.Name
end

-- Main Dumper Logic
local function StartDump()
    local output = {}
    local function log(str) table.insert(output, str) end
    
    log("=== AERO GAME DUMP ===")
    log("Date: " .. os.date("%Y-%m-%d %H:%M:%S"))
    log("Place ID: " .. game.PlaceId)
    log("Job ID: " .. game.JobId)
    log("Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown"))
    log("\n")

    -- Services to Scan
    local services = {
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterGui"),
        game:GetService("StarterPack"),
        game:GetService("StarterPlayer"),
        game:GetService("Teams"),
        game:GetService("SoundService"),
        game:GetService("Lighting"),
        game:GetService("ReplicatedFirst"),
        game:GetService("Workspace") -- Included, but we will be careful
    }

    local totalItems = 0
    local startTime = os.clock()

    for _, service in ipairs(services) do
        log("--- SERVICE: " .. service.Name .. " ---")
        print("Dumping Service: " .. service.Name)
        
        -- Use GetDescendants for a flat list (easier to yield)
        local descendants = service:GetDescendants()
        
        for i, obj in ipairs(descendants) do
            if i % 500 == 0 then task.wait() end -- Yield every 500 items
            
            local isRemote = obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")
            local isScript = obj:IsA("LocalScript") or obj:IsA("ModuleScript")
            
            if isRemote and Config.DumpRemotes then
                log("[REMOTE] " .. getPath(obj) .. " (" .. obj.ClassName .. ")")
            elseif isScript and Config.DumpScripts then
                log("[SCRIPT] " .. getPath(obj) .. " (" .. obj.ClassName .. ")")
                log("    --- SOURCE START ---")
                local src = safeDecompile(obj)
                log(src)
                log("    --- SOURCE END ---")
            elseif Config.DumpHierarchy then
                -- Only log interesting things in hierarchy to save space/time
                if obj:IsA("ValueBase") or obj:IsA("ScreenGui") or obj:IsA("ProximityPrompt") then
                     log("[OBJ] " .. getPath(obj) .. " (" .. obj.ClassName .. ")")
                end
            end
            
            totalItems = totalItems + 1
        end
        log("\n")
        task.wait()
    end
    
    local endTime = os.clock()
    log("Dump finished in " .. string.format("%.2f", endTime - startTime) .. " seconds.")
    log("Total items scanned: " .. totalItems)
    
    return table.concat(output, "\n")
end

-- UI Elements
Tab:CreateSection("Settings")

Tab:CreateToggle({
    Name = "Dump Scripts (Decompile)",
    CurrentValue = true,
    Callback = function(val) Config.DumpScripts = val end
}, "DumpScripts")

Tab:CreateToggle({
    Name = "Dump Remotes",
    CurrentValue = true,
    Callback = function(val) Config.DumpRemotes = val end
}, "DumpRemotes")

Tab:CreateSection("Actions")

Tab:CreateButton({
    Name = "START DUMP",
    Description = "Saves dump to workspace folder",
    Callback = function()
        print("Starting Dump Process...")
        Luna:Notification({
            Title = "Starting Dump",
            Content = "Check console (F9) for progress.",
            Icon = "info",
            ImageSource = "Lucide"
        })
        
        task.defer(function()
            local success, result = pcall(StartDump)
            
            if success then
                local fileName = "AeroDump_" .. game.PlaceId .. "_" .. os.time() .. ".txt"
                writefile(fileName, result)
                print("Dump saved to: " .. fileName)
                
                Luna:Notification({
                    Title = "Dump Complete",
                    Content = "Saved as " .. fileName,
                    Icon = "check",
                    ImageSource = "Lucide"
                })
            else
                warn("Dump Error: " .. tostring(result))
                Luna:Notification({
                    Title = "Dump Failed",
                    Content = "Error occurred. Check console.",
                    Icon = "x",
                    ImageSource = "Lucide"
                })
            end
        end)
    end
    end
})

Tab:CreateButton({
    Name = "Dump NPCs & Quests (Clipboard)",
    Description = "Fast scan of NPCs and Quest Givers",
    Callback = function()
        Luna:Notification({
            Title = "Scanning...",
            Content = "Please wait...",
            Icon = "search",
            ImageSource = "Lucide"
        })
        
        task.defer(function()
            local output = {}
            local myPos = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Players.LocalPlayer.Character.HumanoidRootPart.Position or Vector3.new(0,0,0)
            
            local function collect(model, source)
                if model:IsA("Model") then
                    local hasHumanoid = model:FindFirstChild("Humanoid")
                    local name = model.Name:lower()
                    local isQuest = name:find("quest") or name:find("villager") or name:find("giver") or name:find("adventurer") or name:find("teacher")
                    
                    if hasHumanoid or isQuest then
                        local pos = nil
                        if model:FindFirstChild("HumanoidRootPart") then
                            pos = model.HumanoidRootPart.Position
                        elseif model.PrimaryPart then
                            pos = model.PrimaryPart.Position
                        elseif model:GetPivot() then
                            pos = model:GetPivot().Position
                        end
                        
                        if pos then
                            local dist = (pos - myPos).Magnitude
                            table.insert(output, {
                                Name = model.Name,
                                Pos = pos,
                                Dist = dist,
                                Source = source
                            })
                        end
                    end
                end
            end
            
            -- Scan
            local locations = {workspace:FindFirstChild("NPCs"), workspace:FindFirstChild("Enemies"), workspace}
            for _, loc in ipairs(locations) do
                if loc then
                    for _, v in ipairs(loc:GetChildren()) do
                        collect(v, loc.Name)
                    end
                end
            end
            
            -- Sort
            table.sort(output, function(a, b) return a.Dist < b.Dist end)
            
            -- Format
            local lines = {}
            table.insert(lines, "--- NPC & QUEST DUMP ---")
            for _, data in ipairs(output) do
                local line = string.format("Name: %-20s | Pos: %.0f, %.0f, %.0f | Dist: %.0f", data.Name, data.Pos.X, data.Pos.Y, data.Pos.Z, data.Dist)
                table.insert(lines, line)
            end
            
            local result = table.concat(lines, "\n")
            
            if setclipboard then
                setclipboard(result)
                Luna:Notification({
                    Title = "Copied!",
                    Content = "Dump copied to clipboard.",
                    Icon = "copy",
                    ImageSource = "Lucide"
                })
            else
                print(result)
                Luna:Notification({
                    Title = "Printed",
                    Content = "Check console (F9).",
                    Icon = "terminal",
                    ImageSource = "Lucide"
                })
            end
        end)
    end
})
