local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Window = Luna:CreateWindow({
    Name = "Aero Hub",
    Subtitle = "Blox Fruits (Ultimate)",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "Aero Hub",
    LoadingSubtitle = "Loading Ultimate Script...",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroHub-BloxFruits-Ultimate"
    },
    KeySystem = false
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
    local Tween = TweenService:Create(RootPart, TweenInfo, {CFrame = targetCFrame})
    
    if Character:FindFirstChild("Humanoid") then Character.Humanoid.Sit = true end
    
    Tween:Play()
    return Tween
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
                        toTarget(targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                        local mainWeapon = GetWeaponByType(_G.Settings.Configs["Select Weapon"])
                        if mainWeapon then EquipWeapon(mainWeapon) end
                        if _G.Settings.Configs["Auto Haki"] and not LocalPlayer.Character:FindFirstChild("HasBuso") then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                        end
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
                    toTarget(target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                    local mainWeapon = GetWeaponByType(_G.Settings.Configs["Select Weapon"])
                    if mainWeapon then EquipWeapon(mainWeapon) end
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
                    toTarget(target.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
                    local weapon = GetWeaponByType(_G.Settings.Configs["Select Weapon"])
                    if weapon then EquipWeapon(weapon) end
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
                            toTarget(target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            local mainWeapon = GetWeaponByType(_G.Settings.Configs["Select Weapon"])
                            if mainWeapon then EquipWeapon(mainWeapon) end
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
local MainTab = Window:CreateTab({Name = "Main", Icon = "home", ImageSource = "Material", ShowTitle = true})

MainTab:CreateSection("Farming")
MainTab:CreateToggle({Name = "Auto Farm Level", CurrentValue = false, Callback = function(v) _G.Settings.Main["Auto Farm Level"] = v end}, "AutoFarmLevel")
MainTab:CreateToggle({Name = "Auto Farm Bone", CurrentValue = false, Callback = function(v) _G.Settings.Main["Auto Farm Bone"] = v end}, "AutoFarmBone")
MainTab:CreateToggle({Name = "Auto Elite Hunter", CurrentValue = false, Callback = function(v) _G.Settings.Main["Auto Elite Hunter"] = v end}, "AutoEliteHunter")
MainTab:CreateToggle({Name = "Auto Farm Chest", CurrentValue = false, Callback = function(v) _G.Settings.Main["Auto Farm Chest"] = v end}, "AutoFarmChest")

MainTab:CreateSection("Combat")
MainTab:CreateToggle({Name = "Fast Attack", CurrentValue = true, Callback = function(v) _G.Settings.Configs["Fast Attack"] = v end}, "FastAttack")
MainTab:CreateDropdown({Name = "Select Weapon", Options = {"Melee", "Sword", "Blox Fruit"}, CurrentValue = "Melee", Callback = function(v) _G.Settings.Configs["Select Weapon"] = v end}, "SelectWeapon")

local StatsTab = Window:CreateTab({Name = "Stats", Icon = "bar_chart", ImageSource = "Material", ShowTitle = true})
StatsTab:CreateToggle({Name = "Auto Stats", CurrentValue = false, Callback = function(v) _G.Settings.Stats["Enabled Auto Stats"] = v end}, "AutoStats")
StatsTab:CreateDropdown({Name = "Select Stat", Options = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"}, CurrentValue = "Melee", Callback = function(v) _G.Settings.Stats["Select Stats"] = v end}, "SelectStat")
StatsTab:CreateSlider({Name = "Points per Loop", Range = {1, 100}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.Settings.Stats["Point Select"] = v end}, "PointsSelect")

local MaterialsTab = Window:CreateTab({Name = "Materials", Icon = "widgets", ImageSource = "Material", ShowTitle = true})
MaterialsTab:CreateToggle({Name = "Auto Farm Material", CurrentValue = false, Callback = function(v) _G.Settings.Materials["Auto Farm Material"] = v end}, "AutoFarmMaterial")
MaterialsTab:CreateDropdown({Name = "Select Material", Options = MaterialOptions, CurrentValue = _G.Settings.Materials["Select Material"], Callback = function(v) _G.Settings.Materials["Select Material"] = v end}, "SelectMaterial")

local BonesTab = Window:CreateTab({Name = "Bones", Icon = "ad_units", ImageSource = "Material", ShowTitle = true})
BonesTab:CreateToggle({Name = "Auto Random Bone", CurrentValue = false, Callback = function(v) _G.Settings.Bones["Auto Random Bone"] = v end}, "AutoRandomBone")

local RaidTab = Window:CreateTab({Name = "Raid", Icon = "security", ImageSource = "Material", ShowTitle = true})
RaidTab:CreateToggle({Name = "Auto Start Raid", CurrentValue = false, Callback = function(v) _G.Settings.Raid["Auto Start Raid"] = v end}, "AutoStartRaid")
RaidTab:CreateToggle({Name = "Auto Buy Chip", CurrentValue = false, Callback = function(v) _G.Settings.Raid["Auto Buy Chip"] = v end}, "AutoBuyChip")
RaidTab:CreateDropdown({Name = "Select Chip", Options = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Dough"}, CurrentValue = "Flame", Callback = function(v) _G.Settings.Raid["Select Chip"] = v end}, "SelectChip")
RaidTab:CreateToggle({Name = "Auto Awaken", CurrentValue = false, Callback = function(v) _G.Settings.Raid["Auto Awaken"] = v end}, "AutoAwaken")

local MiscTab = Window:CreateTab({Name = "Misc", Icon = "settings", ImageSource = "Material", ShowTitle = true})
MiscTab:CreateButton({Name = "Server Hop", Callback = function() ServerHop() end})
MiscTab:CreateToggle({Name = "White Screen", CurrentValue = false, Callback = function(v) 
    _G.Settings.Configs["White Screen"] = v 
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
end}, "WhiteScreen")
MiscTab:CreateToggle({Name = "Auto Select Team", CurrentValue = true, Callback = function(v)
    _G.Settings.Teams["Auto Select Team"] = v
    if v then AutoChooseTeam() end
end}, "AutoSelectTeam")
MiscTab:CreateDropdown({Name = "Preferred Team", Options = {"Pirates", "Marines"}, CurrentValue = _G.Settings.Teams["Preferred Team"], Callback = function(v)
    _G.Settings.Teams["Preferred Team"] = v
    AutoChooseTeam()
end}, "PreferredTeam")
MiscTab:CreateButton({Name = "Stop Tween (Emergency)", Callback = function()
    StopTween()
end})

Luna:LoadAutoloadConfig()
