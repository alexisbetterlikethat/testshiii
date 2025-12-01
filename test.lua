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
    KeySystem = false
})

Window:CreateHomeTab({
    SupportedExecutors = {"Synapse Z", "Solara", "Fluxus", "Delta"},
    DiscordInvite = "aerohub",
    Icon = 1
})

-- Global Settings
_G.Settings = {
    Main = {
        ["Auto Farm Level"] = false,
        ["Fast Auto Farm Level"] = false,
        ["Distance Mob Aura"] = 1000,
        ["Mob Aura"] = false,
        ["Auto Farm Chest"] = false,
        ["Auto Farm Bone"] = false,
        ["Auto Elite Hunter"] = false,
        ["Auto Farm Mastery"] = false,
        ["Mastery Health Threshold"] = 25,
        ["Mastery Weapon"] = "Blox Fruit",
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
    }
}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local CurrentWorld = (game.PlaceId == 2753915549 and 1)
    or (game.PlaceId == 4442272183 and 2)
    or (game.PlaceId == 7449423635 and 3)
local fireclickdetectorFn = rawget(_G, "fireclickdetector")
local firetouchinterestFn = rawget(_G, "firetouchinterest")
local activeTween

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


local lastBasicAttack = 0
local function PerformBasicAttack()
    if os.clock() - lastBasicAttack < 0.12 then return end
    lastBasicAttack = os.clock()
    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
    local center = Vector2.new(viewport.X / 2, viewport.Y / 2)
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(center, camera and camera.CFrame or CFrame.new())
        task.delay(0.05, function()
            VirtualUser:Button1Up(center, camera and camera.CFrame or CFrame.new())
        end)
    end)
end

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
    local Distance = (targetCFrame.Position - RootPart.Position).Magnitude
    
    local Speed = 300
    if Distance < 250 then Speed = 600 end
    if Distance > 1000 then Speed = 350 end 

    local TweenInfo = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    if activeTween then activeTween:Cancel() end
    local Tween = TweenService:Create(RootPart, TweenInfo, {CFrame = targetCFrame})
    activeTween = Tween
    Tween.Completed:Connect(function()
        if activeTween == Tween then
            activeTween = nil
        end
    end)
    
    if Character:FindFirstChild("Humanoid") then Character.Humanoid.Sit = true end
    
    Tween:Play()
    return Tween
end

local function ApproachEnemy(enemy, hoverHeight)
    if not enemy then return end
    local hrp = enemy:FindFirstChild("HumanoidRootPart")
    local humanoid = enemy:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid or humanoid.Health <= 0 then return end
    AnchorEnemy(enemy)
    toTarget(hrp.CFrame * CFrame.new(0, hoverHeight or 30, 0))
    if EquipPreferredWeapon() then
        EnsureHaki()
        ReleaseSit()
        PerformBasicAttack()
    end
end

-- Fast Attack
local FastAttack = {Distance = 100}
local RegisterAttack = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
local RegisterHit = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")

function FastAttack:AttackNearest()
    local OthersEnemies = {}
    local BasePart = nil
    if workspace:FindFirstChild("Enemies") then
        for _, Enemy in pairs(workspace.Enemies:GetChildren()) do
            if Enemy:FindFirstChild("Head") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                if (Enemy.Head.Position - LocalPlayer.Character.Head.Position).Magnitude < self.Distance then
                    table.insert(OthersEnemies, {Enemy, Enemy.Head})
                    BasePart = Enemy.Head
                end
            end
        end
    end
    if #OthersEnemies > 0 and BasePart then
        RegisterAttack:FireServer(0)
        RegisterHit:FireServer(BasePart, OthersEnemies)
    end
end

task.spawn(function()
    while task.wait() do
        if _G.Settings.Configs["Fast Attack"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
            FastAttack:AttackNearest()
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if ShouldAutoClick() then
            local target = GetClosestActiveEnemy(90)
            if target then
                AnchorEnemy(target)
                if EquipPreferredWeapon() then
                    EnsureHaki()
                    ReleaseSit()
                    PerformBasicAttack()
                end
            end
        else
            task.wait(0.15)
        end
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
    local bestQuest = nil
    for _, questData in ipairs(QuestDatabase) do
        if level >= questData.Level then bestQuest = questData else break end
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

local function GetClosestEnemy(mobName)
    local closest, minDistance = nil, math.huge
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not myPos then return nil end
    if workspace:FindFirstChild("Enemies") then
        for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
            if enemy.Name == mobName and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
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

local function GetClosestChest()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, minDistance = nil, math.huge
    local function consider(part)
        if part and part:IsA("BasePart") then
            local parent = part.Parent
            local disabled = (part.GetAttribute and part:GetAttribute("IsDisabled"))
            if not disabled and parent and parent.GetAttribute then
                disabled = parent:GetAttribute("IsDisabled")
            end
            if disabled then return end
            local distance = (part.Position - root.Position).Magnitude
            if distance < minDistance then
                minDistance = distance
                closest = part
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
    return closest
end

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

-- Auto Farm Level
task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Level"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                local level = LocalPlayer.Data.Level.Value
                local questData = GetQuestData(level)
                if not questData then return end
                
                local hasQuest = false
                local questGui = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
                if questGui and questGui.Visible then hasQuest = true end

                if not hasQuest then
                    if (LocalPlayer.Character.HumanoidRootPart.Position - questData.NPCPos.Position).Magnitude > 10 then
                        toTarget(questData.NPCPos)
                    else
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questData.Quest, questData.QuestNum)
                        task.wait(0.5)
                    end
                else
                    local targetEnemy = GetClosestEnemy(questData.Mob)
                    if targetEnemy then
                        ApproachEnemy(targetEnemy, 28)
                    else
                        toTarget(questData.NPCPos * CFrame.new(0, 50, 0))
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if _G.Settings.Main["Auto Farm Chest"] then
            pcall(function()
                local chest = GetClosestChest()
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if chest and root then
                    toTarget(chest.CFrame)
                    if (root.Position - chest.Position).Magnitude < 10 and firetouchinterestFn then
                        firetouchinterestFn(root, chest, 0)
                        firetouchinterestFn(root, chest, 1)
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

-- Shop Automation
task.spawn(function()
    while task.wait(8) do
        if _G.Settings.Shop["Auto Random Fruit"] then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(6) do
        if _G.Settings.Shop["Auto Legendary Sword"] then
            pcall(function()
                for idx = 1, 3 do
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", tostring(idx))
                    task.wait(0.2)
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(10) do
        if _G.Settings.Shop["Auto Enhancement Color"] then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
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

-- Sea Event Automation
task.spawn(function()
    while task.wait(0.25) do
        if _G.Settings.Sea["Auto Sea Beast"] then
            pcall(function()
                local target = GetNearestModelWithRoot(workspace:FindFirstChild("SeaBeasts"))
                if target then
                    EngageSeaTarget(target, 95)
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if _G.Settings.Sea["Auto Terror Shark"] then
            pcall(function()
                local target = GetClosestEnemy("Terrorshark")
                if not target then
                    target = workspace:FindFirstChild("Terrorshark")
                end
                if target then
                    EngageSeaTarget(target, 70)
                end
            end)
        end
    end
end)

local SeaEnemyTargets = {
    ["Auto Sea Mobs"] = {"Shark", "Piranha", "Fish Crew Member", "Fish Crew", "Fishman Raider"},
    ["Auto Pirate Raid"] = {"Pirate Basic", "Pirate Captain", "Pirate Brute", "Pirate Admiral", "Fish Crew Member"},
}

for setting, mobList in pairs(SeaEnemyTargets) do
    task.spawn(function()
        while task.wait(0.25) do
            if _G.Settings.Sea[setting] then
                pcall(function()
                    local enemy = GetClosestEnemyFromList(mobList)
                    if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                        ApproachEnemy(enemy, 32)
                    end
                end)
            end
        end
    end)
end

local ESPColors = {
    Players = Color3.fromRGB(0, 170, 255),
    Chests = Color3.fromRGB(255, 221, 85),
    Fruits = Color3.fromRGB(85, 255, 127),
    Flowers = Color3.fromRGB(255, 105, 180),
    Raids = Color3.fromRGB(190, 115, 255)
}

local ESPObjects = {
    Players = {},
    Chests = {},
    Fruits = {},
    Flowers = {},
    Raids = {}
}

local FlowerNames = {
    ["Blue Flower"] = true,
    ["Red Flower"] = true,
    ["Pink Flower"] = true
}

local function cleanupCategory(category)
    for instance, highlight in pairs(ESPObjects[category]) do
        if highlight then highlight:Destroy() end
        ESPObjects[category][instance] = nil
    end
end

local function pruneCategory(category)
    for instance, highlight in pairs(ESPObjects[category]) do
        if not instance or not instance.Parent then
            if highlight then highlight:Destroy() end
            ESPObjects[category][instance] = nil
        end
    end
end

local function ensureHighlight(category, adornee, color)
    if not adornee or not adornee.Parent then return end
    local store = ESPObjects[category]
    local highlight = store[adornee]
    if not highlight or not highlight.Parent then
        highlight = Instance.new("Highlight")
        highlight.Name = "AeroHub" .. category .. "ESP"
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = adornee
        highlight.Parent = adornee:IsA("Model") and adornee or adornee.Parent or workspace
        store[adornee] = highlight
    end
    highlight.FillColor = color
    highlight.OutlineColor = color
end

local function updatePlayerESP()
    pruneCategory("Players")
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            ensureHighlight("Players", player.Character, ESPColors.Players)
        end
    end
end

local function updateChestESP()
    pruneCategory("Chests")
    for _, chest in ipairs(CollectionService:GetTagged("_ChestTagged")) do
        ensureHighlight("Chests", chest, ESPColors.Chests)
    end
end

local function updateFruitESP()
    pruneCategory("Fruits")
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("Tool") and descendant:FindFirstChild("Handle") and string.find(descendant.Name, "Fruit") then
            ensureHighlight("Fruits", descendant.Handle, ESPColors.Fruits)
        end
    end
end

local function updateFlowerESP()
    pruneCategory("Flowers")
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if FlowerNames[descendant.Name] and (descendant:IsA("Model") or descendant:IsA("BasePart")) then
            ensureHighlight("Flowers", descendant:IsA("Model") and descendant or descendant, ESPColors.Flowers)
        end
    end
end

local function updateRaidESP()
    pruneCategory("Raids")
    local origin = workspace:FindFirstChild("_WorldOrigin")
    local locations = origin and origin:FindFirstChild("Locations")
    if not locations then return end
    for _, loc in ipairs(locations:GetChildren()) do
        if loc:IsA("BasePart") and string.find(loc.Name:lower(), "island") then
            ensureHighlight("Raids", loc, ESPColors.Raids)
        end
    end
end

task.spawn(function()
    while task.wait(0.8) do
        if _G.Settings.ESP["Player ESP"] then updatePlayerESP() else cleanupCategory("Players") end
        if _G.Settings.ESP["Chest ESP"] then updateChestESP() else cleanupCategory("Chests") end
        if _G.Settings.ESP["Fruit ESP"] then updateFruitESP() else cleanupCategory("Fruits") end
        if _G.Settings.ESP["Flower ESP"] then updateFlowerESP() else cleanupCategory("Flowers") end
        if _G.Settings.ESP["Raid ESP"] then updateRaidESP() else cleanupCategory("Raids") end
    end
end)

-- Server Hop
local function ServerHop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    
    local function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        
        for _, v in pairs(Site.data) do
            local Possible = true
            local ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _, Existing in pairs(AllIDs) do
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                end
                if Possible then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
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

local MainTab = Window:CreateTab({Name = "Main", Icon = "home", ImageSource = "Material", ShowTitle = true})

MainTab:CreateSection("Farming")
MainTab:CreateToggle({Name = "Auto Farm Level", CurrentValue = _G.Settings.Main["Auto Farm Level"], Callback = function(v) _G.Settings.Main["Auto Farm Level"] = v end}, "AutoFarmLevel")
MainTab:CreateToggle({Name = "Auto Farm Bone", CurrentValue = _G.Settings.Main["Auto Farm Bone"], Callback = function(v) _G.Settings.Main["Auto Farm Bone"] = v end}, "AutoFarmBone")
MainTab:CreateToggle({Name = "Auto Elite Hunter", CurrentValue = _G.Settings.Main["Auto Elite Hunter"], Callback = function(v) _G.Settings.Main["Auto Elite Hunter"] = v end}, "AutoEliteHunter")
MainTab:CreateToggle({Name = "Auto Farm Chest", CurrentValue = _G.Settings.Main["Auto Farm Chest"], Callback = function(v) _G.Settings.Main["Auto Farm Chest"] = v end}, "AutoFarmChest")

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

local StatsTab = Window:CreateTab({Name = "Stats", Icon = "bar_chart", ImageSource = "Material", ShowTitle = true})
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

local ShopTab = Window:CreateTab({Name = "Shop", Icon = "shopping_cart", ImageSource = "Material", ShowTitle = true})
ShopTab:CreateSection("Automation")
ShopTab:CreateToggle({Name = "Auto Random Fruit", CurrentValue = _G.Settings.Shop["Auto Random Fruit"], Callback = function(v) _G.Settings.Shop["Auto Random Fruit"] = v end}, "AutoRandomFruitShop")
ShopTab:CreateToggle({Name = "Auto Legendary Sword", CurrentValue = _G.Settings.Shop["Auto Legendary Sword"], Callback = function(v) _G.Settings.Shop["Auto Legendary Sword"] = v end}, "AutoLegendarySword")
ShopTab:CreateToggle({Name = "Auto Enhancement Color", CurrentValue = _G.Settings.Shop["Auto Enhancement Color"], Callback = function(v) _G.Settings.Shop["Auto Enhancement Color"] = v end}, "AutoEnhancementColor")
ShopTab:CreateButton({Name = "Buy Random Fruit (Once)", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
end})
ShopTab:CreateButton({Name = "Buy Haki Color (Once)", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
end})

ShopTab:CreateSection("Fighting Styles")
local fightingStyles = {
    {label = "Black Leg", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg") end},
    {label = "Electro", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro") end},
    {label = "Water Kung Fu", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate") end},
    {label = "Dragon Claw", remote = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end},
    {label = "Superhuman", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman") end},
    {label = "Death Step", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDeathStep") end},
    {label = "Sharkman Karate", remote = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end},
    {label = "Electric Claw", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw") end},
    {label = "Dragon Talon", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon") end},
    {label = "God Human", remote = function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman") end},
    {label = "Sanguine Art", remote = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt", true)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt")
    end}
}
for _, entry in ipairs(fightingStyles) do
    ShopTab:CreateButton({Name = "Buy " .. entry.label, Callback = entry.remote})
end

ShopTab:CreateSection("Abilities & Utility")
ShopTab:CreateButton({Name = "Buy Geppo", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
end})
ShopTab:CreateButton({Name = "Buy Buso", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
end})
ShopTab:CreateButton({Name = "Buy Soru", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
end})
ShopTab:CreateButton({Name = "Buy Observation", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
end})

ShopTab:CreateSection("Legendary Rolls")
ShopTab:CreateButton({Name = "Legendary Sword Cycle", Callback = function()
    for idx = 1, 3 do
        ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", tostring(idx))
        task.wait(0.2)
    end
end})
ShopTab:CreateButton({Name = "Race Reroll", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
end})
ShopTab:CreateButton({Name = "Stat Refund", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
end})
ShopTab:CreateButton({Name = "Buy Black Cape", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
end})
ShopTab:CreateButton({Name = "Buy Swordsman Hat", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat")
end})
ShopTab:CreateButton({Name = "Buy Tomoe Ring", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring")
end})

local MaterialsTab = Window:CreateTab({Name = "Materials", Icon = "widgets", ImageSource = "Material", ShowTitle = true})
MaterialsTab:CreateToggle({Name = "Auto Farm Material", CurrentValue = _G.Settings.Materials["Auto Farm Material"], Callback = function(v) _G.Settings.Materials["Auto Farm Material"] = v end}, "AutoFarmMaterial")
MaterialsTab:CreateDropdown({
    Name = "Select Material",
    Options = MaterialOptions,
    CurrentOption = {_G.Settings.Materials["Select Material"]},
    Callback = function(v)
        _G.Settings.Materials["Select Material"] = unwrapOption(v)
    end
}, "SelectMaterial")

local BonesTab = Window:CreateTab({Name = "Bones", Icon = "ad_units", ImageSource = "Material", ShowTitle = true})
BonesTab:CreateToggle({Name = "Auto Random Bone", CurrentValue = _G.Settings.Bones["Auto Random Bone"], Callback = function(v) _G.Settings.Bones["Auto Random Bone"] = v end}, "AutoRandomBone")

local RaidTab = Window:CreateTab({Name = "Raid", Icon = "security", ImageSource = "Material", ShowTitle = true})
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

local TravelTab = Window:CreateTab({Name = "Travel", Icon = "travel_explore", ImageSource = "Material", ShowTitle = true})
TravelTab:CreateSection("Teleport")
TravelTab:CreateDropdown({
    Name = "Select Destination",
    Options = TravelOptions,
    CurrentOption = {_G.Settings.Teleport["Select Island"]},
    Callback = function(v)
        _G.Settings.Teleport["Select Island"] = unwrapOption(v)
    end
}, "SelectIsland")
TravelTab:CreateButton({Name = "Teleport", Callback = function()
    local selection = _G.Settings.Teleport["Select Island"]
    local cframe = TravelLookup[selection]
    if cframe then toTarget(cframe) end
end})

local SeaTab = Window:CreateTab({Name = "Sea", Icon = "waves", ImageSource = "Material", ShowTitle = true})
SeaTab:CreateSection("World Travel")
SeaTab:CreateButton({Name = "Travel to Sea 1", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
end})
SeaTab:CreateButton({Name = "Travel to Sea 2", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
end})
SeaTab:CreateButton({Name = "Travel to Sea 3", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
end})

SeaTab:CreateSection("Boats")
SeaTab:CreateDropdown({
    Name = "Select Boat",
    Options = BoatDropdownOptions,
    CurrentOption = {getBoatDisplayName(_G.Settings.Sea["Selected Boat"])},
    Callback = function(v)
        local display = unwrapOption(v)
        _G.Settings.Sea["Selected Boat"] = BoatDisplayLookup[display] or "PirateBrigade"
    end
}, "SelectBoat")
SeaTab:CreateButton({Name = "Buy Selected Boat", Callback = function()
    local boat = _G.Settings.Sea["Selected Boat"] or "PirateBrigade"
    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boat)
end})

SeaTab:CreateSection("Events")
SeaTab:CreateToggle({Name = "Auto Sea Beast", CurrentValue = _G.Settings.Sea["Auto Sea Beast"], Callback = function(v) _G.Settings.Sea["Auto Sea Beast"] = v end}, "AutoSeaBeast")
SeaTab:CreateToggle({Name = "Auto Terror Shark", CurrentValue = _G.Settings.Sea["Auto Terror Shark"], Callback = function(v) _G.Settings.Sea["Auto Terror Shark"] = v end}, "AutoTerrorShark")
SeaTab:CreateToggle({Name = "Auto Sea Mobs", CurrentValue = _G.Settings.Sea["Auto Sea Mobs"], Callback = function(v) _G.Settings.Sea["Auto Sea Mobs"] = v end}, "AutoSeaMobs")
SeaTab:CreateToggle({Name = "Auto Pirate Raid", CurrentValue = _G.Settings.Sea["Auto Pirate Raid"], Callback = function(v) _G.Settings.Sea["Auto Pirate Raid"] = v end}, "AutoPirateRaid")

local ESPTab = Window:CreateTab({Name = "ESP", Icon = "visibility", ImageSource = "Material", ShowTitle = true})
ESPTab:CreateSection("Visual Helpers")
ESPTab:CreateToggle({Name = "Player ESP", CurrentValue = _G.Settings.ESP["Player ESP"], Callback = function(v) _G.Settings.ESP["Player ESP"] = v end}, "PlayerESP")
ESPTab:CreateToggle({Name = "Chest ESP", CurrentValue = _G.Settings.ESP["Chest ESP"], Callback = function(v) _G.Settings.ESP["Chest ESP"] = v end}, "ChestESP")
ESPTab:CreateToggle({Name = "Fruit ESP", CurrentValue = _G.Settings.ESP["Fruit ESP"], Callback = function(v) _G.Settings.ESP["Fruit ESP"] = v end}, "FruitESP")
ESPTab:CreateToggle({Name = "Flower ESP", CurrentValue = _G.Settings.ESP["Flower ESP"], Callback = function(v) _G.Settings.ESP["Flower ESP"] = v end}, "FlowerESP")
ESPTab:CreateToggle({Name = "Raid ESP", CurrentValue = _G.Settings.ESP["Raid ESP"], Callback = function(v) _G.Settings.ESP["Raid ESP"] = v end}, "RaidESP")

local MiscTab = Window:CreateTab({Name = "Misc", Icon = "settings", ImageSource = "Material", ShowTitle = true})
MiscTab:CreateSection("Utilities")
MiscTab:CreateButton({Name = "Server Hop", Callback = function() ServerHop() end})
MiscTab:CreateButton({Name = "Stop Tween (Emergency)", Callback = function() StopTween() end})
MiscTab:CreateSection("Display & Teams")
MiscTab:CreateToggle({Name = "White Screen", CurrentValue = _G.Settings.Configs["White Screen"], Callback = function(v)
    _G.Settings.Configs["White Screen"] = v
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
end}, "WhiteScreen")
MiscTab:CreateToggle({Name = "Auto Select Team", CurrentValue = _G.Settings.Teams["Auto Select Team"], Callback = function(v)
    _G.Settings.Teams["Auto Select Team"] = v
    if v then AutoChooseTeam() end
end}, "AutoSelectTeam")
MiscTab:CreateDropdown({
    Name = "Preferred Team",
    Options = {"Pirates", "Marines"},
    CurrentOption = {_G.Settings.Teams["Preferred Team"]},
    Callback = function(v)
        _G.Settings.Teams["Preferred Team"] = unwrapOption(v)
        AutoChooseTeam()
    end
}, "PreferredTeam")

MiscTab:BuildThemeSection()
MiscTab:BuildConfigSection()

Luna:LoadAutoloadConfig()
