--[[
    GAME DUMPER PRO
    Upgraded by Antigravity
    
    Features:
    - Advanced Hierarchy Dump (Attributes, Tags, Values)
    - Script Keyword Scanner
    - Remote Spy (Simple)
    - Modern UI (Luna Interface Suite)
    - AI Analysis Dump (OneClick)
]]

local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local StarterPlayer = game:GetService("StarterPlayer")
local StarterGui = game:GetService("StarterGui")
local StarterPack = game:GetService("StarterPack")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local SoundService = game:GetService("SoundService")

local Window = Luna:CreateWindow({
    Name = "Dumper Pro",
    Subtitle = "Analysis Tool",
    LogoID = "6031097225",
    LoadingEnabled = false,
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "DumperPro"
    }
})

-- State
local state = {
    dumpDepth = 3,
    dumpProperties = true,
    dumpAttributes = true,
    spyEnabled = false,
    ignoredRemotes = {}
}

-- Utility Functions
local function getHierarchy(parent, depth, maxDepth)
    if depth > maxDepth then return "" end
    
    local indent = string.rep("  ", depth)
    local output = ""
    
    local children = parent:GetChildren()
    table.sort(children, function(a, b) return a.Name < b.Name end)

    for _, child in ipairs(children) do
        local extraInfo = ""
        
        -- Identify Type
        if child:IsA("RemoteEvent") then extraInfo = " [REMOTE EVENT]"
        elseif child:IsA("RemoteFunction") then extraInfo = " [REMOTE FUNC]"
        elseif child:IsA("LocalScript") then extraInfo = " [LOCAL SCRIPT]"
        elseif child:IsA("ModuleScript") then extraInfo = " [MODULE]"
        elseif child:IsA("Script") then extraInfo = " [SERVER SCRIPT]"
        end

        -- Get Values
        if child:IsA("ValueBase") then
            pcall(function()
                extraInfo = extraInfo .. " (Value: " .. tostring(child.Value) .. ")"
            end)
        end
        
        -- Get Text
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
             if child.Text ~= "" then
                extraInfo = extraInfo .. " (Text: \"" .. child.Text:sub(1, 50):gsub("\n", " ") .. "\")"
             end
        end

        -- Get Attributes
        if state.dumpAttributes then
            local attrs = child:GetAttributes()
            for k, v in pairs(attrs) do
                extraInfo = extraInfo .. "\n" .. indent .. "  @ " .. k .. ": " .. tostring(v)
            end
        end

        output = output .. indent .. "- " .. child.Name .. " [" .. child.ClassName .. "]" .. extraInfo .. "\n"

        if depth < maxDepth then
            output = output .. getHierarchy(child, depth + 1, maxDepth)
        end
    end
    return output
end

local function scanForKeywords(parent, keywords)
    local results = ""
    for _, desc in pairs(parent:GetDescendants()) do
        if desc:IsA("LocalScript") or desc:IsA("ModuleScript") then
            for _, kw in pairs(keywords) do
                if string.find(string.lower(desc.Name), string.lower(kw)) then
                    results = results .. "FOUND: " .. desc:GetFullName() .. " [" .. desc.ClassName .. "]\n"
                    break
                end
            end
        end
    end
    return results
end

local function generateAIDump()
    local dump = "=== ROBLOX GAME DUMP FOR AI ANALYSIS ===\n"
    dump = dump .. "Generated: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    dump = dump .. "Place ID: " .. game.PlaceId .. "\n"
    dump = dump .. "Job ID: " .. game.JobId .. "\n\n"

    local services = {
        {Name = "ReplicatedStorage", Service = ReplicatedStorage, Depth = 5},
        {Name = "ReplicatedFirst", Service = ReplicatedFirst, Depth = 3},
        {Name = "StarterGui", Service = StarterGui, Depth = 4},
        {Name = "StarterPack", Service = StarterPack, Depth = 3},
        {Name = "StarterPlayer", Service = StarterPlayer, Depth = 4},
        {Name = "Lighting", Service = Lighting, Depth = 2},
        {Name = "Teams", Service = Teams, Depth = 2},
        {Name = "SoundService", Service = SoundService, Depth = 2},
        {Name = "Workspace", Service = workspace, Depth = 2} -- Keep workspace shallow to avoid massive lag
    }

    for _, s in ipairs(services) do
        dump = dump .. "\n[" .. s.Name .. "]\n"
        dump = dump .. getHierarchy(s.Service, 0, s.Depth)
    end

    if Players.LocalPlayer then
        dump = dump .. "\n[LocalPlayer]\n"
        dump = dump .. "Name: " .. Players.LocalPlayer.Name .. "\n"
        dump = dump .. "Team: " .. tostring(Players.LocalPlayer.Team) .. "\n"
        
        dump = dump .. "\n-- PlayerGui --\n"
        dump = dump .. getHierarchy(Players.LocalPlayer:WaitForChild("PlayerGui"), 0, 4)
        
        if Players.LocalPlayer.Character then
            dump = dump .. "\n-- Character --\n"
            dump = dump .. getHierarchy(Players.LocalPlayer.Character, 0, 3)
        end
    end

    return dump
end

-- ================= TABS =================

-- [1] DUMPER TAB
local DumperTab = Window:CreateTab({
    Name = "Dumper",
    Icon = "list",
    ImageSource = "Material"
})

DumperTab:CreateSection("Settings")

DumperTab:CreateSlider({
    Name = "Max Depth",
    Min = 1,
    Max = 10,
    Default = 3,
    Callback = function(val)
        state.dumpDepth = val
    end
})

DumperTab:CreateToggle({
    Name = "Dump Attributes",
    Default = true,
    Callback = function(val)
        state.dumpAttributes = val
    end
})

DumperTab:CreateSection("Actions")

DumperTab:CreateButton({
    Name = "OneClick AI Dump",
    Callback = function()
        Luna:Notification({
            Title = "Working...",
            Content = "Generating massive game dump. Please wait.",
            Icon = "hourglass"
        })
        
        -- Use task.defer to allow UI to update before freezing for dump
        task.defer(function()
            local dump = generateAIDump()
            setclipboard(dump)
            Luna:Notification({
                Title = "Success",
                Content = "Full AI Analysis Dump copied to clipboard!",
                Icon = "check"
            })
        end)
    end
})

DumperTab:CreateButton({
    Name = "Dump ReplicatedStorage",
    Callback = function()
        local dump = "=== ReplicatedStorage Dump ===\n" .. getHierarchy(ReplicatedStorage, 0, state.dumpDepth)
        setclipboard(dump)
        Luna:Notification({
            Title = "Success",
            Content = "ReplicatedStorage dump copied to clipboard!",
            Icon = "check"
        })
    end
})

DumperTab:CreateButton({
    Name = "Dump Workspace",
    Callback = function()
        local dump = "=== Workspace Dump ===\n" .. getHierarchy(workspace, 0, state.dumpDepth)
        setclipboard(dump)
        Luna:Notification({
            Title = "Success",
            Content = "Workspace dump copied to clipboard!",
            Icon = "check"
        })
    end
})

DumperTab:CreateButton({
    Name = "Dump PlayerGui",
    Callback = function()
        local p = Players.LocalPlayer
        if p then
            local dump = "=== PlayerGui Dump ===\n" .. getHierarchy(p:WaitForChild("PlayerGui"), 0, state.dumpDepth)
            setclipboard(dump)
            Luna:Notification({
                Title = "Success",
                Content = "PlayerGui dump copied to clipboard!",
                Icon = "check"
            })
        end
    end
})

-- [2] SCANNER TAB
local ScannerTab = Window:CreateTab({
    Name = "Scanner",
    Icon = "search",
    ImageSource = "Material"
})

local searchKeywords = {"Anti", "Cheat", "Bypass", "Walk", "Speed", "Ray", "Cast", "Move", "Velocity", "Fall", "Check", "Admin", "Ban", "Kick"}

ScannerTab:CreateSection("Keyword Scanner")

ScannerTab:CreateInput({
    Name = "Custom Keywords (Comma Separated)",
    PlaceholderText = "Anti, Cheat, ...",
    Callback = function(text)
        searchKeywords = {}
        for word in string.gmatch(text, "([^,]+)") do
            table.insert(searchKeywords, word:match("^%s*(.-)%s*$")) -- trim whitespace
        end
    end
})

ScannerTab:CreateButton({
    Name = "Scan All Scripts",
    Callback = function()
        local results = "=== SCRIPT SCAN RESULTS ===\nKeywords: " .. table.concat(searchKeywords, ", ") .. "\n\n"
        
        results = results .. "-- ReplicatedStorage --\n"
        results = results .. scanForKeywords(ReplicatedStorage, searchKeywords)
        
        results = results .. "\n-- StarterPlayer --\n"
        results = results .. scanForKeywords(StarterPlayer, searchKeywords)
        
        if Players.LocalPlayer then
            results = results .. "\n-- PlayerGui --\n"
            results = results .. scanForKeywords(Players.LocalPlayer:WaitForChild("PlayerGui"), searchKeywords)
            
            if Players.LocalPlayer.Character then
                results = results .. "\n-- Character --\n"
                results = results .. scanForKeywords(Players.LocalPlayer.Character, searchKeywords)
            end
        end
        
        setclipboard(results)
        Luna:Notification({
            Title = "Scan Complete",
            Content = "Results copied to clipboard!",
            Icon = "check"
        })
    end
})

-- [3] REMOTE SPY TAB
local SpyTab = Window:CreateTab({
    Name = "Remote Spy",
    Icon = "wifi",
    ImageSource = "Material"
})

SpyTab:CreateSection("Simple Remote Spy")

local spyLog = {}
local spyConnection = nil

SpyTab:CreateToggle({
    Name = "Enable Spy",
    Default = false,
    Callback = function(enabled)
        state.spyEnabled = enabled
        if enabled then
            -- Hooking logic (Basic implementation)
            -- Note: Real remote spy requires complex metatable hooking which might be detected.
            -- We will use a safer approach: monitoring OnClientEvent for incoming, 
            -- but for outgoing we'd need hookmetamethod.
            
            -- For this 'Safe' version, we'll just warn the user it's a basic logger
            Luna:Notification({
                Title = "Spy Activated",
                Content = "Monitoring outgoing remotes (if supported by executor)",
                Icon = "info"
            })
            
            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall
            if setreadonly then setreadonly(mt, false) end
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                if state.spyEnabled and (method == "FireServer" or method == "InvokeServer") then
                    local logEntry = "[REMOTE] " .. self.Name .. " (" .. method .. ")\nArgs: " .. HttpService:JSONEncode(args)
                    table.insert(spyLog, 1, logEntry) -- Add to top
                    if #spyLog > 50 then table.remove(spyLog) end -- Keep last 50
                end
                
                return oldNamecall(self, ...)
            end)
            
            if setreadonly then setreadonly(mt, true) end
        else
            -- Disable logic (Just flag to stop logging)
        end
    end
})

SpyTab:CreateButton({
    Name = "Copy Spy Log",
    Callback = function()
        setclipboard(table.concat(spyLog, "\n\n"))
        Luna:Notification({
            Title = "Copied",
            Content = "Remote log copied to clipboard",
            Icon = "check"
        })
    end
})

SpyTab:CreateButton({
    Name = "Clear Log",
    Callback = function()
        spyLog = {}
        Luna:Notification({
            Title = "Cleared",
            Content = "Remote log cleared",
            Icon = "trash"
        })
    end
})

-- [4] INFO TAB
local InfoTab = Window:CreateHomeTab({
    SupportedExecutors = {"Synapse X", "Krnl", "Script-Ware", "Sentinel"},
    DiscordInvite = "aero-hub",
    Icon = 2
})
