--[[ 
    EXECUTOR COMPATIBILITY TEST SCRIPT

    This script checks for the presence and function of critical
    APIs required by the "Aero Hub" desync script:
    1. Core Roblox Services (must be present).
    2. Exploit-Specific HTTP Functions (must be present for webhook logging).
    3. Essential Functions (must be callable).
    
    The results are printed directly to the console.
]]
local TestResults = {}

-- =========================================================
-- 1. CORE ROBLOX SERVICES CHECK (Standard)
-- =========================================================
local ServicesToTest = {
    "Players", 
    "RunService", 
    "TweenService", 
    "UserInputService", 
    "Workspace", 
    "HttpService"
}

for _, serviceName in ipairs(ServicesToTest) do
    local success, service = pcall(game.GetService, game, serviceName)
    if success and service then
        table.insert(TestResults, string.format("[SERVICE] %s: PASSED (Found)", serviceName))
    else
        table.insert(TestResults, string.format("[SERVICE] %s: FAILED (Not found or error)", serviceName))
    end
end

-- =========================================================
-- 2. EXPLOIT-SPECIFIC HTTP FUNCTION CHECK (Non-Standard)
-- =========================================================
-- These are necessary for the Webhook Logging feature to work.
local FoundHttp = false

if typeof(syn) == "table" and typeof(syn.request) == "function" then
    table.insert(TestResults, "[EXPLOIT API] HTTP Request (syn.request): PASSED")
    FoundHttp = true
elseif typeof(http) == "table" and typeof(http.request) == "function" then
    table.insert(TestResults, "[EXPLOIT API] HTTP Request (http.request): PASSED")
    FoundHttp = true
elseif typeof(fluxus) == "table" and typeof(fluxus.request) == "function" then
    table.insert(TestResults, "[EXPLOIT API] HTTP Request (fluxus.request): PASSED")
    FoundHttp = true
elseif typeof(http_request) == "function" then
    table.insert(TestResults, "[EXPLOIT API] HTTP Request (http_request): PASSED")
    FoundHttp = true
else
    table.insert(TestResults, "[EXPLOIT API] HTTP Request: FAILED (No known 'request' function found)")
end

-- =========================================================
-- 3. ESSENTIAL LUA FUNCTIONS CHECK (Runtime Environment)
-- =========================================================
-- Checks if critical functions used in the desync loop and GUI exist.
local FunctionsToTest = {
    "task.spawn", 
    "task.wait", 
    "pcall", 
    "Instance.new", 
    "string.format"
}

for _, funcName in ipairs(FunctionsToTest) do
    local path = string.split(funcName, ".")
    local success = true
    local currentTable = _G
    
    for i, part in ipairs(path) do
        if i == #path then
            if typeof(currentTable[part]) ~= "function" then
                success = false
            end
        else
            if typeof(currentTable[part]) ~= "table" then
                success = false
                break
            end
            currentTable = currentTable[part]
        end
    end

    if success then
        table.insert(TestResults, string.format("[LUA FUNC] %s: PASSED (Exists)", funcName))
    else
        table.insert(TestResults, string.format("[LUA FUNC] %s: FAILED (Missing or invalid type)", funcName))
    end
end

-- =========================================================
-- 4. FINAL REPORT
-- =========================================================
print("\n" .. string.rep("=", 50))
print("  COMPATIBILITY REPORT")
print(string.rep("=", 50))

local allPassed = true
for _, result in ipairs(TestResults) do
    print(result)
    if string.match(result, "FAILED") then
        allPassed = false
    end
end

print(string.rep("-", 50))
if allPassed then
    print("✅ COMPATIBILITY RATING: ALL CRITICAL TESTS PASSED!")
    print("The environment supports all required Roblox services and exploit APIs.")
else
    print("❌ COMPATIBILITY RATING: ONE OR MORE CRITICAL TESTS FAILED.")
    print("The script may not function fully, especially the webhook logging.")
end
print(string.rep("=", 50) .. "\n")
