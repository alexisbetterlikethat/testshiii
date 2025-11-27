--[[
    ONE CLICK GAME DUMPER
    Powered by Aero Hub
    
    Exports a comprehensive analysis of the game to clipboard.
    - Hierarchy & Properties
    - Script Source (Decompiled)
    - Remotes
    - Nil Instances
]]

local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Window = Luna:CreateWindow({
    Name = "One Click Dumper",
    Subtitle = "Ultimate Analysis Tool",
    LogoID = "6031097225",
    LoadingEnabled = false,
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "OneClickDumper"
    }
})

local Tab = Window:CreateTab({
    Name = "One Click",
    Icon = "list",
    ImageSource = "Material"
})

-- Safe Property Getter
local function getProp(obj, prop)
    local success, result = pcall(function() return obj[prop] end)
    if success then return result end
    return nil
end

-- Decompiler Wrapper
local function safeDecompile(scriptObj)
    if not decompile then return "-- Decompiler not supported" end
    local success, source = pcall(decompile, scriptObj)
    if success then return source end
    return "-- Decompilation failed"
end

-- Aggressive Debug Wrappers
local getgc = getgc or function() return {} end
local getconstants = debug.getconstants or function() return {} end
local getupvalues = debug.getupvalues or function() return {} end
local getprotos = debug.getprotos or function() return {} end
local getinfo = debug.getinfo or function() return {} end

local function dumpScriptDeep(funcOrScript)
    local output = {}
    local function log(s) table.insert(output, s) end
    
    pcall(function()
        -- Constants
        local consts = getconstants(funcOrScript)
        if #consts > 0 then
            log("    [CONSTANTS]")
            for i, v in ipairs(consts) do
                if type(v) == "string" or type(v) == "number" or type(v) == "boolean" then
                    log("      " .. i .. ": " .. tostring(v))
                end
            end
        end
        
        -- Upvalues
        local upvals = getupvalues(funcOrScript)
        if #upvals > 0 then
            log("    [UPVALUES]")
            for i, v in ipairs(upvals) do
                log("      " .. i .. ": " .. tostring(v))
            end
        end
    end)
    
    return table.concat(output, "\n")
end

-- Dump Generator
local function generateFullDump()
    local output = {}
    local function log(str) table.insert(output, str) end
    
    log("=== ONE CLICK GAME DUMP ===")
    log("Date: " .. os.date("%Y-%m-%d %H:%M:%S"))
    log("Game ID: " .. tostring(game.PlaceId))
    log("Job ID: " .. tostring(game.JobId))
    log("Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown"))
    log("\n")

    -- 1. NIL INSTANCES
    log("=== NIL INSTANCES (Hidden Objects) ===")
    if getnilinstances then
        for _, obj in ipairs(getnilinstances()) do
            pcall(function()
                log("NIL: " .. obj.ClassName .. " | Name: " .. tostring(obj.Name))
            end)
        end
    else
        log("getnilinstances not supported")
    end
    log("\n")

    -- 1.5 GC SCAN (AGGRESSIVE)
    log("=== GC SCAN (Aggressive) ===")
    log("Scanning garbage collector for interesting tables/functions...")
    local gcCount = 0
    for _, v in ipairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Detected") then
            log("GC FOUND: Table with 'Detected' key")
            gcCount = gcCount + 1
        elseif type(v) == "function" then
            local info = getinfo(v)
            if info.name and (info.name:lower():match("kick") or info.name:lower():match("ban")) then
                 log("GC FOUND: Function '" .. info.name .. "'")
                 gcCount = gcCount + 1
            end
        end
    end
    log("GC Scan complete. Found " .. gcCount .. " interesting items.")
    log("\n")

    -- 2. HIERARCHY & SCRIPTS
    log("=== HIERARCHY & SCRIPTS ===")
    
    local function dumpHierarchy(parent, depth)
        if depth > 10 then return end -- Prevent infinite recursion
        local indent = string.rep("  ", depth)
        
        local children = parent:GetChildren()
        -- Sort for consistency
        table.sort(children, function(a, b) return a.Name < b.Name end)
        
        for _, child in ipairs(children) do
            local className = child.ClassName
            local name = child.Name
            local extra = ""
            
            -- Capture specific interesting properties
            if child:IsA("ValueBase") then
                local val = getProp(child, "Value")
                if val ~= nil then extra = " [Value: " .. tostring(val) .. "]" end
            elseif child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                extra = " [REMOTE]"
            elseif child:IsA("ModuleScript") or child:IsA("LocalScript") then
                extra = " [SCRIPT]"
            end
            
            log(indent .. "- " .. name .. " (" .. className .. ")" .. extra)
            
            -- Dump Script Source & Deep Data
            if child:IsA("LocalScript") or child:IsA("ModuleScript") then
                log(indent .. "  --- DEEP SCAN START ---")
                
                -- Aggressive: Dump Constants & Upvalues
                local deepData = dumpScriptDeep(child)
                if deepData ~= "" then
                    log(deepData)
                end

                log(indent .. "  --- SOURCE START ---")
                local src = safeDecompile(child)
                -- Indent source for readability
                src = src:gsub("\n", "\n" .. indent .. "  ")
                log(indent .. "  " .. src)
                log(indent .. "  --- SOURCE END ---")
                log(indent .. "  --- DEEP SCAN END ---")
            end
            
            dumpHierarchy(child, depth + 1)
        end
    end

    -- Dump key services
    local servicesToDump = {
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPlayer"),
        game:GetService("StarterPack"),
        game:GetService("StarterGui"),
        game:GetService("Lighting"),
        game:GetService("ReplicatedFirst"),
        game:GetService("Teams"),
        game:GetService("SoundService")
        -- game:GetService("Workspace") -- Removed to prevent freezing/crashing
    }

    for _, service in ipairs(servicesToDump) do
        log("\n[" .. service.Name .. "]")
        dumpHierarchy(service, 1)
    end
    
    -- Dump LocalPlayer specifically
    if Players.LocalPlayer then
        log("\n[LocalPlayer]")
        dumpHierarchy(Players.LocalPlayer, 1)
    end

    return table.concat(output, "\n")
end

Tab:CreateSection("Export")

Tab:CreateButton({
    Name = "One Click Dump",
    Description = "Exports the game dump to file",
    Callback = function()
        print("One Click Dump button pressed")
        Luna:Notification({
            Title = "Dumping...",
            Content = "Analyzing game. Check workspace folder for file."
        })
        
        task.defer(function()
            print("Starting generation...")
            local success, result = pcall(generateFullDump)
            print("Generation finished. Success: " .. tostring(success))
            
            if success then
                print("Dump size: " .. #result)
                local fileName = "GameDump_" .. game.PlaceId .. "_" .. os.time() .. ".txt"
                writefile(fileName, result)
                
                Luna:Notification({
                    Title = "Success",
                    Content = "Saved to " .. fileName
                })
            else
                warn("Dump failed: " .. tostring(result))
                Luna:Notification({
                    Title = "Failed",
                    Content = "Dump failed. Check console (F9)."
                })
            end
        end)
    end
})
