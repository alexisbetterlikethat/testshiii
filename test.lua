local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Window = Luna:CreateWindow({
    Name = "Aero Hub",
    Subtitle = "Blox Fruits (Ultimate)",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "Aero Hub",
    LoadingSubtitle = "made with love...",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroHub-BloxFruits-Ultimate"
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
    DiscordInvite = "aerohub",
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
    Stats = "6034898096",
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
    return TabIcons[name] or TabIcons.Default
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
    if not targetPos then return end
    local targetCFrame
    if typeof(targetPos) == "CFrame" then targetCFrame = targetPos
    elseif typeof(targetPos) == "Vector3" then targetCFrame = CFrame.new(targetPos)
    else return end

    if targetCFrame.Position.Y < -50 then return end
    
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local RootPart = Character.HumanoidRootPart
    
    -- Smart Teleport Logic (Islands)
    local nearestTeleport = CheckNearestTeleporter(targetCFrame.Position)
    if nearestTeleport then
        RequestEntrance(nearestTeleport)
        task.wait(0.5)
        return 
    end

    local Distance = (targetCFrame.Position - RootPart.Position).Magnitude
    
    -- Optimization: Don't restart tween if target hasn't changed much
    if activeTween and activeTween.PlaybackState == Enum.PlaybackState.Playing and lastTweenTarget and (lastTweenTarget - targetCFrame.Position).Magnitude < 15 then
        return
    end

    local Speed = 350
    if Distance < 250 then Speed = 600 end
    
    if activeTween then
        activeTween:Cancel()
        activeTween = nil
    end

    local PartTele = Character:FindFirstChild("PartTele")
    if not PartTele then
        PartTele = Instance.new("Part")
        PartTele.Name = "PartTele"
        PartTele.Size = Vector3.new(10, 1, 10)
        PartTele.Transparency = 1
        PartTele.CanCollide = false
        PartTele.Anchored = true
        PartTele.CFrame = RootPart.CFrame
        PartTele.Parent = Character
        PartTele:GetPropertyChangedSignal("CFrame"):Connect(function()
            local currentChar = LocalPlayer.Character
            local currentRoot = currentChar and currentChar:FindFirstChild("HumanoidRootPart")
            if currentRoot then
                currentRoot.CFrame = PartTele.CFrame
                currentRoot.Velocity = Vector3.zero
            end
        end)
    end

    EnableNoclip()

    local tweenInfo = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    lastTweenTarget = targetCFrame.Position
    local Tween = TweenService:Create(PartTele, tweenInfo, {CFrame = targetCFrame})
    activeTween = Tween

    Tween.Completed:Connect(function(status)
        if status == Enum.PlaybackState.Completed and activeTween == Tween then
            activeTween = nil
            lastTweenTarget = nil
            DisableNoclip()
            if PartTele and PartTele.Parent then
                PartTele:Destroy()
            end
        end
    end)

    Tween:Play()
    return Tween
end

local function ApproachEnemy(enemy, hoverHeight)
    if not enemy then return end
    local hrp = enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    AnchorEnemy(enemy)
    
    local targetCFrame = hrp.CFrame * CFrame.new(0, hoverHeight or 30, 0)
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if myRoot and (myRoot.Position - targetCFrame.Position).Magnitude < 50 then
        myRoot.CFrame = targetCFrame
        myRoot.Velocity = Vector3.zero
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = true
        end
        -- Ensure HoldVelocity exists
        local bv = myRoot:FindFirstChild("HoldVelocity") or Instance.new("BodyVelocity")
        bv.Name = "HoldVelocity"
        bv.Parent = myRoot
        bv.MaxForce = Vector3.new(100000, 100000, 100000)
        bv.Velocity = Vector3.zero
    else
        toTarget(targetCFrame)
    end

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
        local d = (pos - targetPos).Magnitude
        if d < minDist then
            minDist = d
            bestTeleporter = pos
        end
    end

    if minDist < (targetPos - myPos).Magnitude then
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

-- TP2 Implementation (Pure Tween for Travel & Hover)
local currentTween = nil

function TP2(target)
    local targetCFrame = (typeof(target) == "Vector3" and CFrame.new(target)) or (typeof(target) == "CFrame" and target) or nil
    if not targetCFrame then return end
    
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    
    -- Check Teleporters (Only for long distances)
    if (hrp.Position - targetCFrame.Position).Magnitude > 500 then
        local teleporter = CheckNearestTeleporter(targetCFrame.Position)
        if teleporter then
            requestEntrance(teleporter)
            return -- Wait for teleport
        end
    end

    -- Create PartTele if needed
    if not LocalPlayer.Character:FindFirstChild("PartTele") then
        local p = Instance.new("Part", LocalPlayer.Character)
        p.Name = "PartTele"
        p.Size = Vector3.new(10, 1, 10)
        p.Anchored = true
        p.Transparency = 1
        p.CanCollide = false
        p.CFrame = hrp.CFrame
        
        -- Sync HRP to PartTele (Tween Lock)
        p:GetPropertyChangedSignal("CFrame"):Connect(function()
            if not p or not p.Parent then return end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.CFrame
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
                
                if LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.PlatformStand = true
                end
            end
        end)
    end
    
    local p = LocalPlayer.Character.PartTele
    local dist = (p.Position - targetCFrame.Position).Magnitude
    
    -- Speed Calculation
    local speed = 350
    if dist > 500 then speed = 500 end
    
    -- Minimum tween time for smoothness
    local tweenTime = dist / speed
    if tweenTime < 0.05 then tweenTime = 0.05 end
    
    -- Only start new tween if target changed significantly
    if (p.CFrame.Position - targetCFrame.Position).Magnitude > 1 then
        if currentTween then currentTween:Cancel() end
        local info = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
        currentTween = TweenService:Create(p, info, {CFrame = targetCFrame})
        currentTween:Play()
    end
end

-- Fast Attack (Optimized)
FastAttack = {
    Distance = 60,
    Enabled = false
}

local RegisterAttack
local RegisterHit

task.spawn(function()
    local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
    RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
    RegisterHit = Net:WaitForChild("RE/RegisterHit")
end)

function FastAttack:AttackNearest()
    if not RegisterAttack or not RegisterHit then return end
    
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local enemiesToHit = {}
    local baseEnemy = nil

    if workspace:FindFirstChild("Enemies") then
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                if (enemy.HumanoidRootPart.Position - myRoot.Position).Magnitude <= self.Distance then
                    table.insert(enemiesToHit, {enemy, enemy.HumanoidRootPart})
                    baseEnemy = enemy.HumanoidRootPart
                end
            end
        end
    end

    if #enemiesToHit > 0 and baseEnemy then
        RegisterAttack:FireServer(0)
        RegisterHit:FireServer(baseEnemy, enemiesToHit)
    end
end

-- Fast Attack Loop (Heartbeat for max speed)
RunService.Heartbeat:Connect(function()
    if _G.Settings.Configs["Fast Attack"] and LocalPlayer.Character then
        FastAttack:AttackNearest()
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
    warn("Aero Hub: GuideModule failed, using fallback database.")
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
            local parent = part.Parent
            local disabled = (part.GetAttribute and part:GetAttribute("IsDisabled"))
            if not disabled and parent and parent.GetAttribute then
                disabled = parent:GetAttribute("IsDisabled")
            end
            if disabled then return end
            local distance = (part.Position - root.Position).Magnitude
            local score = ScoreChest(part)
            local weight = score - (distance / 5000)
            if weight > bestWeight then
                bestWeight = weight
                best = part
            end
        end
    end
    for _, chest in ipairs(CollectionService:GetTagged("_ChestTagged")) do
        consider(chest)
    end
    local chestFolder = workspace:FindFirstChild("ChestModels")
    if chestFolder then
        for _, descendant in ipairs(chestFolder:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name:lower():find("chest") then
                consider(descendant)
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

local spawnIndex = 1

-- Auto Farm Level (Redz Logic - Re-implemented)
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
                        if LocalPlayer.Character.HumanoidRootPart.Anchored then LocalPlayer.Character.HumanoidRootPart.Anchored = false end
                        -- Abandon wrong quest
                        if questGui and questGui.Visible then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                            task.wait(0.5)
                            return
                        end

                        -- Go to Quest Giver
                        if (LocalPlayer.Character.HumanoidRootPart.Position - questData.NPCPos.Position).Magnitude > 20 then
                            TP2(questData.NPCPos)
                        else
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questData.Quest, questData.QuestNum)
                            task.wait(0.5)
                        end
                    else
                        -- Quest Active: Find and Kill
                        local targetName = questData.Mob
                        local enemy = nil
                        
                        -- Find closest living enemy
                        if workspace:FindFirstChild("Enemies") then
                            for _, v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == targetName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                    if not enemy or (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude then
                                        enemy = v
                                    end
                                end
                            end
                        end
                        
                        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                            -- Teleport to Enemy (Redz Logic: TP2)
                            local farmPos = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) -- Hover 30 studs above
                            
                            -- Always use TP2 for movement and hovering (Pure Tween)
                            if LocalPlayer.Character.HumanoidRootPart.Anchored then LocalPlayer.Character.HumanoidRootPart.Anchored = false end
                            TP2(farmPos)
                            
                            -- Magnet / Bring Mob Logic
                            if (enemy.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 60 then
                                -- Lock enemy in place
                                enemy.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -4, 0) -- Bring slightly below/front
                                enemy.HumanoidRootPart.CanCollide = false
                                enemy.Humanoid.WalkSpeed = 0
                                enemy.Humanoid.JumpPower = 0
                                if enemy.Humanoid:FindFirstChild("Animator") then enemy.Humanoid.Animator:Destroy() end
                                enemy.Humanoid:ChangeState(11) -- PlatformStand
                                
                                -- Bring other nearby mobs
                                for _, other in pairs(workspace.Enemies:GetChildren()) do
                                    if other.Name == targetName and other ~= enemy and other:FindFirstChild("HumanoidRootPart") and other:FindFirstChild("Humanoid") and other.Humanoid.Health > 0 then
                                        if (other.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 300 then
                                            other.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame
                                            other.HumanoidRootPart.CanCollide = false
                                            other.Humanoid.WalkSpeed = 0
                                            other.Humanoid:ChangeState(11)
                                        end
                                    end
                                end
                            end
                            
                            -- Attack
                            EquipPreferredWeapon()
                            EnsureHaki()
                            -- FastAttack is handled by the Heartbeat loop
                        else
                            -- No enemy found: Go to Spawn
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
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("PartTele") then
                LocalPlayer.Character.PartTele:Destroy()
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.PlatformStand = false
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
            if currentTween then currentTween:Cancel() end
            currentTween = nil
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

local currentChest = nil
local chestStart = 0

task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Chest"] then
            pcall(function()
                local chest = GetBestChest()
                
                -- Stuck Check Logic
                if chest then
                    if currentChest == chest then
                        if os.clock() - chestStart > 5 then -- Reduced to 5 seconds
                            ChestBlacklist[chest] = true
                            currentChest = nil
                            return
                        end
                    else
                        currentChest = chest
                        chestStart = os.clock()
                    end
                else
                    currentChest = nil
                end

                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if chest and root then
                    chestDryCounter = 0
                    local destination = CFrame.new(chest.Position + Vector3.new(0, 3, 0))
                    
                    -- Smarter Movement: Direct TP if close
                    if (root.Position - chest.Position).Magnitude < 50 then
                        root.CFrame = destination
                        root.Velocity = Vector3.zero
                    else
                        toTarget(destination)
                    end

                    if (root.Position - chest.Position).Magnitude < 15 and firetouchinterestFn then
                        firetouchinterestFn(root, chest, 0)
                        firetouchinterestFn(root, chest, 1)
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

-- Auto Farm Bone (Haunted Castle)
task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Bone"] then
            pcall(function()
                local mobs = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                local target = nil
                for _, mobName in ipairs(mobs) do
                    target = GetClosestEnemy(mobName)
                    if target then break end
                end
                
                if target then
                    ApproachEnemy(target, 30)
                else
                    -- Teleport to Haunted Castle spawn area if no mobs found
                    toTarget(CFrame.new(-9516.99, 172.02, 6078.47))
                end
            end)
        end
    end
end)

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
        if _G.Settings.Materials["Auto Farm Material"] then
            pcall(function()
                local selection = _G.Settings.Materials["Select Material"]
                local route = GetMaterialRoute(selection)
                if not route then return end
                local mobNames = {}
                for _, entry in ipairs(route) do
                    if entry.Mob then
                        table.insert(mobNames, entry.Mob)
                    end
                end
                local target = GetClosestEnemyFromList(mobNames)
                if target and target:FindFirstChild("HumanoidRootPart") then
                    ApproachEnemy(target, 25)
                else
                    local anchor = route[1]
                    if anchor then
                        if anchor.Spawn then SetSpawnPoint(anchor.Spawn) end
                        if anchor.Position then toTarget(anchor.Position) end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.Settings.Bones["Auto Random Bone"] then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
            end)
        end
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
-- Fast Auto Farm Removed
MainTab:CreateToggle({Name = "Auto Farm Bone", CurrentValue = _G.Settings.Main["Auto Farm Bone"], Callback = function(v) _G.Settings.Main["Auto Farm Bone"] = v end}, "AutoFarmBone")
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

MainTab:CreateSection("Looting")
MainTab:CreateToggle({Name = "Auto Farm Chest", CurrentValue = _G.Settings.Main["Auto Farm Chest"], Callback = function(v)
    _G.Settings.Main["Auto Farm Chest"] = v
end}, "AutoFarmChest")
MainTab:CreateToggle({Name = "Chest Bypass Pulse", CurrentValue = _G.Settings.Main["Chest Bypass"], Callback = function(v)
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

local MaterialsTab = Window:CreateTab({Name = "Materials", Icon = GetIcon("Materials"), ImageSource = "Custom", ShowTitle = true})
MaterialsTab:CreateToggle({Name = "Auto Farm Material", CurrentValue = _G.Settings.Materials["Auto Farm Material"], Callback = function(v) _G.Settings.Materials["Auto Farm Material"] = v end}, "AutoFarmMaterial")
MaterialsTab:CreateDropdown({
    Name = "Select Material",
    Options = MaterialOptions,
    CurrentOption = {_G.Settings.Materials["Select Material"]},
    Callback = function(v)
        _G.Settings.Materials["Select Material"] = unwrapOption(v)
    end
}, "SelectMaterial")

local BonesTab = Window:CreateTab({Name = "Bones", Icon = GetIcon("Bones"), ImageSource = "Custom", ShowTitle = true})
BonesTab:CreateToggle({Name = "Auto Random Bone", CurrentValue = _G.Settings.Bones["Auto Random Bone"], Callback = function(v) _G.Settings.Bones["Auto Random Bone"] = v end}, "AutoRandomBone")

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
ESPTab:CreateToggle({Name = "Player ESP", CurrentValue = _G.Settings.ESP["Player ESP"], Callback = function(v) _G.Settings.ESP["Player ESP"] = v end}, "PlayerESP")
ESPTab:CreateToggle({Name = "Chest ESP", CurrentValue = _G.Settings.ESP["Chest ESP"], Callback = function(v) _G.Settings.ESP["Chest ESP"] = v end}, "ChestESP")
ESPTab:CreateToggle({Name = "Fruit ESP", CurrentValue = _G.Settings.ESP["Fruit ESP"], Callback = function(v) _G.Settings.ESP["Fruit ESP"] = v end}, "FruitESP")
ESPTab:CreateToggle({Name = "Flower ESP", CurrentValue = _G.Settings.ESP["Flower ESP"], Callback = function(v) _G.Settings.ESP["Flower ESP"] = v end}, "FlowerESP")
ESPTab:CreateToggle({Name = "Raid ESP", CurrentValue = _G.Settings.ESP["Raid ESP"], Callback = function(v) _G.Settings.ESP["Raid ESP"] = v end}, "RaidESP")

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
    CurrentOption = {_G.Settings.Teams["Preferred Team"]},
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
