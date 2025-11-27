local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/master/source.lua"))()

local Window = Luna:CreateWindow({
    Name = "Aero Hub",
    Subtitle = "Blox Fruits",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "Aero Hub",
    LoadingSubtitle = "Loading Blox Fruits Script...",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "AeroHub-BloxFruits"
    },
    KeySystem = false
})

-- Global Settings (Preserving structure from provided code for compatibility)
_G.Settings = {
    Main = {
        ["Auto Farm Level"] = false,
        ["Fast Auto Farm Level"] = false,
        ["Distance Mob Aura"] = 1000,
        ["Mob Aura"] = false,
    },
    Configs = {
        ["Fast Attack"] = true,
        ["Fast Attack Type"] = "Fast",
        ["Select Weapon"] = "Melee",
        ["Auto Haki"] = true,
        ["Bypass TP"] = true,
    },
    Stats = {
        ["Enabled Auto Stats"] = false,
        ["Select Stats"] = "Melee",
        ["Point Select"] = 3,
    },
    Teleport = {
        ["Teleport to Sea Beast"] = false,
    },
    Fruits = {
        ["Auto Store Fruits"] = true,
        ["Auto Fruit Finder"] = false,
    }
}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Anti-Cheat Bypass
local function BypassAntiCheat()
    local Network = game:GetService("NetworkClient")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Disable common anti-cheat remotes (Generic approach)
    local function DisableRemote(remoteName)
        local remote = ReplicatedStorage:FindFirstChild(remoteName)
        if remote then
            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                remote.Name = "DisabledRemote_" .. remoteName
            end
        end
    end

    -- Specific to some games, generic protection
    DisableRemote("Adonis_Client") 
    DisableRemote("Adonis_UI")
    
    -- Noclip to prevent physics-based kick
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

-- Helper Functions (Adapted from provided code)
local function toTarget(targetPos)
    if not targetPos then return end
    if type(targetPos) == "CFrame" then targetPos = targetPos.Position end
    if type(targetPos) == "Vector3" then targetPos = CFrame.new(targetPos) end

    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local RootPart = Character.HumanoidRootPart
    local Distance = (targetPos.Position - RootPart.Position).Magnitude
    
    -- Safe Tween Logic
    local BaseSpeed = 300
    if Distance < 250 then BaseSpeed = 600 end
    
    -- Dynamic speed adjustment based on distance to look more natural
    local Speed = BaseSpeed
    if Distance > 1000 then Speed = 350 end 

    local TweenInfo = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    local Tween = TweenService:Create(RootPart, TweenInfo, {CFrame = targetPos})
    
    -- Bypass: Sit to prevent some physics checks
    if Character:FindFirstChild("Humanoid") then
        Character.Humanoid.Sit = true
    end
    
    Tween:Play()
    
    -- Optional: Wait for completion if needed, or return tween object
    return Tween
end

-- Fast Attack Logic
local CombatFramework = require(LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]

local function CurrentWeapon()
	local ac = CombatFrameworkR.activeController
	local ret = ac.blades[1]
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	pcall(function()
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
	end)
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	return ret
end

local function AttackFunction()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		local bladehit = {} -- Simplified for now
        -- Logic to find enemies would go here
        
		if #bladehit > 0 or true then -- Force attack for now
            -- Simplified attack logic to avoid complex upvalue manipulation which might break
             if ac.hitboxMagnitude ~= 60 then
                ac.hitboxMagnitude = 60
            end
            ac:attack()
            game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
            game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
		end
	end
end

-- Comprehensive Quest Database (Phase 1)
local QuestDatabase = {
    -- First Sea
    {Level = 1, Quest = "BanditQuest1", QuestNum = 1, NPCPos = CFrame.new(1059.37, 15.45, 1550.42), Mob = "Bandit"},
    {Level = 10, Quest = "JungleQuest", QuestNum = 1, NPCPos = CFrame.new(-1598.08, 36.85, 153.38), Mob = "Monkey"},
    {Level = 15, Quest = "BuggyQuest1", QuestNum = 1, NPCPos = CFrame.new(-1140.46, 4.13, 3829.09), Mob = "Pirate"},
    {Level = 30, Quest = "DesertQuest", QuestNum = 1, NPCPos = CFrame.new(894.49, 5.14, 4392.27), Mob = "Desert Bandit"},
    {Level = 60, Quest = "SnowQuest", QuestNum = 1, NPCPos = CFrame.new(1389.74, 87.27, -1298.91), Mob = "Snowman"},
    {Level = 90, Quest = "MarineQuest2", QuestNum = 1, NPCPos = CFrame.new(-5039.58, 28.19, 4325.45), Mob = "Chief Petty Officer"},
    {Level = 100, Quest = "SnowMountainQuest", QuestNum = 1, NPCPos = CFrame.new(607.05, 401.44, -5370.57), Mob = "Snow Trooper"},
    {Level = 120, Quest = "IceSideQuest", QuestNum = 1, NPCPos = CFrame.new(-6059.96, 15.25, -4904.24), Mob = "Winter Warrior"},
    {Level = 150, Quest = "PrisonQuest", QuestNum = 1, NPCPos = CFrame.new(5308.93, 1.64, 472.87), Mob = "Prisoner"},
    {Level = 190, Quest = "ColoseumQuest", QuestNum = 1, NPCPos = CFrame.new(-1819.69, 7.38, -2982.03), Mob = "Gladiator"},
    
    -- Second Sea
    {Level = 700, Quest = "Area1Quest", QuestNum = 1, NPCPos = CFrame.new(-424.18, 73.04, 1835.17), Mob = "Raider"},
    {Level = 775, Quest = "Area2Quest", QuestNum = 1, NPCPos = CFrame.new(-2411.81, 73.05, -2823.15), Mob = "Mercenary"},
    {Level = 850, Quest = "MarineQuest3", QuestNum = 1, NPCPos = CFrame.new(-2440.79, 73.04, -3726.82), Mob = "Marine Lieutenant"},
    {Level = 950, Quest = "FountainQuest", QuestNum = 1, NPCPos = CFrame.new(5259.81, 38.53, 4050.45), Mob = "Pirate Millionaire"},
    
    -- Third Sea
    {Level = 1500, Quest = "PiratePortQuest", QuestNum = 1, NPCPos = CFrame.new(-290.40, 43.77, 5578.55), Mob = "Pirate"},
    {Level = 1575, Quest = "AmazonQuest2", QuestNum = 1, NPCPos = CFrame.new(5249.27, 38.28, -2234.69), Mob = "Isle Champion"},
    {Level = 1700, Quest = "MarineTreeIsland", QuestNum = 1, NPCPos = CFrame.new(2179.98, 28.73, -6739.62), Mob = "Marine Commodore"},
    {Level = 2000, Quest = "DeepForestIsland", QuestNum = 1, NPCPos = CFrame.new(-13234.04, 332.40, -7625.40), Mob = "Reborn Skeleton"},
    {Level = 2200, Quest = "IceCreamIsland", QuestNum = 1, NPCPos = CFrame.new(-819.01, 65.95, -10965.17), Mob = "Ice Cream Commander"},
}

local function GetQuestData(level)
    local bestQuest = nil
    for _, questData in ipairs(QuestDatabase) do
        if level >= questData.Level then
            bestQuest = questData
        else
            break
        end
    end
    return bestQuest
end

local function GetClosestEnemy(mobName)
    local closest = nil
    local minDistance = math.huge
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not myPos then return nil end
    
    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
        if enemy.Name == mobName and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
            local distance = (enemy.HumanoidRootPart.Position - myPos).Magnitude
            if distance < minDistance then
                minDistance = distance
                closest = enemy
            end
        end
    end
    return closest
end

-- Stuck Detection
local LastPosition = nil
local StuckTimer = 0
local function IsStuck()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local currentPos = LocalPlayer.Character.HumanoidRootPart.Position
    if LastPosition and (currentPos - LastPosition).Magnitude < 2 then
        StuckTimer = StuckTimer + 1
        if StuckTimer > 10 then -- Stuck for 10 checks (~10 seconds)
            StuckTimer = 0
            return true
        end
    else
        StuckTimer = 0
    end
    LastPosition = currentPos
    return false
end

-- Enhanced Auto Farm Loop (Phase 1)
task.spawn(function()
    while task.wait() do
        if _G.Settings.Main["Auto Farm Level"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local level = LocalPlayer.Data.Level.Value
            local questData = GetQuestData(level)
            
            if not questData then 
                task.wait(5)
                continue 
            end
            
            -- Auto-accept quest
            local hasQuest = LocalPlayer.PlayerGui.Main.Quest.Visible
            local questTitle = LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
            
            if not hasQuest or not questTitle:find(questData.Mob) then
                -- Navigate to quest giver
                local distanceToNPC = (LocalPlayer.Character.HumanoidRootPart.Position - questData.NPCPos.Position).Magnitude
                
                if distanceToNPC > 20 then
                    toTarget(questData.NPCPos)
                else
                    -- Accept quest
                    pcall(function()
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questData.Quest, questData.QuestNum)
                    end)
                    task.wait(0.5)
                end
            else
                -- Farm mobs
                local targetEnemy = GetClosestEnemy(questData.Mob)
                
                if targetEnemy then
                    -- Stuck detection
                    if IsStuck() then
                        warn("Stuck detected! Retrying...")
                        LocalPlayer.Character.HumanoidRootPart.CFrame = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 50, 30)
                        task.wait(1)
                        continue
                    end
                    
                    -- Move to enemy
                    local targetCFrame = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                    toTarget(targetCFrame)
                    
                    -- Auto Buso Haki
                    if _G.Settings.Configs["Auto Haki"] and not LocalPlayer.Character:FindFirstChild("HasBuso") then
                        pcall(function()
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                        end)
                    end
                    
                    -- Attack
                    if _G.Settings.Configs["Fast Attack"] then
                        pcall(AttackFunction)
                    end
                else
                    -- No enemies alive, wait at spawn
                    toTarget(questData.NPCPos * CFrame.new(0, 50, 0))
                    task.wait(2)
                end
            end
        end
    end
end)

-- UI Construction

-- Main Tab
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "home",
    ImageSource = "Material"
})

MainTab:CreateSection("Farming")

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        _G.Settings.Main["Auto Farm Level"] = Value
    end
}, "AutoFarmLevel")

MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Fruit"},
    CurrentOption = {"Melee"},
    Callback = function(Option)
        _G.Settings.Configs["Select Weapon"] = Option
    end
}, "SelectWeapon")

MainTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = true,
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
    end
}, "FastAttack")

MainTab:CreateDropdown({
    Name = "Fast Attack Speed",
    Options = {"Fast", "Normal", "Slow"},
    CurrentOption = {"Fast"},
    Callback = function(Option)
        _G.Settings.Configs["Fast Attack Type"] = Option
    end
}, "FastAttackSpeed")

-- Stats Tab
local StatsTab = Window:CreateTab({
    Name = "Stats",
    Icon = "bar_chart",
    ImageSource = "Material"
})

StatsTab:CreateToggle({
    Name = "Auto Stats",
    CurrentValue = false,
    Callback = function(Value)
        _G.Settings.Stats["Enabled Auto Stats"] = Value
    end
}, "AutoStats")

StatsTab:CreateDropdown({
    Name = "Select Stat",
    Options = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"},
    CurrentOption = {"Melee"},
    Callback = function(Option)
        _G.Settings.Stats["Select Stats"] = Option
    end
}, "SelectStat")

-- Fruits Tab (Fruit Finder)
local FruitsTab = Window:CreateTab({
    Name = "Fruits",
    Icon = "eco", -- Leaf/Fruit icon
    ImageSource = "Material"
})

FruitsTab:CreateToggle({
    Name = "Auto Store Fruits",
    CurrentValue = true,
    Callback = function(Value)
        _G.Settings.Fruits["Auto Store Fruits"] = Value
    end
}, "AutoStoreFruits")

FruitsTab:CreateToggle({
    Name = "Fruit Finder (Teleport)",
    CurrentValue = false,
    Callback = function(Value)
        _G.Settings.Fruits["Auto Fruit Finder"] = Value
    end
}, "FruitFinder")

-- Fruit Finder Logic
task.spawn(function()
    while task.wait(1) do
        if _G.Settings.Fruits["Auto Fruit Finder"] then
            for _, v in ipairs(workspace:GetChildren()) do
                if v:IsA("Tool") and v.Name:find("Fruit") then
                     if v:FindFirstChild("Handle") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v.Handle, 1)
                     end
                elseif v:IsA("Model") and (v.Name == "Fruit" or v.Name == "fruit") then
                     -- Handle model fruits
                     local base = v:FindFirstChildWhichIsA("BasePart")
                     if base then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = base.CFrame
                     end
                end
            end
        end
        
        if _G.Settings.Fruits["Auto Store Fruits"] then
             for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if tool.Name:find("Fruit") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool:GetAttribute("OriginalName"), tool)
                end
            end
            for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
                if tool.Name:find("Fruit") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool:GetAttribute("OriginalName"), tool)
                end
            end
        end
    end
end)

-- ESP Logic
local ESP = {
    Enabled = false,
    Boxes = false,
    Tracers = false,
    Names = false,
    FruitESP = false,
    ChestESP = false,
    Color = Color3.fromRGB(255, 0, 0)
}

local function CreateESP(target, text, color)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "ESP"
    BillboardGui.Adornee = target.HumanoidRootPart
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = text
    TextLabel.TextColor3 = color
    TextLabel.TextStrokeTransparency = 0
    
    BillboardGui.Parent = target.HumanoidRootPart
    return BillboardGui
end

local function UpdateESP()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if ESP.Enabled then
                if not v.Character.HumanoidRootPart:FindFirstChild("ESP") then
                    CreateESP(v.Character, v.Name, ESP.Color)
                end
            else
                if v.Character.HumanoidRootPart:FindFirstChild("ESP") then
                    v.Character.HumanoidRootPart.ESP:Destroy()
                end
            end
        end
    end
    
    if ESP.FruitESP then
        for _, v in ipairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v.Name:find("Fruit") and v:FindFirstChild("Handle") then
                if not v.Handle:FindFirstChild("ESP") then
                    local b = CreateESP(v, v.Name, Color3.fromRGB(0, 255, 0))
                    if b then b.Adornee = v.Handle end
                end
            end
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        UpdateESP()
    end
end)

-- Teleport Logic
local function TeleportToPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        toTarget(targetPlayer.Character.HumanoidRootPart.CFrame)
    end
end

-- UI Construction (Continued)

-- Auto Raid Logic
local Raid = {
    AutoRaid = false,
    AutoBuyChip = false,
    SelectedRaid = "Flame",
    AutoAwaken = true,
    NextIsland = false
}

local RaidList = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"}

local function BuyChip()
    if Raid.SelectedRaid then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", Raid.SelectedRaid)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Buy")
    end
end

local function AutoRaidLoop()
    while task.wait() do
        if Raid.AutoRaid then
            -- Check if in Raid (simplified check, usually map is different or specific UI exists)
            local enemies = workspace.Enemies:GetChildren()
            local raidEnemies = {}
            
            for _, v in ipairs(enemies) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    table.insert(raidEnemies, v)
                end
            end
            
            if #raidEnemies > 0 then
                -- Kill Enemies
                for _, v in ipairs(raidEnemies) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                        if _G.Settings.Configs["Fast Attack"] then
                            AttackFunction()
                        end
                        if not Raid.AutoRaid then break end
                    end
                end
            else
                -- No enemies, find next island or awaken
                -- This is a simplified "Next Island" logic. 
                -- Real scripts often use specific CFrame offsets or look for the next spawn point.
                -- For now, we will try to find the "Next Island" indicator if it exists, or just wait.
                
                -- Auto Awaken at the end
                if Raid.AutoAwaken then
                     ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
                end
            end
        end
        
        if Raid.AutoBuyChip then
            -- Simple check to buy chip if not in raid and no chip in inventory
            -- (Requires more robust check in full version)
            BuyChip()
            task.wait(5) -- Cooldown
        end
    end
end

task.spawn(AutoRaidLoop)

-- UI Construction (Continued)

-- Raid Tab
local RaidTab = Window:CreateTab({
    Name = "Raid",
    Icon = "token",
    ImageSource = "Material"
})

RaidTab:CreateDropdown({
    Name = "Select Raid",
    Options = RaidList,
    CurrentOption = {"Flame"},
    Callback = function(Option)
        Raid.SelectedRaid = Option
    end
}, "SelectRaid")

RaidTab:CreateToggle({
    Name = "Auto Buy Chip",
    CurrentValue = false,
    Callback = function(Value)
        Raid.AutoBuyChip = Value
    end
}, "AutoBuyChip")

RaidTab:CreateToggle({
    Name = "Auto Raid (Kill Aura)",
    CurrentValue = false,
    Callback = function(Value)
        Raid.AutoRaid = Value
    end
}, "AutoRaid")

RaidTab:CreateToggle({
    Name = "Auto Awaken",
    CurrentValue = true,
    Callback = function(Value)
        Raid.AutoAwaken = Value
    end
}, "AutoAwaken")

RaidTab:CreateButton({
    Name = "Teleport to Lab (Start)",
    Callback = function()
        -- Teleport to Hot and Cold Lab (approximate coordinates)
        toTarget(CFrame.new(-5000, 300, -5000)) -- Placeholder coords, user might need to adjust or we find exact
    end
})

-- Visuals Tab (Existing)
local VisualsTab = Window:CreateTab({
    Name = "Visuals",
    Icon = "visibility",
    ImageSource = "Material"
})

VisualsTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Callback = function(Value)
        ESP.Enabled = Value
        UpdateESP()
    end
}, "PlayerESP")

VisualsTab:CreateToggle({
    Name = "Fruit ESP",
    CurrentValue = false,
    Callback = function(Value)
        ESP.FruitESP = Value
        UpdateESP()
    end
}, "FruitESP")

-- Teleport Tab
local TeleportTab = Window:CreateTab({
    Name = "Teleport",
    Icon = "flight",
    ImageSource = "Material"
})

local PlayerDropdown = TeleportTab:CreateDropdown({
    Name = "Select Player",
    Options = {},
    CurrentOption = {""},
    Callback = function(Option)
        _G.SelectedPlayer = Option
    end
}, "SelectPlayer")

TeleportTab:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        if _G.SelectedPlayer then
            TeleportToPlayer(_G.SelectedPlayer)
        end
    end
})

TeleportTab:CreateButton({
    Name = "Refresh Players",
    Callback = function()
        local playerNames = {}
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                table.insert(playerNames, v.Name)
            end
        end
        PlayerDropdown:Refresh(playerNames)
    end
})

-- Misc Tab (Existing)
local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "settings",
    ImageSource = "Material"
})

MiscTab:CreateToggle({
    Name = "Auto Haki",
    CurrentValue = true,
    Callback = function(Value)
        _G.Settings.Configs["Auto Haki"] = Value
    end
}, "AutoHaki")

task.spawn(function()
    while task.wait(5) do
        if _G.Settings.Configs["Auto Haki"] then
            if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- Load Saved Config
Luna:LoadAutoloadConfig()
