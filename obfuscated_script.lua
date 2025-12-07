local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Window = Luna:CreateWindow({
    Name = "Aero Hub",
    Subtitle = "Blox Fruits (BETA)",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "Aero Hub",
    LoadingSubtitle = "made with love...",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroHub-BloxFruits-BETA"
    },
    KeySystem = false,
    Theme = {
        Accent = Color3.fromRGB(0, 170, 255), -- Aero Blue
        Background = Color3.fromRGB(15, 15, 15),
        Foreground = Color3.fromRGB(25, 25, 25),
        Text = Color3.fromRGB(255, 255, 255),
    }
})

Window:CreateHomeTab({
    SupportedExecutors = {"Synapse Z", "Solara", "Fluxus", "Delta"},
    DiscordInvite = "https://discord.gg/4JuSYHStaF",
    Icon = 1
})

-- Global Settings
_G.FarmPosition = nil
_G.Settings = {
    Main = {
        ["Auto Kaitun"] = false,
        ["Auto Farm Level"] = false,
        ["Fast Auto Farm Level"] = false,
        ["Distance Mob Aura"] = 1000,
        ["Mob Aura"] = false,
        ["Auto Farm Chest"] = false,
        ["Chest Hop When Dry"] = false,
        ["Chest Hop Delay"] = 10,
        ["Chest Bypass"] = false,
        ["Stop Chest On Rare"] = false,
        ["Auto Collect Berry"] = false,
        ["Auto Collect Berry Hop"] = false,
        ["Auto Farm Bone"] = false,
        ["Auto Elite Hunter"] = false,
        ["Auto Farm Mastery"] = false,
        ["Mastery Health Threshold"] = 25,
        ["Mastery Weapon"] = "Blox Fruit",
    },
    Fruit = {
        ["Auto Store Fruits"] = false,
        ["Auto Buy From Sniper"] = false,
        ["Selected Sniper Fruit"] = "Flame-Flame",
        ["Auto Eat Fruit"] = false,
        ["Selected Eat Fruit"] = "Flame-Flame",
        ["Bring To Fruit"] = false,
        ["Tween To Fruit"] = false,
    },
    Raid = {
        ["Auto Start Raid"] = false,
        ["Auto Buy Chip"] = false,
        ["Select Chip"] = "Flame",
        ["Auto Next Island"] = false,
        ["Kill Aura Raid"] = false,
        ["Auto Awaken"] = false,
    },
    Stats = {
        ["Enabled Auto Stats"] = false,
        ["Select Stats"] = "Melee", -- Melee, Defense, Sword, Gun, Blox Fruit
        ["Point Select"] = 1,
    },
    Configs = {
        ["Fast Attack"] = true,
        ["Select Weapon"] = "Melee",
        ["Auto Haki"] = true,
        ["Bypass TP"] = true,
        ["Server Hop"] = false,
        ["White Screen"] = false,
    },
    Shop = {
        ["Auto Random Fruit"] = false,
        ["Auto Legendary Sword"] = false,
        ["Auto Enhancement Color"] = false,
    },
    Sea = {
        ["Auto Sea Beast"] = false,
        ["Auto Terror Shark"] = false,
        ["Auto Sea Mobs"] = false,
        ["Auto Pirate Raid"] = false,
        ["Selected Boat"] = "PirateBrigade",
    },
    ESP = {
        ["Player ESP"] = false,
        ["Chest ESP"] = false,
        ["Fruit ESP"] = false,
        ["Flower ESP"] = false,
        ["Raid ESP"] = false,
    },
    Materials = {
        ["Auto Farm Material"] = false,
        ["Select Material"] = "Leather + Scrap Metal",
    },
    Teams = {
        ["Auto Select Team"] = true,
        ["Preferred Team"] = "Pirates",
    },
    Bones = {
        ["Auto Random Bone"] = false,
    },
    Teleport = {
        ["Select Island"] = "",
    },
    AntiCheat = {
        ["Bypass"] = false,
        ["Auto Hop Timer"] = 30, -- Minutes
    },
    Webhook = {
        ["Enabled"] = false,
        ["Url"] = "",
        ["Level Up"] = true,
        ["Rare Item"] = true,
    }
}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local World1 = PlaceId == 2753915549
local World2 = PlaceId == 4442272183
local World3 = PlaceId == 7449423635
local CurrentWorld = (World1 and 1) or (World2 and 2) or (World3 and 3) or 1

-- Initialize EnemySpawns (Redz Logic - Continuous Update)
task.spawn(function()
    while task.wait(5) do
        if not workspace:FindFirstChild("EnemySpawns") then
            Instance.new("Folder", workspace).Name = "EnemySpawns"
        end
        local enemySpawnsFolder = workspace.EnemySpawns

        local function registerSpawn(obj)
            if not obj then return end
            local name = obj.Name
            -- Redz cleaning logic: Remove "Lv. ", brackets, digits, and spaces
            local cleanName = name:gsub("Lv%.", ""):gsub("[%[%]]", ""):gsub("%d+", ""):gsub("%s+", "")
            
            if not enemySpawnsFolder:FindFirstChild(cleanName) then
                local clone = nil
                if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                    clone = obj.HumanoidRootPart:Clone()
                elseif obj:IsA("BasePart") then
                    clone = obj:Clone()
                end
                
                if clone then
                    clone.Name = cleanName
                    clone.Parent = enemySpawnsFolder
                    clone.Anchored = true
                    clone.Transparency = 1
                end
            end
        end

        -- From WorldOrigin
        if workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("EnemySpawns") then
            for _, spawnPoint in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                registerSpawn(spawnPoint)
            end
        end

        -- From Workspace Enemies
        if workspace:FindFirstChild("Enemies") then
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                registerSpawn(enemy)
            end
        end

        -- From ReplicatedStorage (Models)
        for _, item in pairs(ReplicatedStorage:GetChildren()) do
            registerSpawn(item)
        end
    end
end)

local function CheckSea(reqWorld)
    if reqWorld == 1 and World1 then return true end
    if reqWorld == 2 and World2 then return true end
    if reqWorld == 3 and World3 then return true end
    return false
end

local fireclickdetectorFn = rawget(_G, "fireclickdetector")
local firetouchinterestFn = rawget(_G, "firetouchinterest")
local activeTween

local TabIcons = {
    Default = "6031097225",
    Update = "6034308946",
    Dashboard = "6022668883",
    Main = "6031068423",
    Stats = "6023565892",
    Shop = "6031265970",
    Materials = "6035056487",
    Bones = "6023565892",
    Raid = "6034848746",
    Travel = "6034684930",
    Sea = "6023426906",
    ESP = "6031260793",
    Settings = "6031280882",
    Fruit = "6034744034"
}

local function GetIcon(name)
    local id = TabIcons[name] or TabIcons.Default
    if not id then return "rbxassetid://6031097225" end -- Fallback safety
    return "rbxassetid://" .. id
end

local lastHopAttempt = 0
local function TeleportToServer(preferLowPop)
    if os.clock() - lastHopAttempt < 8 then return end
    lastHopAttempt = os.clock()
    task.spawn(function()
        local placeId = game.PlaceId
        local cursor
        for _ = 1, 5 do
            local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", placeId)
            if cursor then
                url = url .. "&cursor=" .. cursor
            end
            local success, response = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if not success or type(response) ~= "table" or type(response.data) ~= "table" then
                break
            end
            local servers = response.data
            if preferLowPop then
                table.sort(servers, function(a, b)
                    return (a.playing or math.huge) < (b.playing or math.huge)
                end)
            end
            for _, server in ipairs(servers) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                    return
                end
            end
            cursor = response.nextPageCursor
            if not cursor then
                break
            end
        end
    end)
end

local function AutoChooseTeam()
    if not _G.Settings.Teams["Auto Select Team"] then return end
    task.spawn(function()
        while not LocalPlayer.Team do
            local preferred = _G.Settings.Teams["Preferred Team"]
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", preferred)
            end)
            local gui = LocalPlayer:FindFirstChild("PlayerGui")
            if gui then
                local chooseTeam = gui:FindFirstChild("ChooseTeam", true)
                if chooseTeam and chooseTeam.Visible then
                    for _, button in ipairs(chooseTeam:GetDescendants()) do
                        if button:IsA("TextButton") and string.find(button.Name, preferred) then
                            pcall(function()
                                button:Activate()
                            end)
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end

AutoChooseTeam()

-- Anti-Cheat Bypass
local function BypassAntiCheat()
    local function DisableRemote(remoteName)
        local remote = ReplicatedStorage:FindFirstChild(remoteName)
        if remote then
            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                remote.Name = "DisabledRemote_" .. remoteName
            end
        end
    end
    DisableRemote("Adonis_Client") 
    DisableRemote("Adonis_UI")
    
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end)
end
task.spawn(BypassAntiCheat)

-- Webhook & Auto Hop Logic
local function SendWebhook(title, description, color, fields)
    if not _G.Settings.Webhook["Enabled"] or _G.Settings.Webhook["Url"] == "" then return end
    
    local embed = {
        ["title"] = title,
        ["description"] = description,
        ["color"] = color or 65280,
        ["footer"] = {
            ["text"] = "Aero Hub - " .. os.date("%X")
        }
    }

    if fields and type(fields) == "table" then
        embed["fields"] = fields
    end
    
    local data = {
        ["embeds"] = {embed}
    }
    
    local jsonData = HttpService:JSONEncode(data)
    request({
        Url = _G.Settings.Webhook["Url"],
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end

local lastHopCheck = os.clock()
task.spawn(function()
    while task.wait(60) do
        if _G.Settings.AntiCheat["Auto Hop"] then
            local elapsedMinutes = (os.clock() - lastHopCheck) / 60
            if elapsedMinutes >= (_G.Settings.AntiCheat["Hop Timer"] or 30) then
                SendWebhook("Anti-Cheat Bypass", "Auto hopping to a new server...", 16776960)
                TeleportToServer(true)
                lastHopCheck = os.clock()
            end
        else
            lastHopCheck = os.clock()
        end
    end
end)

-- Helper Functions
local function EquipWeapon(toolName)
    local Backpack = LocalPlayer.Backpack
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild(toolName) then return end
    if Backpack and Backpack:FindFirstChild(toolName) then
        Character.Humanoid:EquipTool(Backpack[toolName])
    end
end

local function GetWeaponByType(type)
    local Backpack = LocalPlayer.Backpack
    local Character = LocalPlayer.Character
    if Backpack then
        for _, tool in pairs(Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.ToolTip == type then return tool.Name end
        end
    end
    if Character then
        for _, tool in pairs(Character:GetChildren()) do
            if tool:IsA("Tool") and tool.ToolTip == type then return tool.Name end
        end
    end
    return nil
end

local function EquipWeaponByType(weaponType)
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChildOfClass("Humanoid") then return false end
    local weaponName = GetWeaponByType(weaponType) or weaponType
    if weaponName then
        if Character:FindFirstChild(weaponName) then return true end
        EquipWeapon(weaponName)
        if Character:FindFirstChild(weaponName) then return true end
    end
    
    -- Fallback: Check if ANY tool is already equipped
    if Character:FindFirstChildOfClass("Tool") then
        return true
    end

    local Backpack = LocalPlayer.Backpack
    if Backpack then
        local fallback = Backpack:FindFirstChildOfClass("Tool")
        if fallback then
            Character.Humanoid:EquipTool(fallback)
            return true
        end
    end
    return false
end

local function EquipPreferredWeapon()
    return EquipWeaponByType(_G.Settings.Configs["Select Weapon"])
end

local function EquipMasteryWeapon()
    return EquipWeaponByType(_G.Settings.Main["Mastery Weapon"])
end

local function EnsureHaki()
    if not _G.Settings.Configs["Auto Haki"] then return end
    local character = LocalPlayer.Character
    if character and not character:FindFirstChild("HasBuso") then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end)
    end
end

local function ReleaseSit()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Sit then
        humanoid.Sit = false
    end
end

local function AnchorEnemy(enemy)
    local hrp = enemy and enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy and enemy:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end
    hrp.CanCollide = false
    hrp.Size = Vector3.new(60, 60, 60)
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.AutoRotate = false
end

local function GetClosestActiveEnemy(maxDistance)
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root or not workspace:FindFirstChild("Enemies") then return nil end
    local closest, minDistance
    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChildOfClass("Humanoid")
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        if humanoid and humanoid.Health > 0 and hrp then
            local distance = (hrp.Position - root.Position).Magnitude
            if distance <= (maxDistance or math.huge) and (not minDistance or distance < minDistance) then
                closest = enemy
                minDistance = distance
            end
        end
    end
    return closest
end

local function ShouldAutoClick()
    return _G.Settings.Main["Auto Farm Level"]
        or _G.Settings.Main["Auto Farm Mastery"]
        or _G.Settings.Main["Auto Farm Bone"]
        or _G.Settings.Main["Mob Aura"]
        or _G.Settings.Main["Auto Elite Hunter"]
        or _G.Settings.Materials["Auto Farm Material"]
        or _G.Settings.Sea["Auto Sea Beast"]
        or _G.Settings.Sea["Auto Terror Shark"]
        or _G.Settings.Sea["Auto Sea Mobs"]
        or _G.Settings.Sea["Auto Pirate Raid"]
end


local function formatNumber(value)
    if typeof(value) ~= "number" then
        return tostring(value or "?")
    end
    local sign = value < 0 and "-" or ""
    local str = tostring(math.floor(math.abs(value)))
    local formatted = str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    if formatted:sub(1, 1) == "," then
        formatted = formatted:sub(2)
    end
    return sign .. formatted
end

local accessoryCache = {}
local lastAccessoryCheck = 0
local function refreshAccessoryCache()
    if os.clock() - lastAccessoryCheck < 10 then
        return
    end
    local success, inventory = pcall(function()
        return ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")
    end)
    if success and type(inventory) == "table" then
        accessoryCache = {}
        for _, item in ipairs(inventory) do
            if type(item) == "table" and item.Type == "Wear" and item.Name then
                accessoryCache[item.Name] = true
            end
        end
        lastAccessoryCheck = os.clock()
    end
end

local function HasAccessory(name)
    refreshAccessoryCache()
    return accessoryCache[name] == true
end

local function safeSetClipboard(text)
    if typeof(text) ~= "string" then return end
    local primary = rawget(_G, "setclipboard")
    local fallback = rawget(_G, "toclipboard")
    if type(primary) == "function" then
        pcall(primary, text)
    elseif type(fallback) == "function" then
        pcall(fallback, text)
    end
end

local function getWorldName()
    if CurrentWorld == 1 then
        return "First Sea"
    elseif CurrentWorld == 2 then
        return "Second Sea"
    elseif CurrentWorld == 3 then
        return "Third Sea"
    end
    return "Unknown Sea"
end

local DojoBeltSteps = {
    {name = "Dojo Belt (White)", tip = "Kill 20 quest NPCs while auto farming."},
    {name = "Dojo Belt (Yellow)", tip = "Defeat 5 Sea mobs during Sea Events."},
    {name = "Dojo Belt (Orange)", tip = "Complete one fruit trade with the Dealer."},
    {name = "Dojo Belt (Green)", tip = "Wait 5 minutes on Sea Danger levels 4-6."},
    {name = "Dojo Belt (Blue)", tip = "Collect a fruit dropped anywhere in the world."},
    {name = "Dojo Belt (Purple)", tip = "Eliminate 3 Elite Hunters."},
    {name = "Dojo Belt (Red)", tip = "Defeat a Terror Shark or Rumbling Waters boss."},
    {name = "Dojo Belt (Black)", tip = "Complete the Prehistoric event and turn in bones."}
}

local FastAttack
local lastBasicAttack = 0
local function PerformBasicAttack()
    local character = LocalPlayer.Character
    if not character then return end

    -- 1. Fast Attack (Redz Logic - Remote Spam)
    if _G.Settings.Configs and _G.Settings.Configs["Fast Attack"] and FastAttack then
        pcall(function() FastAttack:AttackNearest() end)
    end

    -- 2. Standard Tool Activation (Silent)
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
        -- Aggressive Remote Search
        for _, v in ipairs(tool:GetDescendants()) do
            if v:IsA("RemoteEvent") and (v.Name == "Click" or v.Name == "Attack" or v.Name == "LeftClickRemote") then
                v:FireServer()
            elseif v:IsA("RemoteFunction") and (v.Name == "Click" or v.Name == "Attack" or v.Name == "LeftClickRemote") then
                task.spawn(function() v:InvokeServer() end)
            end
        end
    end
end

local function CheckNearestTeleporter(targetPos)
    local myPos = LocalPlayer.Character.HumanoidRootPart.Position
    local targetPosVec = (typeof(targetPos) == "CFrame" and targetPos.Position) or targetPos
    local minDistance = math.huge
    local nearest = nil

    local Teleporters = {}
    if World1 then
        Teleporters = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif World2 then
        Teleporters = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif World3 then
        Teleporters = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5662, 1013, -335),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58, 22.53, -125.94),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        }
    end

    for _, pos in pairs(Teleporters) do
        local dist = (pos - targetPosVec).Magnitude
        if dist < minDistance then
            minDistance = dist
            nearest = pos
        end
    end

    if nearest and minDistance < (targetPosVec - myPos).Magnitude then
        return nearest
    end
    return nil
end

local function RequestEntrance(pos)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", pos)
end

local function EnableNoclip()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if not char.HumanoidRootPart:FindFirstChild("BodyClip") then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "BodyClip"
            bv.Parent = char.HumanoidRootPart
            bv.MaxForce = Vector3.new(100000, 100000, 100000)
            bv.Velocity = Vector3.zero
        end
        
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end

local function DisableNoclip()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local bv = char.HumanoidRootPart:FindFirstChild("BodyClip")
        if bv then bv:Destroy() end
        
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
        end
    end
end

local lastTweenTarget = nil

local function toTarget(targetPos)
    TP2(targetPos)
end

local function ApproachEnemy(enemy, hoverHeight)
    if not enemy then return end
    local hrp = enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    AnchorEnemy(enemy)
    
    local targetCFrame = hrp.CFrame * CFrame.new(0, hoverHeight or 30, 0)
    TP2(targetCFrame)

    if EquipPreferredWeapon() then
        EnsureHaki()
        ReleaseSit()
        PerformBasicAttack()
    end
end

-- Fast Attack & Helper Functions (Redz Logic)
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Helper: Distance Check
function dist(p1, p2, useY)
    if not p1 or not p2 then return math.huge end
    local pos1 = (typeof(p1) == "Instance" and (p1:IsA("Model") and p1.PrimaryPart.Position or p1.Position)) or (typeof(p1) == "CFrame" and p1.Position) or p1
    local pos2 = (typeof(p2) == "Instance" and (p2:IsA("Model") and p2.PrimaryPart.Position or p2.Position)) or (typeof(p2) == "CFrame" and p2.Position) or p2
    
    if useY then
        return (pos1 - pos2).Magnitude
    else
        return (Vector3.new(pos1.X, 0, pos1.Z) - Vector3.new(pos2.X, 0, pos2.Z)).Magnitude
    end
end

-- Helper: Teleporters
function CheckNearestTeleporter(targetPos)
    local targetVec = (typeof(targetPos) == "CFrame" and targetPos.Position) or targetPos
    local myPos = LocalPlayer.Character.HumanoidRootPart.Position
    local minDist = math.huge
    local bestTeleporter = nil
    local placeId = game.PlaceId
    
    local teleporters = {}
    if placeId == 2753915549 then -- World 1
        teleporters = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif placeId == 4442272183 then -- World 2
        teleporters = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif placeId == 7449423635 then -- World 3
        teleporters = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5662, 1013, -335),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58, 22.54, -125.94),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        }
    end

    for name, pos in pairs(teleporters) do
        local d = (pos - targetVec).Magnitude
        if d < minDist then
            minDist = d
            bestTeleporter = pos
        end
    end

    if minDist < (targetVec - myPos).Magnitude then
        return bestTeleporter
    end
    return nil
end

function requestEntrance(pos)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", pos)
    local hrp = LocalPlayer.Character.HumanoidRootPart
    hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
    task.wait(0.5)
end

-- [[ Standard Tween Implementation (TweenX) - Improved RedzHub Logic ]]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local function WaitHRP(p193)
    if p193 then
        return p193.Character:WaitForChild("HumanoidRootPart", 9)
    end
end

local function CheckNearestTeleporter(p194)
    local v195 = p194.Position
    local v196 = math.huge
    local v197 = nil
    local v198 = game.PlaceId
    local v199 = {}
    local v200
    if v198 == 2753915549 then
        v200 = {
            ["Sky3"] = Vector3.new(- 7894, 5547, - 380),
            ["Sky3Exit"] = Vector3.new(- 4607, 874, - 1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["UnderwaterExit"] = Vector3.new(4050, - 1, - 1814)
        }
    elseif v198 == 4442272183 then
        v200 = {
            ["Swan Mansion"] = Vector3.new(- 390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(- 6509, 83, - 133)
        }
    else
        v200 = v198 == 7449423635 and {
            ["Floating Turtle"] = Vector3.new(- 12462, 375, - 7552),
            ["Hydra Island"] = Vector3.new(5662, 1013, - 335),
            ["Mansion"] = Vector3.new(- 12462, 375, - 7552),
            ["Castle"] = Vector3.new(- 5036, 315, - 3179),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, - 93),
            ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, - 125.942276, 1, 2.14762768e-8, - 1.99111154e-13, - 2.14762768e-8, 1, - 3.0510602e-8, 1.98455903e-13, 3.0510602e-8, 1),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        } or v199
    end
    local v201, v202, v203 = pairs(v200)
    while true do
        local v204
        v203, v204 = v201(v202, v203)
        if v203 == nil then
            break
        end
        local v205 = (v204 - v195).Magnitude
        if v205 < v196 then
            v197 = v204
            v196 = v205
        end
    end
    if v196 <= (v195 - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
        return v197
    end
end

local function StopTween()
    if _G.TweenConnection then 
        _G.TweenConnection:Disconnect() 
        _G.TweenConnection = nil
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("PartTele") then
        LocalPlayer.Character.PartTele:Destroy()
    end
end

function TweenX(target)
    if not LocalPlayer.Character then return end
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local targetCFrame = (typeof(target) == "Vector3" and CFrame.new(target)) or (typeof(target) == "CFrame" and target)
    if not targetCFrame then return end

    -- 1. Teleporter Check
    local teleporter = CheckNearestTeleporter(targetCFrame)
    if teleporter then
        requestEntrance(teleporter)
        return
    end

    -- 2. Distance Check
    local dist = (root.Position - targetCFrame.Position).Magnitude
    
    -- 3. Setup PartTele (Redz Method - Smoothed)
    if not LocalPlayer.Character:FindFirstChild("PartTele") then
        local p = Instance.new("Part", LocalPlayer.Character)
        p.Name = "PartTele"
        p.Size = Vector3.new(1,1,1)
        p.Anchored = true
        p.CanCollide = false
        p.Transparency = 1
        p.CFrame = root.CFrame
    end
    local partTele = LocalPlayer.Character.PartTele
    
    -- 4. Tween the Part
    local speed = 350
    if dist < 200 then speed = 500 end
    
    local info = TweenInfo.new(dist/speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(partTele, info, {CFrame = targetCFrame})
    tween:Play()
    
    -- 5. Bind HRP to Part (Smoother than GetPropertyChangedSignal)
    if _G.TweenConnection then _G.TweenConnection:Disconnect() end
    _G.TweenConnection = RunService.RenderStepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("PartTele") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.PartTele.CFrame
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
            
            -- Noclip
            for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        else
            if _G.TweenConnection then _G.TweenConnection:Disconnect() end
        end
    end)
    
    tween.Completed:Connect(function()
        if _G.TweenConnection then _G.TweenConnection:Disconnect() end
        if partTele then partTele:Destroy() end
    end)
end

-- Alias for compatibility
local TP2 = TweenX

-- Fast Attack (Optimized)
FastAttack = {
    Distance = 150, -- Increased range to ensure hits
    Enabled = false
}

local RegisterAttack
local RegisterHit

task.spawn(function()
    -- Robust Remote Finder
    local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
    if not Net then
        -- Fallback search
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v.Name == "Net" and v:IsA("Folder") then
                Net = v
                break
            end
        end
    end
    
    if Net then
        RegisterAttack = Net:WaitForChild("RE/RegisterAttack", 5)
        RegisterHit = Net:WaitForChild("RE/RegisterHit", 5)
    end
end)

function FastAttack:AttackNearest()
    -- Lazy load remotes
    if not RegisterAttack or not RegisterHit then
        local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
        if Net then
            RegisterAttack = Net:FindFirstChild("RE/RegisterAttack")
            RegisterHit = Net:FindFirstChild("RE/RegisterHit")
        end
    end
    if not RegisterAttack or not RegisterHit then return end
    
    local character = LocalPlayer.Character
    local myRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    -- Anti-Sit
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid and humanoid.Sit then humanoid.Sit = false end

    local enemiesToHit = {}
    local baseEnemy = nil
    local closestDist = math.huge

    -- Enemy Processing
    local function ProcessEnemies(folder)
        if not folder then return end
        for _, enemy in pairs(folder:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local hitPart = enemy:FindFirstChild("Head") or enemy:FindFirstChild("HumanoidRootPart")
                if hitPart then
                    local dist = (hitPart.Position - myRoot.Position).Magnitude
                    if dist < 100 then
                        table.insert(enemiesToHit, {enemy, hitPart})
                        if dist < closestDist then
                            closestDist = dist
                            baseEnemy = hitPart
                        end
                    end
                end
            end
        end
    end

    ProcessEnemies(workspace:FindFirstChild("Enemies"))
    ProcessEnemies(workspace:FindFirstChild("Characters"))

    if #enemiesToHit > 0 and baseEnemy then
        -- 1. Register Attack (Reset Cooldown)
        RegisterAttack:FireServer(0)
        
        -- 2. Register Hit (Multi-Target Damage)
        RegisterHit:FireServer(baseEnemy, enemiesToHit)
        
        -- 3. Tool Activation (Visuals/State)
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
end

-- Fast Attack Loop (Heartbeat for maximum speed and reliability)
RunService.Heartbeat:Connect(function()
    if _G.Settings.Configs["Fast Attack"] and LocalPlayer.Character then
        pcall(function()
            FastAttack:AttackNearest()
        end)
    end
end)

-- Auto Stats
task.spawn(function()
    while task.wait(0.5) do
        if _G.Settings.Stats["Enabled Auto Stats"] then
            local points = _G.Settings.Stats["Point Select"]
            local stat = _G.Settings.Stats["Select Stats"]
            ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", stat, points)
        end
    end
end)

-- Quest Database (Synced with reference scripts)
local QuestDatabase = {
    {Level = 1, Quest = "BanditQuest1", QuestNum = 1, NPCPos = CFrame.new(1059.37, 15.45, 1550.42), Mob = "Bandit", NPCName = "Quest Giver"},
    {Level = 10, Quest = "JungleQuest", QuestNum = 1, NPCPos = CFrame.new(-1598.09, 35.55, 153.38), Mob = "Monkey", NPCName = "Quest Giver"},
    {Level = 15, Quest = "JungleQuest", QuestNum = 2, NPCPos = CFrame.new(-1598.09, 35.55, 153.38), Mob = "Gorilla", NPCName = "Quest Giver"},
    {Level = 30, Quest = "BuggyQuest1", QuestNum = 1, NPCPos = CFrame.new(-1141.07, 4.10, 3831.55), Mob = "Pirate", NPCName = "Quest Giver"},
    {Level = 40, Quest = "BuggyQuest1", QuestNum = 2, NPCPos = CFrame.new(-1141.07, 4.10, 3831.55), Mob = "Brute", NPCName = "Quest Giver"},
    {Level = 60, Quest = "DesertQuest", QuestNum = 1, NPCPos = CFrame.new(894.49, 5.14, 4392.43), Mob = "Desert Bandit", NPCName = "Quest Giver"},
    {Level = 75, Quest = "DesertQuest", QuestNum = 2, NPCPos = CFrame.new(894.49, 5.14, 4392.43), Mob = "Desert Officer", NPCName = "Quest Giver"},
    {Level = 90, Quest = "SnowQuest", QuestNum = 1, NPCPos = CFrame.new(1389.74, 88.15, -1298.91), Mob = "Snow Bandit", NPCName = "Quest Giver"},
    {Level = 100, Quest = "SnowQuest", QuestNum = 2, NPCPos = CFrame.new(1389.74, 88.15, -1298.91), Mob = "Snowman", NPCName = "Quest Giver"},
    {Level = 120, Quest = "MarineQuest2", QuestNum = 1, NPCPos = CFrame.new(-5039.59, 27.35, 4324.68), Mob = "Chief Petty Officer", NPCName = "Quest Giver"},
    {Level = 150, Quest = "SkyQuest", QuestNum = 1, NPCPos = CFrame.new(-4839.53, 716.37, -2619.44), Mob = "Sky Bandit", NPCName = "Quest Giver"},
    {Level = 175, Quest = "SkyQuest", QuestNum = 2, NPCPos = CFrame.new(-4839.53, 716.37, -2619.44), Mob = "Dark Master", NPCName = "Quest Giver"},
    {Level = 190, Quest = "PrisonerQuest", QuestNum = 1, NPCPos = CFrame.new(5308.93, 1.66, 475.12), Mob = "Prisoner", NPCName = "Quest Giver"},
    {Level = 210, Quest = "PrisonerQuest", QuestNum = 2, NPCPos = CFrame.new(5308.93, 1.66, 475.12), Mob = "Dangerous Prisoner", NPCName = "Quest Giver"},
    {Level = 250, Quest = "ColosseumQuest", QuestNum = 1, NPCPos = CFrame.new(-1580.05, 6.35, -2986.48), Mob = "Toga Warrior", NPCName = "Quest Giver"},
    {Level = 275, Quest = "ColosseumQuest", QuestNum = 2, NPCPos = CFrame.new(-1580.05, 6.35, -2986.48), Mob = "Gladiator", NPCName = "Quest Giver"},
    {Level = 300, Quest = "MagmaQuest", QuestNum = 1, NPCPos = CFrame.new(-5313.37, 10.95, 8515.29), Mob = "Military Soldier", NPCName = "Quest Giver"},
    {Level = 325, Quest = "MagmaQuest", QuestNum = 2, NPCPos = CFrame.new(-5313.37, 10.95, 8515.29), Mob = "Military Spy", NPCName = "Quest Giver"},
    {Level = 375, Quest = "FishmanQuest", QuestNum = 1, NPCPos = CFrame.new(61122.65, 18.50, 1569.40), Mob = "Fishman Warrior", NPCName = "Quest Giver"},
    {Level = 400, Quest = "FishmanQuest", QuestNum = 2, NPCPos = CFrame.new(61122.65, 18.50, 1569.40), Mob = "Fishman Commando", NPCName = "Quest Giver"},
    {Level = 450, Quest = "SkyExp1Quest", QuestNum = 1, NPCPos = CFrame.new(-4721.89, 843.87, -1949.97), Mob = "God's Guard", NPCName = "Quest Giver"},
    {Level = 475, Quest = "SkyExp1Quest", QuestNum = 2, NPCPos = CFrame.new(-7859.10, 5544.19, -381.48), Mob = "Shanda", NPCName = "Quest Giver"},
    {Level = 525, Quest = "SkyExp2Quest", QuestNum = 1, NPCPos = CFrame.new(-7906.82, 5634.66, -1411.99), Mob = "Royal Squad", NPCName = "Quest Giver"},
    {Level = 550, Quest = "SkyExp2Quest", QuestNum = 2, NPCPos = CFrame.new(-7906.82, 5634.66, -1411.99), Mob = "Royal Soldier", NPCName = "Quest Giver"},
    {Level = 625, Quest = "FountainQuest", QuestNum = 1, NPCPos = CFrame.new(5259.82, 37.35, 4050.03), Mob = "Galley Pirate", NPCName = "Quest Giver"},
    {Level = 650, Quest = "FountainQuest", QuestNum = 2, NPCPos = CFrame.new(5259.82, 37.35, 4050.03), Mob = "Galley Captain", NPCName = "Quest Giver"},
    {Level = 700, Quest = "Area1Quest", QuestNum = 1, NPCPos = CFrame.new(-429.54, 71.77, 1836.18), Mob = "Raider", NPCName = "Quest Giver"},
    {Level = 725, Quest = "Area1Quest", QuestNum = 2, NPCPos = CFrame.new(-429.54, 71.77, 1836.18), Mob = "Mercenary", NPCName = "Quest Giver"},
    {Level = 775, Quest = "Area2Quest", QuestNum = 1, NPCPos = CFrame.new(638.44, 71.77, 918.28), Mob = "Swan Pirate", NPCName = "Quest Giver"},
    {Level = 800, Quest = "Area2Quest", QuestNum = 2, NPCPos = CFrame.new(632.70, 73.11, 918.67), Mob = "Factory Staff", NPCName = "Quest Giver"},
    {Level = 875, Quest = "MarineQuest3", QuestNum = 1, NPCPos = CFrame.new(-2440.80, 71.71, -3216.07), Mob = "Marine Lieutenant", NPCName = "Quest Giver"},
    {Level = 900, Quest = "MarineQuest3", QuestNum = 2, NPCPos = CFrame.new(-2440.80, 71.71, -3216.07), Mob = "Marine Captain", NPCName = "Quest Giver"},
    {Level = 950, Quest = "ZombieQuest", QuestNum = 1, NPCPos = CFrame.new(-5497.06, 47.59, -795.24), Mob = "Zombie", NPCName = "Quest Giver"},
    {Level = 975, Quest = "ZombieQuest", QuestNum = 2, NPCPos = CFrame.new(-5497.06, 47.59, -795.24), Mob = "Vampire", NPCName = "Quest Giver"},
    {Level = 1000, Quest = "SnowMountainQuest", QuestNum = 1, NPCPos = CFrame.new(609.86, 400.12, -5372.26), Mob = "Snow Trooper", NPCName = "Quest Giver"},
    {Level = 1050, Quest = "SnowMountainQuest", QuestNum = 2, NPCPos = CFrame.new(609.86, 400.12, -5372.26), Mob = "Winter Warrior", NPCName = "Quest Giver"},
    {Level = 1100, Quest = "IceSideQuest", QuestNum = 1, NPCPos = CFrame.new(-6064.07, 15.24, -4902.98), Mob = "Lab Subordinate", NPCName = "Quest Giver"},
    {Level = 1125, Quest = "IceSideQuest", QuestNum = 2, NPCPos = CFrame.new(-6064.07, 15.24, -4902.98), Mob = "Horned Warrior", NPCName = "Quest Giver"},
    {Level = 1175, Quest = "FireSideQuest", QuestNum = 1, NPCPos = CFrame.new(-5428.03, 15.06, -5299.43), Mob = "Magma Ninja", NPCName = "Quest Giver"},
    {Level = 1200, Quest = "FireSideQuest", QuestNum = 2, NPCPos = CFrame.new(-5428.03, 15.06, -5299.43), Mob = "Lava Pirate", NPCName = "Quest Giver"},
    {Level = 1250, Quest = "ShipQuest1", QuestNum = 1, NPCPos = CFrame.new(1037.80, 125.09, 32911.60), Mob = "Ship Deckhand", NPCName = "Quest Giver"},
    {Level = 1275, Quest = "ShipQuest1", QuestNum = 2, NPCPos = CFrame.new(1037.80, 125.09, 32911.60), Mob = "Ship Engineer", NPCName = "Quest Giver"},
    {Level = 1300, Quest = "ShipQuest2", QuestNum = 1, NPCPos = CFrame.new(968.81, 125.09, 33244.12), Mob = "Ship Steward", NPCName = "Quest Giver"},
    {Level = 1325, Quest = "ShipQuest2", QuestNum = 2, NPCPos = CFrame.new(968.81, 125.09, 33244.12), Mob = "Ship Officer", NPCName = "Quest Giver"},
    {Level = 1350, Quest = "FrostQuest", QuestNum = 1, NPCPos = CFrame.new(5667.66, 26.80, -6486.09), Mob = "Arctic Warrior", NPCName = "Quest Giver"},
    {Level = 1375, Quest = "FrostQuest", QuestNum = 2, NPCPos = CFrame.new(5667.66, 26.80, -6486.09), Mob = "Snow Lurker", NPCName = "Quest Giver"},
    {Level = 1425, Quest = "ForgottenQuest", QuestNum = 1, NPCPos = CFrame.new(-3054.44, 235.54, -10142.82), Mob = "Sea Soldier", NPCName = "Quest Giver"},
    {Level = 1450, Quest = "ForgottenQuest", QuestNum = 2, NPCPos = CFrame.new(-3054.44, 235.54, -10142.82), Mob = "Water Fighter", NPCName = "Quest Giver"},
    {Level = 1500, Quest = "PiratePortQuest", QuestNum = 1, NPCPos = CFrame.new(-450.10, 107.68, 5950.73), Mob = "Pirate Millionaire", NPCName = "Quest Giver"},
    {Level = 1525, Quest = "PiratePortQuest", QuestNum = 2, NPCPos = CFrame.new(-450.10, 107.68, 5950.73), Mob = "Pistol Billionaire", NPCName = "Quest Giver"},
    {Level = 1575, Quest = "DragonCrewQuest", QuestNum = 1, NPCPos = CFrame.new(6750.49, 127.45, -711.03), Mob = "Dragon Crew Warrior", NPCName = "Quest Giver"},
    {Level = 1600, Quest = "DragonCrewQuest", QuestNum = 2, NPCPos = CFrame.new(6750.49, 127.45, -711.03), Mob = "Dragon Crew Archer", NPCName = "Quest Giver"},
    {Level = 1625, Quest = "VenomCrewQuest", QuestNum = 1, NPCPos = CFrame.new(5206.40, 1004.10, 748.35), Mob = "Hydra Enforcer", NPCName = "Quest Giver"},
    {Level = 1650, Quest = "VenomCrewQuest", QuestNum = 2, NPCPos = CFrame.new(5206.40, 1004.10, 748.35), Mob = "Venomous Assailant", NPCName = "Quest Giver"},
    {Level = 1700, Quest = "MarineTreeIsland", QuestNum = 1, NPCPos = CFrame.new(2481.09, 74.27, -6779.64), Mob = "Marine Commodore", NPCName = "Quest Giver"},
    {Level = 1725, Quest = "MarineTreeIsland", QuestNum = 2, NPCPos = CFrame.new(2481.09, 74.27, -6779.64), Mob = "Marine Rear Admiral", NPCName = "Quest Giver"},
    {Level = 1775, Quest = "DeepForestIsland3", QuestNum = 1, NPCPos = CFrame.new(-10581.66, 330.87, -8761.19), Mob = "Fishman Raider", NPCName = "Quest Giver"},
    {Level = 1800, Quest = "DeepForestIsland3", QuestNum = 2, NPCPos = CFrame.new(-10581.66, 330.87, -8761.19), Mob = "Fishman Captain", NPCName = "Quest Giver"},
    {Level = 1825, Quest = "DeepForestIsland", QuestNum = 1, NPCPos = CFrame.new(-13234.04, 331.49, -7625.40), Mob = "Forest Pirate", NPCName = "Quest Giver"},
    {Level = 1850, Quest = "DeepForestIsland", QuestNum = 2, NPCPos = CFrame.new(-13234.04, 331.49, -7625.40), Mob = "Mythological Pirate", NPCName = "Quest Giver"},
    {Level = 1900, Quest = "DeepForestIsland2", QuestNum = 1, NPCPos = CFrame.new(-12680.38, 389.97, -9902.02), Mob = "Jungle Pirate", NPCName = "Quest Giver"},
    {Level = 1925, Quest = "DeepForestIsland2", QuestNum = 2, NPCPos = CFrame.new(-12680.38, 389.97, -9902.02), Mob = "Musketeer Pirate", NPCName = "Quest Giver"},
    {Level = 1975, Quest = "HauntedQuest1", QuestNum = 1, NPCPos = CFrame.new(-9479.22, 141.22, 5566.09), Mob = "Reborn Skeleton", NPCName = "Quest Giver"},
    {Level = 2000, Quest = "HauntedQuest1", QuestNum = 2, NPCPos = CFrame.new(-9479.22, 141.22, 5566.09), Mob = "Living Zombie", NPCName = "Quest Giver"},
    {Level = 2025, Quest = "HauntedQuest2", QuestNum = 1, NPCPos = CFrame.new(-9516.99, 172.02, 6078.47), Mob = "Demonic Soul", NPCName = "Quest Giver"},
    {Level = 2050, Quest = "HauntedQuest2", QuestNum = 2, NPCPos = CFrame.new(-9516.99, 172.02, 6078.47), Mob = "Posessed Mummy", NPCName = "Quest Giver"},
    {Level = 2075, Quest = "NutsIslandQuest", QuestNum = 1, NPCPos = CFrame.new(-2104.39, 38.10, -10194.22), Mob = "Peanut Scout", NPCName = "Quest Giver"},
    {Level = 2100, Quest = "NutsIslandQuest", QuestNum = 2, NPCPos = CFrame.new(-2104.39, 38.10, -10194.22), Mob = "Peanut President", NPCName = "Quest Giver"},
    {Level = 2125, Quest = "IceCreamIslandQuest", QuestNum = 1, NPCPos = CFrame.new(-820.65, 65.82, -10965.80), Mob = "Ice Cream Chef", NPCName = "Quest Giver"},
    {Level = 2150, Quest = "IceCreamIslandQuest", QuestNum = 2, NPCPos = CFrame.new(-820.65, 65.82, -10965.80), Mob = "Ice Cream Commander", NPCName = "Quest Giver"},
    {Level = 2200, Quest = "CakeQuest1", QuestNum = 1, NPCPos = CFrame.new(-2021.32, 37.80, -12028.73), Mob = "Cookie Crafter", NPCName = "Quest Giver"},
    {Level = 2225, Quest = "CakeQuest1", QuestNum = 2, NPCPos = CFrame.new(-2021.32, 37.80, -12028.73), Mob = "Cake Guard", NPCName = "Quest Giver"},
    {Level = 2250, Quest = "CakeQuest2", QuestNum = 1, NPCPos = CFrame.new(-1927.92, 37.80, -12842.54), Mob = "Baking Staff", NPCName = "Quest Giver"},
    {Level = 2275, Quest = "CakeQuest2", QuestNum = 2, NPCPos = CFrame.new(-1927.92, 37.80, -12842.54), Mob = "Head Baker", NPCName = "Quest Giver"},
    {Level = 2300, Quest = "ChocQuest1", QuestNum = 1, NPCPos = CFrame.new(233.23, 29.88, -12201.23), Mob = "Cocoa Warrior", NPCName = "Quest Giver"},
    {Level = 2325, Quest = "ChocQuest1", QuestNum = 2, NPCPos = CFrame.new(233.23, 29.88, -12201.23), Mob = "Chocolate Bar Battler", NPCName = "Quest Giver"},
    {Level = 2350, Quest = "ChocQuest2", QuestNum = 1, NPCPos = CFrame.new(150.51, 30.69, -12774.50), Mob = "Sweet Thief", NPCName = "Quest Giver"},
    {Level = 2375, Quest = "ChocQuest2", QuestNum = 2, NPCPos = CFrame.new(150.51, 30.69, -12774.50), Mob = "Candy Rebel", NPCName = "Quest Giver"},
    {Level = 2400, Quest = "CandyQuest1", QuestNum = 1, NPCPos = CFrame.new(-1150.04, 20.38, -14446.33), Mob = "Candy Pirate", NPCName = "Quest Giver"},
    {Level = 2425, Quest = "CandyQuest1", QuestNum = 2, NPCPos = CFrame.new(-1150.04, 20.38, -14446.33), Mob = "Snow Demon", NPCName = "Quest Giver"},
    {Level = 2450, Quest = "TikiQuest1", QuestNum = 1, NPCPos = CFrame.new(-16547.75, 61.14, -173.41), Mob = "Isle Outlaw", NPCName = "Quest Giver"},
    {Level = 2475, Quest = "TikiQuest1", QuestNum = 2, NPCPos = CFrame.new(-16547.75, 61.14, -173.41), Mob = "Island Boy", NPCName = "Quest Giver"},
    {Level = 2525, Quest = "TikiQuest2", QuestNum = 2, NPCPos = CFrame.new(-16539.08, 55.69, 1051.57), Mob = "Isle Champion", NPCName = "Quest Giver"},
    {Level = 2550, Quest = "TikiQuest3", QuestNum = 1, NPCPos = CFrame.new(-16665.19, 104.60, 1579.69), Mob = "Serpent Hunter", NPCName = "Quest Giver"},
    {Level = 2575, Quest = "TikiQuest3", QuestNum = 2, NPCPos = CFrame.new(-16665.19, 104.60, 1579.69), Mob = "Skull Slayer", NPCName = "Quest Giver"},
}

local function GetQuestData(level)
    local success, result = pcall(function()
        local GuideModule = require(ReplicatedStorage.GuideModule)
        local Quests = require(ReplicatedStorage.Quests)
        
        local npcPosition = nil
        local questLevel = 0
        local levelRequire = 0
        local questName = ""
        local mobName = ""
        local mobNameClean = ""

        -- Special handling for low levels (Redz logic)
        if level >= 1 and level <= 9 then
            if tostring(LocalPlayer.Team) == "Pirates" then
                return {Level = 1, Quest = "BanditQuest1", QuestNum = 1, NPCPos = CFrame.new(1059.99, 16.92, 1549.28), Mob = "Bandit", NPCName = "Quest Giver"}
            else
                return {Level = 1, Quest = "MarineQuest", QuestNum = 1, NPCPos = CFrame.new(-2709.67, 24.52, 2104.24), Mob = "Trainee", NPCName = "Marine Quest Giver"}
            end
        end

        -- Special handling for Prisoner (Redz logic)
        if level >= 210 and level <= 249 then
            return {Level = 210, Quest = "PrisonerQuest", QuestNum = 2, NPCPos = CFrame.new(5308.93, 1.65, 475.12), Mob = "Dangerous Prisoner", NPCName = "Quest Giver"}
        end

        -- Iterate GuideModule to find the best quest
        if GuideModule and GuideModule.Data and GuideModule.Data.NPCList then
            for _, npcData in pairs(GuideModule.Data.NPCList) do
                for index, lvl in pairs(npcData.Levels) do
                    if level >= lvl then
                        if not levelRequire or levelRequire < lvl then
                            npcPosition = npcData.CFrame
                            questLevel = index -- This is the QuestNum
                            levelRequire = lvl
                        end
                        -- Redz logic for 3 levels
                        if #npcData.Levels == 3 and questLevel == 3 then
                            npcPosition = npcData.CFrame
                            questLevel = 2
                            levelRequire = npcData.Levels[2]
                        end
                    end
                end
            end
        end

        -- Handle Entrance Requests (Sky 3, Underwater)
        if npcPosition then
             if level >= 375 and level <= 399 and (npcPosition.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.85, 11.67, 1819.78))
            end
            if level >= 400 and level <= 449 and (npcPosition.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.85, 11.67, 1819.78))
            end
        end

        -- Find Quest Name and Mob Name from Quests module
        if Quests then
            for questId, questData in pairs(Quests) do
                for _, taskData in pairs(questData) do
                    if taskData.LevelReq == levelRequire then
                        -- Exclude CitizenQuest as per Redz
                        if questId ~= "CitizenQuest" then
                            questName = questId
                            for _, taskName in pairs(taskData.Task) do
                                mobName = taskName
                                mobNameClean = string.split(taskName, " [Lv. " .. taskData.LevelReq .. "]")[1]
                            end
                        end
                    end
                end
            end
        end

        -- Special Overrides (Redz logic)
        if questName ~= "MarineQuest2" and questName ~= "ImpelQuest" and questName ~= "SkyExp1Quest" then
            if questName == "Area2Quest" and questLevel == 2 then
                questName = "Area2Quest"
                questLevel = 1
                mobNameClean = "Swan Pirate"
                levelRequire = 775
            end
        elseif questLevel ~= 1 then
            if questLevel == 2 then
                npcPosition = CFrame.new(-7859.09, 5544.19, -381.47)
            end
        else
            npcPosition = CFrame.new(-4721.88, 843.87, -1949.96)
        end
        
        if questName == "ImpelQuest" then
            questName = "PrisonerQuest"
            questLevel = 2
            mobNameClean = "Dangerous Prisoner"
            levelRequire = 210
            npcPosition = CFrame.new(5310.60, 0.35, 474.94)
        end

        if questName == "MarineQuest2" then
            questName = "MarineQuest2"
            questLevel = 1
            mobNameClean = "Chief Petty Officer"
            levelRequire = 120
        end

        if questName ~= "" and npcPosition then
            return {
                Level = levelRequire,
                Quest = questName,
                QuestNum = questLevel,
                NPCPos = npcPosition,
                Mob = mobNameClean,
                NPCName = "Quest Giver"
            }
        end
        return nil
    end)

    if success and result then
        return result
    end

    -- Fallback to QuestDatabase if GuideModule fails
    
    local bestQuest = nil
    for _, questData in ipairs(QuestDatabase) do
        if level >= questData.Level then 
            local questWorld = 1
            if questData.Level >= 700 and questData.Level < 1500 then questWorld = 2 end
            if questData.Level >= 1500 then questWorld = 3 end
            
            if CheckSea(questWorld) then
                bestQuest = questData 
            end
        else 
            break 
        end
    end
    return bestQuest
end

local TravelLookup = {}
local TravelOptions = {}
for _, quest in ipairs(QuestDatabase) do
    local label = string.format("%s (Lv %d)", quest.Mob, quest.Level)
    if not TravelLookup[label] then
        TravelLookup[label] = quest.NPCPos
        table.insert(TravelOptions, label)
    end
end
table.sort(TravelOptions)
if not table.find(TravelOptions, _G.Settings.Teleport["Select Island"]) then
    _G.Settings.Teleport["Select Island"] = TravelOptions[1] or ""
end

local FruitOptions = {}
do
    local success, fruitData = pcall(function()
        return ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits")
    end)
    if success and type(fruitData) == "table" then
        for _, info in ipairs(fruitData) do
            if type(info) == "table" and info.Name then
                table.insert(FruitOptions, info.Name)
            end
        end
    end
    if #FruitOptions == 0 then
        FruitOptions = {"Flame-Flame", "Light-Light", "Dark-Dark", "Magma-Magma", "Dough-Dough"}
    end
    table.sort(FruitOptions)
end
if not table.find(FruitOptions, _G.Settings.Fruit["Selected Sniper Fruit"]) then
    _G.Settings.Fruit["Selected Sniper Fruit"] = FruitOptions[1]
end
if not table.find(FruitOptions, _G.Settings.Fruit["Selected Eat Fruit"]) then
    _G.Settings.Fruit["Selected Eat Fruit"] = FruitOptions[1]
end

local function GetClosestEnemy(mobName)
    local closest, minDistance = nil, math.huge
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not myPos then return nil end
    if workspace:FindFirstChild("Enemies") then
        for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
            -- Use string.find for more robust matching (e.g. "Bandit" matches "Bandit [Lv. 5]")
            if (enemy.Name == mobName or string.find(enemy.Name, mobName)) and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                local distance = (enemy.HumanoidRootPart.Position - myPos).Magnitude
                if distance < minDistance then minDistance = distance; closest = enemy end
            end
        end
    end
    return closest
end

local function GetClosestEnemyFromList(mobNames)
    local closest, minDistance = nil, math.huge
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not myPos or not workspace:FindFirstChild("Enemies") then return nil end
    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
        if table.find(mobNames, enemy.Name) and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
            local distance = (enemy.HumanoidRootPart.Position - myPos).Magnitude
            if distance < minDistance then
                minDistance = distance
                closest = enemy
            end
        end
    end
    return closest
end

local function GetNearestModelWithRoot(folder)
    if not folder then return nil end
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, minDistance = nil, math.huge
    for _, model in ipairs(folder:GetChildren()) do
        if model:IsA("Model") then
            local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 then
                local distance = (hrp.Position - root.Position).Magnitude
                if distance < minDistance then
                    minDistance = distance
                    closest = model
                end
            end
        end
    end
    return closest
end

local function EngageSeaTarget(model, hoverHeight)
    if not model then return end
    local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    AnchorEnemy(model)
    toTarget(hrp.CFrame * CFrame.new(0, hoverHeight or 60, 0))
    if EquipPreferredWeapon() then
        EnsureHaki()
        ReleaseSit()
        PerformBasicAttack()
    end
end

local MaterialRoutes = {
    ["Radiactive Material"] = {
        {Mob = "Factory Staff", Position = CFrame.new(-105.889565, 72.807693, -670.247986), Spawn = "Bar", World = 2},
    },
    ["Leather + Scrap Metal"] = {
        {Mob = "Pirate", Position = CFrame.new(-967.433105, 13.599994, 4034.24707), Spawn = "Pirate", World = 1},
        {Mob = "Brute", Position = CFrame.new(-1191.412354, 15.599999, 4235.509277), Spawn = "Pirate", World = 1},
        {Mob = "Mercenary", Position = CFrame.new(-986.774475, 72.875595, 1088.446533), Spawn = "DressTown", World = 2},
        {Mob = "Pirate Millionaire", Position = CFrame.new(-118.809372, 55.487457, 5649.17041), World = 3},
    },
    ["Magma Ore"] = {
        {Mob = "Military Soldier", Position = CFrame.new(-5565.601563, 9.100018, 8327.569336), Spawn = "Magma", World = 1},
        {Mob = "Military Spy", Position = CFrame.new(-5806.70068, 78.500046, 8904.469727), Spawn = "Magma", World = 1},
        {Mob = "Lava Pirate", Position = CFrame.new(-5158.770508, 14.479196, -4654.262695), Spawn = "CircleIslandFire", World = 2},
    },
    ["Fish Tail"] = {
        {Mob = "Fishman Warrior", Position = CFrame.new(60943.9023, 17.949219, 1744.11133), Spawn = "Underwater City", World = 1},
        {Mob = "Fishman Commando", Position = CFrame.new(61760.8984, 18.080078, 1460.11133), Spawn = "Underwater City", World = 1},
        {Mob = "Fishman Captain", Position = CFrame.new(-10828.1064, 331.825989, -9049.14648), Spawn = "PineappleTown", World = 3},
    },
    ["Angel Wings"] = {
        {Mob = "Royal Soldier", Position = CFrame.new(-7759.458984, 5606.936523, -1862.702759), Spawn = "SkyArea2", World = 1},
    },
    ["Mystic Droplet"] = {
        {Mob = "Water Fighter", Position = CFrame.new(-3331.70459, 239.138336, -10553.3564), Spawn = "ForgottenIsland", World = 2},
    },
    ["Vampire Fang"] = {
        {Mob = "Vampire", Position = CFrame.new(-6132.39453, 9.007694, -1466.16919), Spawn = "Graveyard", World = 2},
    },
    ["Gunpowder"] = {
        {Mob = "Pistol Billionaire", Position = CFrame.new(-185.693283, 84.70887, 6103.62744), Spawn = "Mansion", World = 3},
    },
    ["Mini Tusk"] = {
        {Mob = "Mythological Pirate", Position = CFrame.new(-13456.0498, 469.433228, -7039.96436), Spawn = "BigMansion", World = 3},
    },
    ["Conjured Cocoa"] = {
        {Mob = "Chocolate Bar Battler", Position = CFrame.new(582.828674, 25.582499, -12550.7041), Spawn = "Chocolate", World = 3},
    },
}

local MaterialOptions = {}
for name in pairs(MaterialRoutes) do
    table.insert(MaterialOptions, name)
end
table.sort(MaterialOptions)

local function unwrapOption(option)
    if typeof(option) == "table" then
        return option[1]
    end
    return option
end

local function GetMaterialRoute(material)
    local routes = MaterialRoutes[material]
    if not routes then return nil end
    local filtered = {}
    for _, entry in ipairs(routes) do
        if not entry.World or entry.World == CurrentWorld then
            table.insert(filtered, entry)
        end
    end
    return #filtered > 0 and filtered or nil
end

local function SetSpawnPoint(name)
    if not name then return end
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint", name)
    end)
end

local function ScoreChest(part)
    if not part then return 0 end
    local tier = part:GetAttribute("Tier")
    if typeof(tier) == "number" then
        return tier
    end
    local name = part.Name:lower()
    if name:find("diamond") then return 3 end
    if name:find("gold") then return 2 end
    if name:find("silver") then return 1 end
    return 0.5
end

local ChestBlacklist = {}

local function GetBestChest()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local best, bestWeight = nil, -math.huge
    
    local function consider(part)
        if part and part:IsA("BasePart") then
            if ChestBlacklist[part] then return end
            
            -- Check if disabled (claimed)
            local disabled = (part.GetAttribute and part:GetAttribute("IsDisabled"))
            if not disabled and part.Parent and part.Parent.GetAttribute then
                disabled = part.Parent:GetAttribute("IsDisabled")
            end
            if disabled then return end
            
            -- Check transparency (often used for claimed chests)
            if part.Transparency >= 1 then return end

            local distance = (part.Position - root.Position).Magnitude
            local score = ScoreChest(part)
            local weight = score - (distance / 5000)
            if weight > bestWeight then
                bestWeight = weight
                best = part
            end
        end
    end

    -- 1. Tagged Chests
    for _, chest in ipairs(CollectionService:GetTagged("_ChestTagged")) do
        consider(chest)
    end

    -- 2. ChestModels Folder (and variations)
    for _, folderName in ipairs({"ChestModels", "Chests", "Chest"}) do
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            for _, descendant in ipairs(folder:GetDescendants()) do
                if descendant:IsA("BasePart") and (descendant.Name:lower():find("chest") or descendant.Parent.Name:lower():find("chest")) then
                    consider(descendant)
                end
            end
        end
    end

    -- 3. Workspace Search (Fallback - Expanded)
    if not best then
        -- Check Map folder if exists
        local map = workspace:FindFirstChild("Map")
        if map then
            for _, descendant in ipairs(map:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Name:lower():find("chest") then
                    consider(descendant)
                end
            end
        end
        
        -- Check Workspace Children
        for _, child in ipairs(workspace:GetChildren()) do
            if child.Name:lower():find("chest") then
                if child:IsA("BasePart") then
                    consider(child)
                elseif child:IsA("Model") then
                    local part = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")
                    if part then consider(part) end
                end
            end
        end
    end

    return best
end

local function GetNearestBerryBush()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local bushes = CollectionService:GetTagged("BerryBush")
    local closest, minDistance = nil, math.huge
    for _, berry in ipairs(bushes) do
        local container = berry.Parent
        if container and container:IsA("Model") then
            local pivot = container:GetPivot()
            local distance = (pivot.Position - root.Position).Magnitude
            if distance < minDistance then
                minDistance = distance
                closest = pivot
            end
        end
    end
    return closest
end

local lastBerrySighted = 0
task.spawn(function()
    while task.wait(0.35) do
        if _G.Settings.Main["Auto Collect Berry"] then
            local pivot = GetNearestBerryBush()
            if pivot then
                lastBerrySighted = os.clock()
                toTarget(pivot * CFrame.new(0, 3, 0))
            elseif _G.Settings.Main["Auto Collect Berry Hop"] and os.clock() - lastBerrySighted > 12 then
                TeleportToServer(true)
            end
        end
    end
end)

local function StopTween()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = root.CFrame
        root.Velocity = Vector3.zero
    end
    if activeTween then
        activeTween:Cancel()
        activeTween = nil
    end
end

local function TriggerClickDetector(detector)
    if detector and fireclickdetectorFn then
        fireclickdetectorFn(detector, 0)
        fireclickdetectorFn(detector, 1)
    end
end

local chestDryCounter = 0

local function MatchesFruit(tool, fruitKey)
    if not (tool and tool:IsA("Tool")) then return false end
    local original = tool:GetAttribute("OriginalName")
    if original and original == fruitKey then return true end
    local normalizedName = tool.Name:gsub(" Fruit", ""):gsub(" ", "-")
    return normalizedName == fruitKey or (normalizedName .. "-" .. normalizedName == fruitKey)
end

local function StoreFruitTool(tool)
    if not (tool and tool:IsA("Tool")) then return end
    local fruitKey = tool:GetAttribute("OriginalName") or tool.Name:gsub(" Fruit", "")
    local ok = pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", fruitKey, tool)
    end)
    if not ok then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", fruitKey .. "-" .. fruitKey, tool)
        end)
    end
end

local function FindFruitTool(fruitKey)
    local function search(container)
        if not container then return nil end
        for _, tool in ipairs(container:GetChildren()) do
            if MatchesFruit(tool, fruitKey) then
                return tool
            end
        end
    end
    return search(LocalPlayer.Backpack) or search(LocalPlayer.Character)
end

local function GetNearestFruitTool()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local nearest, minDistance = nil, math.huge
    for _, inst in ipairs(workspace:GetChildren()) do
        if inst:IsA("Tool") and inst:FindFirstChild("Handle") and inst.Name:lower():find("fruit") then
            local dist = (inst.Handle.Position - root.Position).Magnitude
            if dist < minDistance then
                minDistance = dist
                nearest = inst
            end
        end
    end
    return nearest
end

local function BringMob(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    if not workspace:FindFirstChild("Enemies") then return end
    
    pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end)
    
    local count = 0
    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
        if count >= 5 then break end -- Limit to 5 mobs to prevent lag/crash
        if enemy ~= target and enemy.Name == target.Name and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            local distance = (enemy.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude
            if distance < 300 then -- Reduced radius slightly
                enemy.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
                enemy.HumanoidRootPart.CanCollide = false
                enemy.HumanoidRootPart.Size = Vector3.new(2, 2, 2)
                enemy.Humanoid.WalkSpeed = 0
                enemy.Humanoid.JumpPower = 0
                enemy.Humanoid.PlatformStand = true
                if enemy.Humanoid:FindFirstChild("Animator") then
                    enemy.Humanoid.Animator:Destroy()
                end
                enemy.Humanoid:ChangeState(11)
                if enemy:FindFirstChild("Head") then enemy.Head.CanCollide = false end
                count = count + 1
            end
        end
    end
end

local function GetMobSpawns(mobName)
    local spawns = {}
    local function clean(str)
        return str:gsub("Lv%.", ""):gsub("[%[%]]", ""):gsub("%d+", ""):gsub("%s+", "")
    end
    local targetClean = clean(mobName)

    -- 1. Check our generated EnemySpawns folder
    if workspace:FindFirstChild("EnemySpawns") then
        for _, spawnPoint in ipairs(workspace.EnemySpawns:GetChildren()) do
            if spawnPoint:IsA("BasePart") then
                local name = clean(spawnPoint.Name)
                if name == targetClean or spawnPoint.Name == mobName or string.find(spawnPoint.Name, targetClean) then
                    table.insert(spawns, spawnPoint.CFrame)
                end
            end
        end
    end

    -- 2. Fallback: Check _WorldOrigin directly
    if #spawns == 0 and workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("EnemySpawns") then
        for _, spawnPoint in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
            if spawnPoint:IsA("BasePart") then
                local name = clean(spawnPoint.Name)
                if name == targetClean or string.find(name, targetClean) then
                    table.insert(spawns, spawnPoint.CFrame)
                end
            end
        end
    end

    return spawns
end

-- Global Target for Locking
_G.CurrentTarget = nil

-- Strong Enemy Lock & Bring Loop (Heartbeat)
RunService.Heartbeat:Connect(function()
    local target = _G.CurrentTarget
    if target and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0 and target:FindFirstChild("HumanoidRootPart") then
        -- Lock Target
        pcall(function()
            target.Humanoid.WalkSpeed = 0
            target.HumanoidRootPart.Velocity = Vector3.zero
            target.HumanoidRootPart.Anchored = true
            target.HumanoidRootPart.CanCollide = false
        end)

        -- Bring Nearby Mobs to Target (Cluster)
        if _G.Settings.Main["Auto Farm Level"] then
            for _, other in pairs(workspace.Enemies:GetChildren()) do
                if other ~= target and other.Name == target.Name and other:FindFirstChild("HumanoidRootPart") and other:FindFirstChild("Humanoid") and other.Humanoid.Health > 0 then
                    if (other.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude < 300 then
                        pcall(function()
                            other.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
                            other.HumanoidRootPart.CanCollide = false
                            other.HumanoidRootPart.Anchored = true
                            other.Humanoid.WalkSpeed = 0
                            other.Humanoid:ChangeState(11)
                        end)
                    end
                end
            end
        end
    else
        _G.CurrentTarget = nil
    end
end)

-- Auto Farm Level (Redz Logic - Re-implemented)
local StuckCounter = 0
local LastTarget = nil
local LastHP = 0
local BlacklistedEnemies = {}

task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Level"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if _G.Settings.Main["Auto Farm Chest"] then
                -- Pause Auto Farm Level if Chest Farm is active
            else
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local questData = GetQuestData(level)
                    if not questData then 
                        warn("Aero Hub: No quest data found for level " .. tostring(level))
                        return 
                    end
                    
                    local questGui = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
                    local hasQuest = questGui and questGui.Visible and (string.find(questGui.Container.QuestTitle.Title.Text, questData.Mob) or string.find(questGui.Container.QuestTitle.Title.Text, "Boss"))
                    
                    if not hasQuest then
                        _G.CurrentTarget = nil -- Clear target when getting quest
                        BlacklistedEnemies = {} -- Reset blacklist on new quest
                        if LocalPlayer.Character.HumanoidRootPart.Anchored then LocalPlayer.Character.HumanoidRootPart.Anchored = false end
                        -- Abandon wrong quest
                        if questGui and questGui.Visible then
                            _G.TargetCFrame = nil -- Stop moving
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                            task.wait(0.5)
                            return
                        end

                        -- Go to Quest Giver
                        if (LocalPlayer.Character.HumanoidRootPart.Position - questData.NPCPos.Position).Magnitude > 20 then
                            TP2(questData.NPCPos)
                        else
                            _G.TargetCFrame = nil -- Stop moving
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questData.Quest, questData.QuestNum)
                            task.wait(0.5)
                        end
                    else
                        -- Quest Active: Find and Kill
                        local targetName = questData.Mob
                        local enemy = _G.CurrentTarget
                        
                        -- Validate existing target
                        if enemy then
                            if not enemy.Parent or not enemy:FindFirstChild("Humanoid") or enemy.Humanoid.Health <= 0 or BlacklistedEnemies[enemy] or enemy.Name ~= targetName then
                                enemy = nil
                                _G.CurrentTarget = nil
                            end
                        end
                        
                        -- Find closest living enemy (ignoring blacklisted) if no valid target
                        if not enemy and workspace:FindFirstChild("Enemies") then
                            local potentialEnemies = {}
                            for _, v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == targetName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                    if not BlacklistedEnemies[v] then
                                        if not enemy or (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude then
                                            enemy = v
                                        end
                                    else
                                        table.insert(potentialEnemies, v)
                                    end
                                end
                            end
                            
                            -- If no valid enemies found but we have blacklisted ones, retry the closest blacklisted one
                            if not enemy and #potentialEnemies > 0 then
                                BlacklistedEnemies = {} -- Reset blacklist
                                enemy = potentialEnemies[1] -- Just pick one to retry
                            end
                        end
                        
                        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                            -- Stuck/Unkillable Detection
                            if enemy == LastTarget then
                                if enemy.Humanoid.Health >= LastHP then
                                    StuckCounter = StuckCounter + 1
                                else
                                    StuckCounter = 0 -- Reset if damage dealt
                                    LastHP = enemy.Humanoid.Health
                                end
                            else
                                LastTarget = enemy
                                LastHP = enemy.Humanoid.Health
                                StuckCounter = 0
                            end

                            -- If stuck for ~25 seconds (approx 500 ticks at wait())
                            if StuckCounter > 500 then 
                                BlacklistedEnemies[enemy] = true
                                _G.CurrentTarget = nil
                                StuckCounter = 0
                                return -- Skip this frame to find new target
                            end

                            -- Set Global Target for Locking Loop
                            _G.CurrentTarget = enemy

                            -- Force Enable Fast Attack
                            _G.Settings.Configs["Fast Attack"] = true

                            -- Smart Positioning: World Space + Ceiling Check
                            -- Lowered to 7 studs to ensure hits connect
                            local targetPos = enemy.HumanoidRootPart.Position + Vector3.new(0, 7, 0)
                            
                            -- Wiggle if stuck to try and find a hitting angle
                            if StuckCounter > 50 then
                                local angle = (os.clock() * 5) % (math.pi * 2)
                                targetPos = targetPos + Vector3.new(math.cos(angle) * 5, 0, math.sin(angle) * 5)
                            end
                            
                            -- Raycast to check for ceilings/walls above enemy
                            local rayOrigin = enemy.HumanoidRootPart.Position
                            local rayDirection = Vector3.new(0, 10, 0)
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {LocalPlayer.Character, workspace.Enemies, workspace:FindFirstChild("EnemySpawns")}
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude
                            
                            local rayResult = workspace:Raycast(rayOrigin, rayDirection, rayParams)
                            if rayResult then
                                -- If blocked, position slightly below the hit point
                                targetPos = rayResult.Position - Vector3.new(0, 2.5, 0)
                            end
                            
                            -- Wall Check: Nudge away from walls
                            local checkDist = 2 -- Reduced to 2 to prevent being pushed too far
                            local dirs = {Vector3.new(1,0,0), Vector3.new(-1,0,0), Vector3.new(0,0,1), Vector3.new(0,0,-1)}
                            for _, d in ipairs(dirs) do
                                local wallRay = workspace:Raycast(targetPos, d * checkDist, rayParams)
                                if wallRay then
                                    -- Move away from wall
                                    targetPos = targetPos - (d * (checkDist - wallRay.Distance + 0.5))
                                end
                            end

                            -- Look at Enemy
                            local farmPos = CFrame.new(targetPos, enemy.HumanoidRootPart.Position)
                            TP2(farmPos)
                            
                            -- Attack (Force Trigger)
                            EquipPreferredWeapon()
                            EnsureHaki()
                            
                            -- 1. Fast Attack Call
                            FastAttack:AttackNearest()
                        else
                            -- No enemy found: Go to Spawn
                            _G.CurrentTarget = nil
                            if LocalPlayer.Character.HumanoidRootPart.Anchored then LocalPlayer.Character.HumanoidRootPart.Anchored = false end
                            
                            local spawns = GetMobSpawns(targetName)
                            if #spawns > 0 then
                                -- Cycle spawns if needed, or just go to the first one
                                local targetSpawn = spawns[1]
                                TP2(targetSpawn * CFrame.new(0, 30, 0))
                            else
                                -- Fallback: Hover at Quest Giver
                                TP2(questData.NPCPos * CFrame.new(0, 30, 0))
                            end
                        end
                    end
                end)
            end
        end
        -- Reset Farm Position if disabled
        if not _G.Settings.Main["Auto Farm Level"] then
            _G.TargetCFrame = nil
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.PlatformStand = false
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
end)

-- Auto Farm Skip (Lv 1-100)
task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Fast Auto Farm Level"] then
            if CurrentWorld == 1 then
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    if level >= 100 then
                        _G.Settings.Main["Fast Auto Farm Level"] = false
                        _G.Settings.Main["Auto Farm Level"] = true
                        return
                    end
                    
                    -- Request Entrance to Sky (Upper Yard)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6, 5547.1, -380.3))
                    
                    -- Farm Shanda
                    local targetName = "Shanda"
                    local enemy = GetClosestEnemy(targetName)
                    
                    if enemy then
                        ApproachEnemy(enemy, 30)
                    else
                        -- If no enemy, wait at spawn or safe spot
                        toTarget(CFrame.new(-7678.5, 5566.4, -497.2))
                    end
                end)
            else
                -- Disable if not in World 1
                _G.Settings.Main["Fast Auto Farm Level"] = false
            end
        end
    end
end)

-- Auto Kaitun (Account Maxing)
task.spawn(function()
    while task.wait(1) do
        if _G.Settings.Main["Auto Kaitun"] then
            pcall(function()
                -- 1. Enable Essentials
                _G.Settings.Main["Auto Farm Level"] = true
                _G.Settings.Configs["Auto Haki"] = true
                _G.Settings.Stats["Enabled Auto Stats"] = true
                _G.Settings.Shop["Auto Legendary Sword"] = true
                _G.Settings.Fruit["Auto Store Fruits"] = true
                
                -- 2. Sea 1 -> Sea 2 Transition
                if CurrentWorld == 1 and LocalPlayer.Data.Level.Value >= 700 then
                    _G.Settings.Main["Auto Farm Level"] = false -- Pause farming to do quest
                    
                    local map = workspace:FindFirstChild("Map")
                    local iceDoor = map and map:FindFirstChild("Ice") and map.Ice:FindFirstChild("Door")
                    
                    -- Step 1: Talk to Detective
                    local detectivePos = CFrame.new(4849.3, 5.65, 719.6)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - detectivePos.Position).Magnitude > 15 then
                        toTarget(detectivePos)
                    else
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                        task.wait(0.5)
                        EquipWeapon("Key")
                    end
                    
                    -- Step 2: Go to Ice Admiral
                    if iceDoor then
                        local doorPos = CFrame.new(1347.7, 37.4, -1325.6)
                        if (LocalPlayer.Character.HumanoidRootPart.Position - doorPos.Position).Magnitude > 15 then
                            toTarget(doorPos)
                        else
                            -- Kill Ice Admiral
                            local iceAdmiral = workspace.Enemies:FindFirstChild("Ice Admiral")
                            if iceAdmiral and iceAdmiral.Humanoid.Health > 0 then
                                toTarget(iceAdmiral.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                                EquipPreferredWeapon()
                                PerformBasicAttack()
                            else
                                -- Try to travel if he's dead or we are done
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                            end
                        end
                    end
                end

                -- 3. Sea 2 -> Sea 3 Transition
                if CurrentWorld == 2 and LocalPlayer.Data.Level.Value >= 1500 then
                    _G.Settings.Main["Auto Farm Level"] = false -- Pause farming
                    
                    local progress = ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "General")
                    if progress == 0 then
                        -- Go to King Red Head
                        local kingPos = CFrame.new(-1926.3, 12.8, 1738.3)
                        if (LocalPlayer.Character.HumanoidRootPart.Position - kingPos.Position).Magnitude > 15 then
                            toTarget(kingPos)
                        else
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                        end
                    elseif progress == 1 then
                        -- Kill Rip Indra
                        local ripIndra = workspace.Enemies:FindFirstChild("rip_indra")
                        if ripIndra and ripIndra.Humanoid.Health > 0 then
                             toTarget(ripIndra.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                             EquipPreferredWeapon()
                             PerformBasicAttack()
                        else
                            -- If not found, maybe wait at spawn?
                            local spawnPos = CFrame.new(-26880.9, 22.8, 473.2) -- Rough area
                            toTarget(spawnPos)
                        end
                    else
                        -- Travel to Zou
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                    end
                end
                
                -- 4. Buy Essentials (Periodically)
                if os.clock() % 60 < 2 then -- Run every minute roughly
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
                    
                    local swords = {"Cutlass", "Katana", "Iron Mace", "Duel Katana", "Triple Katana", "Pipe", "Bisento", "Soul Cane"}
                    for _, sword in ipairs(swords) do
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", sword)
                    end
                end
            end)
        end
    end
end)

-- [RedzHub Logic Start]
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
-- [RedzHub Logic End]

local currentChest = nil
local chestStart = 0

task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Chest"] then
            pcall(function()
                local chest = GetBestChest()
                
                if chest then
                    TweenX(chest.CFrame)
                    
                    -- Optional: Fire touch interest if close
                    if (LocalPlayer.Character.HumanoidRootPart.Position - chest.Position).Magnitude < 15 and firetouchinterestFn then
                        firetouchinterestFn(LocalPlayer.Character.HumanoidRootPart, chest, 0)
                        firetouchinterestFn(LocalPlayer.Character.HumanoidRootPart, chest, 1)
                    end
                else
                    chestDryCounter = chestDryCounter + 0.05
                    if _G.Settings.Main["Chest Hop When Dry"] and chestDryCounter >= (_G.Settings.Main["Chest Hop Delay"] or 10) then
                        chestDryCounter = 0
                        TeleportToServer(true)
                    end
                end
            end)
        else
            StopTween()
            chestDryCounter = 0
            ChestBlacklist = {}
            currentChest = nil
            task.wait(1)
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if _G.Settings.Main["Chest Bypass"] then
            pcall(function()
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                for _ = 1, 6 do
                    local chest = GetBestChest()
                    if not chest then break end
                    character:PivotTo(CFrame.new(chest.Position + Vector3.new(0, 2, 0)))
                    task.wait(0.2)
                end
                if character and character:FindFirstChildOfClass("Humanoid") then
                    character:BreakJoints()
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.Settings.Main["Stop Chest On Rare"] then
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack and (backpack:FindFirstChild("God's Chalice") or backpack:FindFirstChild("Fist of Darkness")) then
                _G.Settings.Main["Auto Farm Chest"] = false
                _G.Settings.Main["Chest Bypass"] = false
                chestDryCounter = 0
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if _G.Settings.Fruit["Auto Store Fruits"] then
            pcall(function()
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                local character = LocalPlayer.Character
                local function scan(container)
                    if not container then return end
                    for _, tool in ipairs(container:GetChildren()) do
                        if tool:IsA("Tool") and (tool.ToolTip == "Blox Fruit" or tool.Name:lower():find("fruit")) then
                            StoreFruitTool(tool)
                        end
                    end
                end
                scan(backpack)
                scan(character)
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(12) do
        if _G.Settings.Fruit["Auto Buy From Sniper"] then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.Settings.Fruit["Selected Sniper Fruit"], false)
            end)
        end
    end
end)

local lastFruitEat = 0
task.spawn(function()
    while task.wait(0.5) do
        if _G.Settings.Fruit["Auto Eat Fruit"] and os.clock() - lastFruitEat > 3 then
            pcall(function()
                local tool = FindFruitTool(_G.Settings.Fruit["Selected Eat Fruit"])
                if tool and tool:FindFirstChild("EatRemote") then
                    lastFruitEat = os.clock()
                    tool.EatRemote:InvokeServer()
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if _G.Settings.Fruit["Bring To Fruit"] or _G.Settings.Fruit["Tween To Fruit"] then
            pcall(function()
                local fruit = GetNearestFruitTool()
                if fruit and fruit:FindFirstChild("Handle") then
                    if _G.Settings.Fruit["Bring To Fruit"] and LocalPlayer.Character then
                        LocalPlayer.Character:PivotTo(fruit.Handle.CFrame * CFrame.new(0, 2, 0))
                    elseif _G.Settings.Fruit["Tween To Fruit"] then
                        toTarget(fruit.Handle.CFrame * CFrame.new(0, 3, 0))
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Mastery"] and not _G.Settings.Main["Auto Farm Level"] then
            pcall(function()
                local level = LocalPlayer.Data.Level.Value
                local questData = GetQuestData(level)
                if not questData then return end
                local questGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
                    and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
                if questGui and questGui.Visible then
                    -- already have quest
                else
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if root and (root.Position - questData.NPCPos.Position).Magnitude > 10 then
                        toTarget(questData.NPCPos)
                        return
                    end
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questData.Quest, questData.QuestNum)
                    task.wait(0.5)
                end
                local targetEnemy = GetClosestEnemy(questData.Mob)
                if not targetEnemy then
                    toTarget(questData.NPCPos)
                    return
                end
                local hrp = targetEnemy:FindFirstChild("HumanoidRootPart")
                local humanoid = targetEnemy:FindFirstChild("Humanoid")
                if not hrp or not humanoid or humanoid.Health <= 0 then return end
                AnchorEnemy(targetEnemy)
                toTarget(hrp.CFrame * CFrame.new(0, 25, 0))
                local healthPercent = (humanoid.Health / math.max(humanoid.MaxHealth, 1)) * 100
                if healthPercent <= (_G.Settings.Main["Mastery Health Threshold"] or 25) then
                    if EquipMasteryWeapon() then
                        EnsureHaki()
                        ReleaseSit()
                        PerformBasicAttack()
                    end
                else
                    ApproachEnemy(targetEnemy, 25)
                end
            end)
        end
    end
end)

-- Auto Farm Bone (Haunted Castle) - REMOVED

task.spawn(function()
    while task.wait(0.2) do
        if _G.Settings.Main["Mob Aura"] then
            pcall(function()
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if not root or not workspace:FindFirstChild("Enemies") then return end
                for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    local hrp = enemy:FindFirstChild("HumanoidRootPart")
                    if humanoid and hrp and humanoid.Health > 0 then
                        local distance = (hrp.Position - root.Position).Magnitude
                        if distance <= _G.Settings.Main["Distance Mob Aura"] then
                            hrp.CFrame = root.CFrame * CFrame.new(0, 0, -5)
                            hrp.CanCollide = false
                            humanoid.WalkSpeed = 0
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        -- Auto Farm Material Loop Removed
    end
end)

task.spawn(function()
    while task.wait(1) do
        -- Auto Random Bone Loop Removed
    end
end)



-- Auto Elite Hunter
task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Elite Hunter"] then
            pcall(function()
                local questGui = LocalPlayer.PlayerGui.Main.Quest
                if not questGui.Visible then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter")
                else
                    local title = questGui.Container.QuestTitle.Title.Text
                    local targetName = nil
                    if string.find(title, "Diablo") then targetName = "Diablo"
                    elseif string.find(title, "Deandre") then targetName = "Deandre"
                    elseif string.find(title, "Urban") then targetName = "Urban" end
                    
                    if targetName then
                        local target = GetClosestEnemy(targetName)
                        if target then
                            ApproachEnemy(target, 30)
                        else
                            -- Check ReplicatedStorage if not in workspace
                            local rsTarget = ReplicatedStorage:FindFirstChild(targetName)
                            if rsTarget then
                                toTarget(rsTarget.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Raid Farm
task.spawn(function()
    while task.wait(1) do
        if _G.Settings.Raid["Auto Buy Chip"] then
            local hasChip = LocalPlayer.Backpack:FindFirstChild("Special Microchip") or LocalPlayer.Character:FindFirstChild("Special Microchip")
            if not hasChip then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.Settings.Raid["Select Chip"])
            end
        end
        
        if _G.Settings.Raid["Auto Start Raid"] then
            -- Logic to press the button
            local button = workspace.Map:FindFirstChild("CircleIsland") and workspace.Map.CircleIsland:FindFirstChild("RaidSummon2")
            if not button then button = workspace.Map:FindFirstChild("Boat Castle") and workspace.Map["Boat Castle"]:FindFirstChild("RaidSummon2") end
            
            if button then
                toTarget(button.Button.Main.CFrame)
                if (button.Button.Main.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10 then
                    local detector = button.Button.Main:FindFirstChildOfClass("ClickDetector")
                        or button.Button.Main:FindFirstChild("ClickDetector")
                    TriggerClickDetector(detector)
                end
            end
        end
        
        if _G.Settings.Raid["Auto Next Island"] then
            -- Logic to move to next island in raid
            local locations = workspace._WorldOrigin.Locations:GetChildren()
            for _, loc in pairs(locations) do
                if string.find(loc.Name, "Island") and (loc.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3000 then
                    -- Simple logic: if mobs are dead, move to next? 
                    -- Usually raid scripts check for mob count. For now, we just ensure we are on the island.
                end
            end
        end
        
        if _G.Settings.Raid["Auto Awaken"] then
             ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Check")
             ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
        end
    end
end)



local ESPColors = {
    Players = Color3.fromRGB(0, 170, 255),
    Chests = Color3.fromRGB(255, 221, 85),
    Fruits = Color3.fromRGB(85, 255, 127),
    Flowers = Color3.fromRGB(255, 105, 180),
    Raids = Color3.fromRGB(190, 115, 255)
}

local function CreateESP(adornee, text, color)
    if not adornee then return end
    local bg = adornee:FindFirstChild("AeroESP")
    if not bg then
        bg = Instance.new("BillboardGui")
        bg.Name = "AeroESP"
        bg.Adornee = adornee
        bg.Size = UDim2.new(0, 200, 0, 50)
        bg.StudsOffset = Vector3.new(0, 3, 0)
        bg.AlwaysOnTop = true
        
        local label = Instance.new("TextLabel")
        label.Parent = bg
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = color
        label.TextStrokeTransparency = 0.5
        label.TextSize = 12
        label.Font = Enum.Font.GothamBold
        bg.Parent = adornee
    end
    
    local label = bg:FindFirstChild("TextLabel")
    if label then
        label.Text = text
        label.TextColor3 = color
    end
end

local function ClearESP(adornee)
    if adornee then
        local bg = adornee:FindFirstChild("AeroESP")
        if bg then bg:Destroy() end
    end
end

local function updatePlayerESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            if _G.Settings.ESP["Player ESP"] then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.Head.Position).Magnitude
                local health = player.Character.Humanoid.Health
                local text = string.format("%s\n[%.0f] [%.0f%%]", player.Name, dist, health)
                CreateESP(player.Character.Head, text, ESPColors.Players)
            else
                ClearESP(player.Character.Head)
            end
        end
    end
end

local function updateChestESP()
    for _, chest in ipairs(CollectionService:GetTagged("_ChestTagged")) do
        if _G.Settings.ESP["Chest ESP"] then
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - chest.Position).Magnitude
            CreateESP(chest, string.format("Chest\n[%.0f]", dist), ESPColors.Chests)
        else
            ClearESP(chest)
        end
    end
end

local function updateFruitESP()
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("Tool") and descendant:FindFirstChild("Handle") and string.find(descendant.Name, "Fruit") then
            if _G.Settings.ESP["Fruit ESP"] then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - descendant.Handle.Position).Magnitude
                CreateESP(descendant.Handle, string.format("%s\n[%.0f]", descendant.Name, dist), ESPColors.Fruits)
            else
                ClearESP(descendant.Handle)
            end
        end
    end
end

local function updateFlowerESP()
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if (descendant.Name == "Blue Flower" or descendant.Name == "Red Flower") and descendant:IsA("BasePart") then
            if _G.Settings.ESP["Flower ESP"] then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - descendant.Position).Magnitude
                CreateESP(descendant, string.format("%s\n[%.0f]", descendant.Name, dist), ESPColors.Flowers)
            else
                ClearESP(descendant)
            end
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        pcall(updatePlayerESP)
        pcall(updateChestESP)
        pcall(updateFruitESP)
        pcall(updateFlowerESP)
    end
end)

-- Server Hop
local function ServerHop()
    TeleportToServer(true)
end

-- UI Construction
local BoatDisplayLookup = {
    ["Pirate Brigade"] = "PirateBrigade",
    ["Pirate Sloop"] = "PirateSloop",
    ["Pirate Basic"] = "PirateBasic",
    ["Enforcer"] = "Enforcer",
    ["Rocket Boost"] = "RocketBoost",
    ["Dinghy"] = "Dinghy",
}

local BoatDropdownOptions = {}
for display in pairs(BoatDisplayLookup) do
    table.insert(BoatDropdownOptions, display)
end
table.sort(BoatDropdownOptions)

local function getBoatDisplayName(remoteName)
    for display, remote in pairs(BoatDisplayLookup) do
        if remote == remoteName then
            return display
        end
    end
    return "Pirate Brigade"
end

local DashboardTab = Window:CreateTab({Name = "Dashboard", Icon = GetIcon("Dashboard"), ImageSource = "Custom", ShowTitle = true})
DashboardTab:CreateSection("Profile Snapshot")
local ProfileStatusParagraph = DashboardTab:CreateParagraph({
    Title = "Profile Snapshot",
    Text = "Collecting player data..."
})
DashboardTab:CreateSection("World Events")
local PrehistoricParagraph = DashboardTab:CreateParagraph({
    Title = "Prehistoric Island",
    Text = "Scanning for relics..."
})
local CakePrinceParagraph = DashboardTab:CreateParagraph({
    Title = "Cake Prince Status",
    Text = "Waiting for response..."
})
local EliteParagraph = DashboardTab:CreateParagraph({
    Title = "Elite Hunter",
    Text = "Syncing elite progress..."
})
local FruitParagraph = DashboardTab:CreateParagraph({
    Title = "Fruit Distance Info",
    Text = "Looking for fruit drops..."
})
local MirageParagraph = DashboardTab:CreateParagraph({
    Title = "Mirage Island",
    Text = "Checking skyline..."
})
DashboardTab:CreateSection("Dojo Tracker")
local DojoParagraph = DashboardTab:CreateParagraph({
    Title = "Dojo Belt Progress",
    Text = "Syncing with Dojo records..."
})
DashboardTab:CreateSection("Dojo Tips")
DashboardTab:CreateParagraph({
    Title = "Fastest Methods",
    Text = "- Run Auto Farm Level for the early belts.\n- Enable Sea Event toggles for Yellow/Red progress.\n- Elite Hunter loop finishes Purple automatically."
})
DashboardTab:CreateSection("Community")
DashboardTab:CreateButton({Name = "Copy Discord Invite", Callback = function()
    safeSetClipboard("https://discord.gg/aerohub")
end})
DashboardTab:CreateButton({Name = "Copy YouTube Link", Callback = function()
    safeSetClipboard("https://youtube.com/@aerohub")
end})
DashboardTab:CreateParagraph({
    Title = "Announcements",
    Text = "Join the Discord for update pings & bug reporting. Videos showcase farming routes and stat presets."
})

task.spawn(function()
    while task.wait(2) do
        pcall(function()
            local data = LocalPlayer:FindFirstChild("Data")
            local function getValue(name, default)
                local entry = data and data:FindFirstChild(name)
                return entry and entry.Value or default
            end
            local level = getValue("Level", "?")
            local bounty = getValue("Bounty", 0)
            local fragments = getValue("Fragments", 0)
            local race = getValue("Race", "Unknown")
            local world = getWorldName()
            local text = string.format(
                "Level: %s\nBounty: %s\nFragments: %s\nRace: %s\nWorld: %s",
                formatNumber(level),
                formatNumber(bounty),
                formatNumber(fragments),
                tostring(race),
                world
            )
            ProfileStatusParagraph:Set({Text = text})
        end)
    end
end)

task.spawn(function()
    while task.wait(4) do
        pcall(function()
            local islandActive = false
            local map = workspace:FindFirstChild("Map")
            if map and map:FindFirstChild("PrehistoricRelic") then
                islandActive = true
            end
            local worldOrigin = workspace:FindFirstChild("_WorldOrigin")
            if not islandActive and worldOrigin then
                local locations = worldOrigin:FindFirstChild("Locations")
                if locations and locations:FindFirstChild("Prehistoric Island") then
                    islandActive = true
                end
            end
            local text = islandActive and "Prehistoric Island: Spawned!" or "Prehistoric Island: Not spawned"
            PrehistoricParagraph:Set({Text = text})
        end)
    end
end)

task.spawn(function()
    while task.wait(8) do
        pcall(function()
            local response = ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            local remaining = (type(response) == "string") and response:match("(%d+)")
            local text = remaining and ("Cake Prince: " .. remaining .. " enemies remaining") or "Cake Prince: Spawned!"
            CakePrinceParagraph:Set({Text = text})
        end)
    end
end)

task.spawn(function()
    while task.wait(6) do
        pcall(function()
            local status = "No elite detected"
            local eliteName = "None"
            for _, candidate in ipairs({"Diablo", "Deandre", "Urban"}) do
                if (ReplicatedStorage:FindFirstChild(candidate)) or (workspace:FindFirstChild("Enemies") and workspace.Enemies:FindFirstChild(candidate)) then
                    status = "Elite spawned"
                    eliteName = candidate
                    break
                end
            end
            local progress = ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
            local text = string.format("Status: %s\nKilled: %s\nTarget: %s", status, tostring(progress or "?"), eliteName)
            EliteParagraph:Set({Text = text})
        end)
    end
end)

task.spawn(function()
    while task.wait(5) do
        pcall(function()
            local character = LocalPlayer.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local count = 0
            local details = {}
            for _, item in ipairs(workspace:GetChildren()) do
                if string.find(item.Name, "Fruit") and item:IsA("Model") then
                    local primary = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        count = count + 1
                        local distance = (primary.Position - root.Position).Magnitude
                        if #details < 3 then
                            table.insert(details, string.format("%s - %s studs", item.Name, formatNumber(math.floor(distance))))
                        end
                    end
                end
            end
            local text = "Fruits in server: " .. tostring(count)
            if #details > 0 then
                text = text .. "\n" .. table.concat(details, "\n")
            end
            FruitParagraph:Set({Text = text})
        end)
    end
end)

task.spawn(function()
    while task.wait(5) do
        pcall(function()
            local origin = workspace:FindFirstChild("_WorldOrigin")
            local locations = origin and origin:FindFirstChild("Locations")
            local text = "Mirage Island: Not detected"
            if locations and locations:FindFirstChild("Mirage Island") then
                text = "Mirage Island: Spawned!"
            end
            MirageParagraph:Set({Text = text})
        end)
    end
end)

task.spawn(function()
    while task.wait(10) do
        pcall(function()
            local ownedIndex = 0
            for idx, belt in ipairs(DojoBeltSteps) do
                if HasAccessory(belt.name) then
                    ownedIndex = idx
                else
                    break
                end
            end
            local nextBelt = DojoBeltSteps[ownedIndex + 1]
            local text
            if nextBelt then
                text = string.format("Next Belt: %s\nGuide: %s", nextBelt.name, nextBelt.tip)
            else
                text = "All Dojo belts collected. Enjoy the Black Belt!"
            end
            DojoParagraph:Set({Text = text})
        end)
    end
end)

local MainTab = Window:CreateTab({Name = "Main", Icon = GetIcon("Main"), ImageSource = "Custom", ShowTitle = true})

MainTab:CreateSection("Farming")
MainTab:CreateToggle({Name = "Auto Kaitun (Max Account)", CurrentValue = _G.Settings.Main["Auto Kaitun"], Callback = function(v) _G.Settings.Main["Auto Kaitun"] = v end}, "AutoKaitun")
MainTab:CreateToggle({Name = "Auto Farm Level", CurrentValue = _G.Settings.Main["Auto Farm Level"], Callback = function(v) _G.Settings.Main["Auto Farm Level"] = v end}, "AutoFarmLevel")
MainTab:CreateToggle({Name = "Auto Farm Skip (Lv 1-100)", CurrentValue = _G.Settings.Main["Fast Auto Farm Level"], Callback = function(v) _G.Settings.Main["Fast Auto Farm Level"] = v end}, "FastAutoFarm")
-- Auto Farm Bone Removed
MainTab:CreateToggle({Name = "Auto Elite Hunter", CurrentValue = _G.Settings.Main["Auto Elite Hunter"], Callback = function(v) _G.Settings.Main["Auto Elite Hunter"] = v end}, "AutoEliteHunter")

MainTab:CreateSection("Mastery Control")
MainTab:CreateToggle({Name = "Auto Farm Mastery", CurrentValue = _G.Settings.Main["Auto Farm Mastery"], Callback = function(v) _G.Settings.Main["Auto Farm Mastery"] = v end}, "AutoFarmMastery")
MainTab:CreateDropdown({
    Name = "Mastery Weapon",
    Options = {"Melee", "Sword", "Blox Fruit", "Gun"},
    CurrentOption = {_G.Settings.Main["Mastery Weapon"]},
    Callback = function(v)
        _G.Settings.Main["Mastery Weapon"] = unwrapOption(v)
    end
}, "MasteryWeapon")
MainTab:CreateSlider({Name = "Mastery HP %", Range = {5, 80}, Increment = 5, CurrentValue = _G.Settings.Main["Mastery Health Threshold"], Callback = function(v) _G.Settings.Main["Mastery Health Threshold"] = v end}, "MasteryHP")

MainTab:CreateSection("Combat & Aura")
MainTab:CreateToggle({Name = "Fast Attack", CurrentValue = _G.Settings.Configs["Fast Attack"], Callback = function(v) _G.Settings.Configs["Fast Attack"] = v end}, "FastAttack")
MainTab:CreateToggle({Name = "Mob Aura", CurrentValue = _G.Settings.Main["Mob Aura"], Callback = function(v) _G.Settings.Main["Mob Aura"] = v end}, "MobAura")
MainTab:CreateSlider({Name = "Aura Distance", Range = {50, 1500}, Increment = 25, CurrentValue = _G.Settings.Main["Distance Mob Aura"], Callback = function(v) _G.Settings.Main["Distance Mob Aura"] = v end}, "AuraDistance")
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Blox Fruit"},
    CurrentOption = {_G.Settings.Configs["Select Weapon"]},
    Callback = function(v)
        _G.Settings.Configs["Select Weapon"] = unwrapOption(v)
    end
}, "SelectWeapon")

MainTab:CreateSection("Safety")
MainTab:CreateToggle({Name = "Safe Mode", CurrentValue = false, Callback = function(v) 
    _G.SafeMode = v 
end}, "SafeMode")
MainTab:CreateSlider({Name = "Safe Health %", Range = {10, 90}, Increment = 5, CurrentValue = 30, Callback = function(v) 
    _G.SafeHealth = v 
end}, "SafeHealth")

MainTab:CreateSection("Looting")
MainTab:CreateToggle({Name = "Auto Farm Chest", CurrentValue = _G.Settings.Main["Auto Farm Chest"], Callback = function(v)
    _G.Settings.Main["Auto Farm Chest"] = v
end}, "AutoFarmChest")
MainTab:CreateToggle({Name = "Chest Tp ", CurrentValue = _G.Settings.Main["Chest Bypass"], Callback = function(v)
    _G.Settings.Main["Chest Bypass"] = v
end}, "ChestBypass")
MainTab:CreateToggle({Name = "Hop When No more chests", CurrentValue = _G.Settings.Main["Chest Hop When Dry"], Callback = function(v)
    _G.Settings.Main["Chest Hop When Dry"] = v
end}, "ChestHop")
MainTab:CreateSlider({Name = "Chest Hop Delay", Range = {5, 30}, Increment = 1, CurrentValue = _G.Settings.Main["Chest Hop Delay"], Callback = function(v)
    _G.Settings.Main["Chest Hop Delay"] = v
end}, "ChestHopDelay")
MainTab:CreateToggle({Name = "Stop On Chalice/Fist", CurrentValue = _G.Settings.Main["Stop Chest On Rare"], Callback = function(v)
    _G.Settings.Main["Stop Chest On Rare"] = v
end}, "StopChestRare")


local StatsTab = Window:CreateTab({Name = "Stats", Icon = GetIcon("Stats"), ImageSource = "Custom", ShowTitle = true})
StatsTab:CreateToggle({Name = "Auto Stats", CurrentValue = _G.Settings.Stats["Enabled Auto Stats"], Callback = function(v) _G.Settings.Stats["Enabled Auto Stats"] = v end}, "AutoStats")
StatsTab:CreateDropdown({
    Name = "Select Stat",
    Options = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"},
    CurrentOption = {_G.Settings.Stats["Select Stats"]},
    Callback = function(v)
        _G.Settings.Stats["Select Stats"] = unwrapOption(v)
    end
}, "SelectStat")
StatsTab:CreateSlider({Name = "Points per Loop", Range = {1, 100}, Increment = 1, CurrentValue = _G.Settings.Stats["Point Select"], Callback = function(v) _G.Settings.Stats["Point Select"] = v end}, "PointsSelect")



local FruitTab = Window:CreateTab({Name = "Fruits", Icon = GetIcon("Fruit"), ImageSource = "Custom", ShowTitle = true})
FruitTab:CreateSection("Sniper")
FruitTab:CreateDropdown({
    Name = "Select Fruit",
    Options = FruitOptions,
    CurrentOption = {_G.Settings.Fruit["Selected Sniper Fruit"]},
    Callback = function(v)
        _G.Settings.Fruit["Selected Sniper Fruit"] = unwrapOption(v)
    end
}, "SniperFruit")
FruitTab:CreateToggle({Name = "Auto Buy From Sniper", CurrentValue = _G.Settings.Fruit["Auto Buy From Sniper"], Callback = function(v)
    _G.Settings.Fruit["Auto Buy From Sniper"] = v
end}, "AutoBuyFruit")

FruitTab:CreateSection("Inventory")
FruitTab:CreateToggle({Name = "Auto Store Fruits", CurrentValue = _G.Settings.Fruit["Auto Store Fruits"], Callback = function(v)
    _G.Settings.Fruit["Auto Store Fruits"] = v
end}, "AutoStoreFruit")
FruitTab:CreateDropdown({
    Name = "Select Eat Fruit",
    Options = FruitOptions,
    CurrentOption = {_G.Settings.Fruit["Selected Eat Fruit"]},
    Callback = function(v)
        _G.Settings.Fruit["Selected Eat Fruit"] = unwrapOption(v)
    end
}, "EatFruitSelection")
FruitTab:CreateToggle({Name = "Auto Eat Selected Fruit", CurrentValue = _G.Settings.Fruit["Auto Eat Fruit"], Callback = function(v)
    _G.Settings.Fruit["Auto Eat Fruit"] = v
end}, "AutoEatFruit")

FruitTab:CreateSection("World Fruits")
FruitTab:CreateToggle({Name = "Bring To Nearest Fruit", CurrentValue = _G.Settings.Fruit["Bring To Fruit"], Callback = function(v)
    _G.Settings.Fruit["Bring To Fruit"] = v
    if v then _G.Settings.Fruit["Tween To Fruit"] = false end
end}, "BringFruit")
FruitTab:CreateToggle({Name = "Tween To Nearest Fruit", CurrentValue = _G.Settings.Fruit["Tween To Fruit"], Callback = function(v)
    _G.Settings.Fruit["Tween To Fruit"] = v
    if v then _G.Settings.Fruit["Bring To Fruit"] = false end
end}, "TweenFruit")

local RaidTab = Window:CreateTab({Name = "Raid", Icon = GetIcon("Raid"), ImageSource = "Custom", ShowTitle = true})
RaidTab:CreateToggle({Name = "Auto Start Raid", CurrentValue = _G.Settings.Raid["Auto Start Raid"], Callback = function(v) _G.Settings.Raid["Auto Start Raid"] = v end}, "AutoStartRaid")
RaidTab:CreateToggle({Name = "Auto Buy Chip", CurrentValue = _G.Settings.Raid["Auto Buy Chip"], Callback = function(v) _G.Settings.Raid["Auto Buy Chip"] = v end}, "AutoBuyChip")
RaidTab:CreateDropdown({
    Name = "Select Chip",
    Options = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Dough"},
    CurrentOption = {_G.Settings.Raid["Select Chip"]},
    Callback = function(v)
        _G.Settings.Raid["Select Chip"] = unwrapOption(v)
    end
}, "SelectChip")
RaidTab:CreateToggle({Name = "Auto Awaken", CurrentValue = _G.Settings.Raid["Auto Awaken"], Callback = function(v) _G.Settings.Raid["Auto Awaken"] = v end}, "AutoAwaken")



local ESPTab = Window:CreateTab({Name = "ESP", Icon = GetIcon("ESP"), ImageSource = "Custom", ShowTitle = true})
ESPTab:CreateSection("Visual Helpers")
ESPTab:CreateToggle({Name = "Player ESP", CurrentValue = _G.Settings.ESP["Player ESP"], Callback = function(v) 
    _G.Settings.ESP["Player ESP"] = v 
    ESPPlayer = v
end}, "PlayerESP")
ESPTab:CreateToggle({Name = "Chest ESP", CurrentValue = _G.Settings.ESP["Chest ESP"], Callback = function(v) 
    _G.Settings.ESP["Chest ESP"] = v 
    ChestESP = v
end}, "ChestESP")
ESPTab:CreateToggle({Name = "Fruit ESP", CurrentValue = _G.Settings.ESP["Fruit ESP"], Callback = function(v) 
    _G.Settings.ESP["Fruit ESP"] = v 
    DevilFruitESP = v
    RealFruitESP = v
end}, "FruitESP")
ESPTab:CreateToggle({Name = "Flower ESP", CurrentValue = _G.Settings.ESP["Flower ESP"], Callback = function(v) 
    _G.Settings.ESP["Flower ESP"] = v 
    FlowerESP = v
end}, "FlowerESP")
ESPTab:CreateToggle({Name = "Island ESP", CurrentValue = false, Callback = function(v) 
    IslandESP = v
end}, "IslandESP")
ESPTab:CreateToggle({Name = "Raid ESP", CurrentValue = _G.Settings.ESP["Raid ESP"], Callback = function(v) _G.Settings.ESP["Raid ESP"] = v end}, "RaidESP")

local BossTab = Window:CreateTab({Name = "Boss", Icon = GetIcon("Raid"), ImageSource = "Custom", ShowTitle = true})
BossTab:CreateSection("Boss Farm")

local BossList = {}
if World1 then
    BossList = {"The Saw", "The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Saber Expert"}
elseif World2 then
    BossList = {"Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain", "Darkbeard", "Order", "Awakened Ice Admiral", "Tide Keeper"}
elseif World3 then
    BossList = {"Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "rip_indra True Form", "Longma", "Soul Reaper", "Cake Queen", "Cake Prince", "Dough King"}
else
    BossList = {"None"}
end

BossTab:CreateDropdown({
    Name = "Select Boss",
    Options = BossList,
    CurrentOption = {BossList[1] or "None"},
    Callback = function(v)
        _G.SelectBoss = unwrapOption(v)
    end
}, "SelectBoss")

BossTab:CreateToggle({
    Name = "Auto Farm Boss",
    CurrentValue = false,
    Callback = function(v)
        _G.FarmBoss = v
        if not v then StopTween() end
    end
}, "AutoFarmBoss")

BossTab:CreateToggle({
    Name = "Auto Farm All Bosses",
    CurrentValue = false,
    Callback = function(v)
        _G.FarmAllBosses = v
        if not v then StopTween() end
    end
}, "AutoFarmAllBosses")

local TravelTab = Window:CreateTab({Name = "Travel", Icon = GetIcon("Travel"), ImageSource = "Custom", ShowTitle = true})
TravelTab:CreateSection("World Travel")
TravelTab:CreateButton({Name = "Travel to Sea 1", Callback = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain") end})
TravelTab:CreateButton({Name = "Travel to Sea 2", Callback = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa") end})
TravelTab:CreateButton({Name = "Travel to Sea 3", Callback = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou") end})

TravelTab:CreateSection("Island Teleport")
local IslandList = {}
if World1 then
    IslandList = {
        "WindMill", "Marine", "Middle Town", "Jungle", "Pirate Village", "Desert", "Snow Island", 
        "MarineFord", "Colosseum", "Sky Island 1", "Sky Island 2", "Sky Island 3", "Prison", 
        "Magma Village", "Under Water Island", "Fountain City", "Shank Room", "Mob Island"
    }
elseif World2 then
    IslandList = {
        "The Cafe", "Frist Spot", "Dark Area", "Flamingo Mansion", "Flamingo Room", "Green Zone", 
        "Factory", "Colossuim", "Zombie Island", "Two Snow Mountain", "Hot & Cold", "Punk Hazard", 
        "Cursed Ship", "Ice Castle", "Forgotten Island", "Ussop Island", "Mini Sky Island"
    }
elseif World3 then
    IslandList = {
        "Mansion", "Port Town", "Great Tree", "Castle On The Sea", "MiniSky", "Hydra Island", 
        "Floating Turtle", "Haunted Castle", "Ice Cream Island", "Peanut Island", "Cake Island", 
        "Room Enma/Yama & Secret Temple", "Room Tushita", "Tiki Outpost", "Dragon Gojo"
    }
else
    IslandList = {"None"}
end

TravelTab:CreateDropdown({
    Name = "Select Island",
    Options = IslandList,
    CurrentOption = {table.find(IslandList, _G.Settings.Teleport["Select Island"]) and _G.Settings.Teleport["Select Island"] or IslandList[1]},
    Callback = function(v)
        _G.Settings.Teleport["Select Island"] = unwrapOption(v)
    end
}, "SelectIsland")

TravelTab:CreateToggle({
    Name = "Teleport to Selected Island",
    CurrentValue = false,
    Callback = function(v)
        _G.TeleportIsland = v
        if not v then StopTween() end
    end
}, "TeleportIsland")

-- Logic Loops
task.spawn(function()
    while task.wait(0.1) do
        if _G.SafeMode then
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if hum and root and hum.Health > 0 then
                    local max = hum.MaxHealth
                    local pct = (hum.Health / max) * 100
                    if pct < (_G.SafeHealth or 30) then
                        -- Retreat
                        local safePos = root.CFrame * CFrame.new(0, 400, 0)
                        while _G.SafeMode and hum.Health > 0 and (hum.Health / max) * 100 < (_G.SafeHealth or 30) do
                            TP2(safePos)
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if _G.FarmAllBosses then
            pcall(function()
                -- Iterate through the BossList for the current world
                for _, bossName in ipairs(BossList) do
                    if not _G.FarmAllBosses then break end
                    
                    local boss = workspace.Enemies:FindFirstChild(bossName)
                    if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and boss:FindFirstChild("HumanoidRootPart") then
                        -- Farm this boss until dead or disabled
                        repeat
                            task.wait()
                            EquipWeapon(_G.Settings.Configs["Select Weapon"])
                            
                            -- Lock Enemy
                            boss.HumanoidRootPart.CanCollide = false
                            boss.Humanoid.WalkSpeed = 0
                            boss.HumanoidRootPart.Anchored = true
                            
                            -- TP and Attack
                            TP2(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            
                            -- Use Fast Attack if available
                            if FastAttack and _G.Settings.Configs["Fast Attack"] then
                                FastAttack:AttackNearest()
                            end
                            
                        until not _G.FarmAllBosses or not boss.Parent or boss.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if _G.FarmBoss then
            pcall(function()
                if not _G.SelectBoss or _G.SelectBoss == "" then return end
                
                local boss = workspace.Enemies:FindFirstChild(_G.SelectBoss) or ReplicatedStorage:FindFirstChild(_G.SelectBoss)
                
                if boss then
                    if boss.Parent == ReplicatedStorage then
                        -- Boss is stored, TP to spawn location (approximate)
                        -- For now, we can't easily know the spawn location without a table.
                        -- But redzhub logic tries to TP to it.
                        -- Let's just wait for it to spawn or use the stored model's position if it has one (unlikely to be correct if stored).
                        -- Actually redzhub uses a hardcoded offset or just waits.
                        -- Let's try to find it in workspace.
                    elseif boss.Parent == workspace.Enemies then
                         if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and boss:FindFirstChild("HumanoidRootPart") then
                            repeat
                                task.wait()
                                EquipWeapon(_G.Settings.Configs["Select Weapon"])
                                boss.HumanoidRootPart.CanCollide = false
                                boss.Humanoid.WalkSpeed = 0
                                TP2(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                -- Attack logic here if needed, or rely on Auto Farm Level's attack loop if active?
                                -- We need an attack loop.
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            until not _G.FarmBoss or not boss.Parent or boss.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if _G.TeleportIsland then
            local selected = _G.Settings.Teleport["Select Island"]
            if selected and selected ~= "" then
                local TP = TP2
                 if selected == "WindMill" then TP(CFrame.new(979.79895, 16.516613, 1429.04663))
                elseif selected == "Marine" then TP(CFrame.new(-2566.42969, 6.85566807, 2045.2561))
                elseif selected == "Middle Town" then TP(CFrame.new(-690.330811, 15.0942516, 1582.23804))
                elseif selected == "Jungle" then TP(CFrame.new(-1612.79578, 36.8520813, 149.128433))
                elseif selected == "Pirate Village" then TP(CFrame.new(-1181.30933, 4.75204945, 3803.54565))
                elseif selected == "Desert" then TP(CFrame.new(944.157898, 20.9197292, 4373.30029))
                elseif selected == "Snow Island" then TP(CFrame.new(1347.80676, 104.66806, -1319.73706))
                elseif selected == "MarineFord" then TP(CFrame.new(-4914.82129, 50.9636269, 4281.02783))
                elseif selected == "Colosseum" then TP(CFrame.new(-1427.62036, 7.28810787, -2792.77222))
                elseif selected == "Sky Island 1" then TP(CFrame.new(-4867.90723, 716.368591, -2615.68555))
                elseif selected == "Sky Island 2" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
                elseif selected == "Sky Island 3" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                elseif selected == "Prison" then TP(CFrame.new(4875.33008, 5.65198183, 734.85022))
                elseif selected == "Magma Village" then TP(CFrame.new(-5247.71631, 12.883934, 8504.96875))
                elseif selected == "Under Water Island" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                elseif selected == "Fountain City" then TP(CFrame.new(5127.12842, 59.5013657, 4085.69116))
                elseif selected == "Shank Room" then TP(CFrame.new(-1442.16553, 29.8788261, -28.3094482))
                elseif selected == "Mob Island" then TP(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
                elseif selected == "The Cafe" then TP(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
                elseif selected == "Frist Spot" then TP(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
                elseif selected == "Dark Area" then TP(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
                elseif selected == "Flamingo Mansion" then TP(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234))
                elseif selected == "Flamingo Room" then TP(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688))
                elseif selected == "Green Zone" then TP(CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
                elseif selected == "Factory" then TP(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
                elseif selected == "Colossuim" then TP(CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
                elseif selected == "Zombie Island" then TP(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094))
                elseif selected == "Two Snow Mountain" then TP(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
                elseif selected == "Hot & Cold" then TP(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
                elseif selected == "Punk Hazard" then TP(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
                elseif selected == "Cursed Ship" then TP(CFrame.new(923.40197753906, 125.05712890625, 32885.875))
                elseif selected == "Ice Castle" then TP(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
                elseif selected == "Forgotten Island" then TP(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
                elseif selected == "Ussop Island" then TP(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
                elseif selected == "Mini Sky Island" then TP(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
                elseif selected == "Mansion" then TP(CFrame.new(-12471.169921875, 374.94024658203, -7551.677734375))
                elseif selected == "Port Town" then TP(CFrame.new(-1575.56433, 37.8238907, -12416.2529))
                elseif selected == "Great Tree" then TP(CFrame.new(2953.328369140625, 2282.010009765625, -7214.51611328125))
                elseif selected == "Castle On The Sea" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5080.81787109375, 314.5812072753906, -3003.600830078125))
                elseif selected == "MiniSky" then TP(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
                elseif selected == "Hydra Island" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5627.6005859375, 1082.473876953125, -300.69598388671875))
                elseif selected == "Floating Turtle" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
                elseif selected == "Haunted Castle" then TP(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
                elseif selected == "Ice Cream Island" then TP(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625))
                elseif selected == "Peanut Island" then TP(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
                elseif selected == "Cake Island" then TP(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
                elseif selected == "Room Enma/Yama & Secret Temple" then TP(CFrame.new(5227.9052734375, 8.119736671447754, 1100.832275390625))
                elseif selected == "Room Tushita" then TP(CFrame.new(5174.83447265625, 141.81944274902344, 911.4637451171875))
                elseif selected == "Tiki Outpost" then TP(CFrame.new(-16899.6133, 9.31711292, 492.155396))
                elseif selected == "Dragon Gojo" then TP(CFrame.new(5785.18115234375, 1359.7843017578125, 908.6729736328125))
                end
            end
        end
    end
end)

local SettingsTab = Window:CreateTab({Name = "Settings", Icon = GetIcon("Settings"), ImageSource = "Custom", ShowTitle = true})
SettingsTab:CreateSection("Utilities")
SettingsTab:CreateButton({Name = "Server Hop", Callback = function() ServerHop() end})
SettingsTab:CreateButton({Name = "Stop Tween (Emergency)", Callback = function() StopTween() end})
SettingsTab:CreateSection("Display & Teams")
SettingsTab:CreateToggle({Name = "FPS Boost (White Screen)", CurrentValue = _G.Settings.Configs["White Screen"], Callback = function(v)
    _G.Settings.Configs["White Screen"] = v
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
    
    if v then
        -- Aggressive FPS Boost
        pcall(function()
            local decals = workspace:GetDescendants()
            for _, obj in ipairs(decals) do
                if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter") then
                    obj.Transparency = 1
                end
            end
            settings().Rendering.QualityLevel = 1
            workspace.Terrain.WaterWaveSize = 0
            workspace.Terrain.WaterWaveSpeed = 0
            workspace.Terrain.WaterReflectance = 0
            workspace.Terrain.WaterTransparency = 0
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 9e9
        end)
    end
end}, "WhiteScreen")
SettingsTab:CreateToggle({Name = "Auto Select Team", CurrentValue = _G.Settings.Teams["Auto Select Team"], Callback = function(v)
    _G.Settings.Teams["Auto Select Team"] = v
    if v then AutoChooseTeam() end
end}, "AutoSelectTeam")
SettingsTab:CreateDropdown({
    Name = "Preferred Team",
    Options = {"Pirates", "Marines"},
    CurrentOption = {table.find({"Pirates", "Marines"}, _G.Settings.Teams["Preferred Team"]) and _G.Settings.Teams["Preferred Team"] or "Pirates"},
    Callback = function(v)
        _G.Settings.Teams["Preferred Team"] = unwrapOption(v)
        AutoChooseTeam()
    end
}, "PreferredTeam")

SettingsTab:CreateSection("Anti-Cheat")
SettingsTab:CreateToggle({Name = "Auto Hop (Anti-Cheat)", CurrentValue = _G.Settings.AntiCheat["Auto Hop"], Callback = function(v)
    _G.Settings.AntiCheat["Auto Hop"] = v
end}, "AutoHopAntiCheat")
SettingsTab:CreateSlider({Name = "Hop Timer (Minutes)", Range = {10, 120}, Increment = 1, CurrentValue = _G.Settings.AntiCheat["Hop Timer"], Callback = function(v)
    _G.Settings.AntiCheat["Hop Timer"] = v
end}, "HopTimer")

SettingsTab:CreateSection("Webhook")
SettingsTab:CreateInput({Name = "Webhook URL", Placeholder = "https://discord.com/api/webhooks/...", CurrentValue = _G.Settings.Webhook["Url"], Callback = function(v)
    _G.Settings.Webhook["Url"] = v
end}, "WebhookUrl")
SettingsTab:CreateToggle({Name = "Enable Webhook", CurrentValue = _G.Settings.Webhook["Enabled"], Callback = function(v)
    _G.Settings.Webhook["Enabled"] = v
    if v then SendWebhook("Webhook Enabled", "Webhook notifications have been enabled.") end
end}, "EnableWebhook")
SettingsTab:CreateToggle({Name = "Notify on Level Up", CurrentValue = _G.Settings.Webhook["OnLevelUp"], Callback = function(v)
    _G.Settings.Webhook["OnLevelUp"] = v
end}, "WebhookLevelUp")
SettingsTab:CreateToggle({Name = "Notify on Rare Item", CurrentValue = _G.Settings.Webhook["OnRareItem"], Callback = function(v)
    _G.Settings.Webhook["OnRareItem"] = v
end}, "WebhookRareItem")
SettingsTab:CreateSlider({Name = "Stats Interval (Min)", Range = {1, 60}, Increment = 1, CurrentValue = _G.Settings.Webhook["Interval"] or 10, Callback = function(v)
    _G.Settings.Webhook["Interval"] = v
end}, "WebhookInterval")

SettingsTab:BuildThemeSection()
SettingsTab:BuildConfigSection()

Luna:LoadAutoloadConfig()

-- Webhook Listeners
task.spawn(function()
    if not LocalPlayer:FindFirstChild("Data") or not LocalPlayer.Data:FindFirstChild("Level") then return end
    local lastLevel = LocalPlayer.Data.Level.Value
    LocalPlayer.Data.Level.Changed:Connect(function(newLevel)
        if newLevel > lastLevel then
            lastLevel = newLevel
            if _G.Settings.Webhook["OnLevelUp"] then
                SendWebhook("Level Up!", "You have reached level " .. newLevel .. "!", 65280)
            end
        end
    end)
end)

task.spawn(function()
    local function onItemAdded(child)
        if _G.Settings.Webhook["OnRareItem"] then
             if child:IsA("Tool") and (string.find(child.Name, "Fruit") or string.find(child.Name, "Key") or string.find(child.Name, "Chalice")) then
                SendWebhook("Rare Item Obtained", "You found: " .. child.Name, 16776960)
             end
        end
    end
    
    LocalPlayer.Backpack.ChildAdded:Connect(onItemAdded)
    if LocalPlayer.Character then
        LocalPlayer.Character.ChildAdded:Connect(onItemAdded)
    end
    LocalPlayer.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(onItemAdded)
    end)
end)

-- Webhook Stats Loop
task.spawn(function()
    while task.wait(60) do
        if _G.Settings.Webhook["Enabled"] and _G.Settings.Webhook["Url"] ~= "" then
            local interval = _G.Settings.Webhook["Interval"] or 10
            -- Check if enough time passed (simple counter or os.time check could be better, but sleep loop is fine for now)
            -- Actually, the loop waits 60s, so we need a counter.
            
            if not _G.WebhookTimer then _G.WebhookTimer = 0 end
            _G.WebhookTimer = _G.WebhookTimer + 1
            
            if _G.WebhookTimer >= interval then
                _G.WebhookTimer = 0
                
                local level = LocalPlayer.Data.Level.Value
                local beli = LocalPlayer.Data.Beli.Value
                local frags = LocalPlayer.Data.Fragments.Value
                local devilFruit = LocalPlayer.Data.DevilFruit.Value
                
                local inventory = "None"
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                if backpack then
                    local items = {}
                    for _, item in ipairs(backpack:GetChildren()) do
                        if item:IsA("Tool") and (string.find(item.Name, "Fruit") or string.find(item.Name, "Key")) then
                            table.insert(items, item.Name)
                        end
                    end
                    if #items > 0 then inventory = table.concat(items, ", ") end
                end
                
                local fields = {
                    {name = "Level", value = tostring(level), inline = true},
                    {name = "Beli", value = formatNumber(beli), inline = true},
                    {name = "Fragments", value = formatNumber(frags), inline = true},
                    {name = "Current Fruit", value = tostring(devilFruit), inline = true},
                    {name = "Rare Inventory", value = inventory, inline = false}
                }
                
                SendWebhook("Account Stats", "Current status report:", 3447003, fields)
            end
        end
    end
end)

-- [[ ESP Features from Matsune ]]
local ESPPlayer = false
local ChestESP = false
local DevilFruitESP = false
local FlowerESP = false
local IslandESP = false
local RealFruitESP = false
local Number = math.random(1, 1000000)

local function round(n)
    return math.floor(tonumber(n) + 0.5)
end

local function isnil(thing)
    return (thing == nil)
end

function UpdateIslandESP() 
    for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then 
                if v.Name ~= "Sea" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = "GothamSemibold"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 255, 255)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end

function UpdatePlayerChams()
    for i,v in pairs(game:GetService'Players':GetChildren()) do
        pcall(function()
            if not isnil(v.Character) then
                if ESPPlayer then
                    if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v.Character.Head)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v.Character.Head
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance')
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if v.Team == game.Players.LocalPlayer.Team then
                            name.TextColor3 = Color3.new(0,255,0)
                        else
                            name.TextColor3 = Color3.new(255,0,0)
                        end
                    else
                        v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
                    end
                else
                    if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                        v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end
            end
        end)
    end
end

function UpdateChestESP()
    for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        pcall(function()
            if ChestESP then
                if not chest:GetAttribute("IsDisabled") then
                    if not chest:FindFirstChild("ChestEsp") then
                        local bill = Instance.new("BillboardGui", chest)
                        bill.Name = "ChestEsp"
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = chest
                        bill.AlwaysOnTop = true
                        local name = Instance.new("TextLabel", bill)
                        name.Font = "Code"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = "Top"
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 215, 0)
                    else
                        local distance = round((game:GetService("Players").LocalPlayer.Character.Head.Position - chest:GetPivot().Position).Magnitude / 3)
                        chest["ChestEsp"].TextLabel.Text = ("Chest\n" .. distance .. " M")
                    end
                end
            else
                if chest:FindFirstChild("ChestEsp") then
                    chest:FindFirstChild("ChestEsp"):Destroy()
                end
            end
        end)
    end
end

function UpdateDevilChams() 
    for i,v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(v.Name, "Fruit") then   
                    if not v.Handle:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v.Handle)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v.Handle
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 255, 255)
                        name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
                    else
                        v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v.Handle:FindFirstChild('NameEsp'..Number) then
                    v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end)
    end
end

function UpdateFlowerChams() 
    for i,v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if v.Name == "Flower2" or v.Name == "Flower1" then
                if FlowerESP then 
                    if not v:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if v.Name == "Flower1" then 
                            name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                            name.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if v.Name == "Flower2" then
                            name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                            name.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                else
                    if v:FindFirstChild('NameEsp'..Number) then
                    v:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end
            end   
        end)
    end
end

-- ESP Loop
task.spawn(function()
    while task.wait(1) do
        UpdateIslandESP()
        UpdatePlayerChams()
        UpdateChestESP()
        UpdateDevilChams()
        UpdateFlowerChams()
    end
end)
