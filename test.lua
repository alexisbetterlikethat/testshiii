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

-- Quest Database (Simplified for brevity, assumes full list exists or can be expanded)
local QuestDatabase = {
    {Level = 1, Quest = "BanditQuest1", QuestNum = 1, NPCPos = CFrame.new(1059.37, 15.45, 1550.42), Mob = "Bandit"},
    {Level = 15, Quest = "JungleQuest", QuestNum = 2, NPCPos = CFrame.new(-1598.09, 35.55, 153.38), Mob = "Gorilla"},
    -- Add more quests here as needed...
    {Level = 2000, Quest = "HauntedQuest1", QuestNum = 2, NPCPos = CFrame.new(-9479.22, 141.22, 5566.09), Mob = "Living Zombie"},
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
                    fireclickdetector(button.Button.Main.ClickDetector)
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

Luna:LoadAutoloadConfig()
