-- ts file was generated at discord.gg/25ms


print("Break")
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local vu1 = task
require(game.ReplicatedStorage.Util.CameraShaker):Stop()
if not LPH_OBFUSCATED then
    function LPH_JIT_MAX(...)
        return ...
    end
    function LPH_NO_VIRTUALIZE(...)
        return ...
    end
    function LPH_NO_UPVALUES(...)
        return ...
    end
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/obfalchx/edit/refs/heads/main/Module"))()
local v2, v3, v4 = pairs(getconnections(game:GetService("Players").LocalPlayer.Idled))
while true do
    local v5
    v4, v5 = v2(v3, v4)
    if v4 == nil then
        break
    end
    v5:Disable()
end
local v6 = loadstring(game:HttpGet("https://github.com/LuaCrack/Library/releases/download/Ui/FluentRedz1"))()
if game.PlaceId ~= 2753915549 then
    if game.PlaceId ~= 4442272183 then
        if game.PlaceId == 7449423635 then
            World3 = true
        end
    else
        World2 = true
    end
else
    World1 = true
end
Instance.new("Folder", workspace).Name = "EnemySpawns"
local v7, v8, v9 = pairs(workspace._WorldOrigin.EnemySpawns:GetChildren())
while true do
    local v10, v11 = v7(v8, v9)
    if v10 == nil then
        break
    end
    v9 = v10
    if v11:IsA("Part") then
        local v12 = v11:Clone()
        local v13 = string.gsub(v11.Name, "Lv. ", "")
        local v14 = string.gsub(v13, "[%[%]]", "")
        local v15 = string.gsub(v14, "%d+", "")
        v12.Name = string.gsub(v15, "%s+", "")
        v12.Parent = workspace.EnemySpawns
        v12.Anchored = true
    end
end
local v16, v17, v18 = pairs(game:GetService("Workspace").Enemies:GetChildren())
while true do
    local v19, v20 = v16(v17, v18)
    if v19 == nil then
        break
    end
    v18 = v19
    if v20:IsA("Model") and v20:FindFirstChild("HumanoidRootPart") then
        print(v20.HumanoidRootPart.Parent)
        local v21 = v20.HumanoidRootPart:Clone()
        local v22 = string.gsub(v20.Name, "Lv. ", "")
        local v23 = string.gsub(v22, "[%[%]]", "")
        local v24 = string.gsub(v23, "%d+", "")
        local v25 = string.gsub(v24, "%s+", "")
        print(v25)
        v21.Name = v25
        v21.Parent = workspace.EnemySpawns
        v21.Anchored = true
    end
end
local v26, v27, v28 = pairs(game.ReplicatedStorage:GetChildren())
while true do
    local v29, v30 = v26(v27, v28)
    if v29 == nil then
        break
    end
    v28 = v29
    if v30:IsA("Model") and v30:FindFirstChild("HumanoidRootPart") then
        local v31 = v30.HumanoidRootPart:Clone()
        local v32 = string.gsub(v30.Name, "Lv. ", "")
        local v33 = string.gsub(v32, "[%[%]]", "")
        local v34 = string.gsub(v33, "%d+", "")
        local v35 = string.gsub(v34, "%s+", "")
        print(v35)
        v31.Name = v35
        v31.Parent = workspace.EnemySpawns
        v31.Anchored = true
    end
end
local function vu87()
    local v36 = game:GetService("Players").LocalPlayer.Data.Level.Value
    if 1 <= v36 and v36 <= 9 then
        if tostring(game.Players.LocalPlayer.Team) ~= "Marines" then
            if tostring(game.Players.LocalPlayer.Team) == "Pirates" then
                MobName = "Bandit"
                Mon = "Bandit"
                QuestName = "BanditQuest1"
                QuestLevel = 1
                NPCPosition = CFrame.new(1059.99731, 16.9222069, 1549.28162, - 0.95466274, 7.29721794e-9, 0.297689587, 1.05190106e-8, 1, 9.22064114e-9, - 0.297689587, 1.19340022e-8, - 0.95466274)
            end
        else
            MobName = "Trainee"
            QuestName = "MarineQuest"
            QuestLevel = 1
            Mon = "Trainee"
            NPCPosition = CFrame.new(- 2709.67944, 24.5206585, 2104.24585, - 0.744724929, - 3.97967455e-8, - 0.667371571, 4.32403588e-8, 1, - 1.07884304e-7, 0.667371571, - 1.09201515e-7, - 0.744724929)
        end
        return {
            QuestLevel,
            NPCPosition,
            MobName,
            QuestName,
            LevelRequire,
            Mon,
            MobCFrame
        }
    end
    if 210 <= v36 and v36 <= 249 then
        MobName = "Dangerous Prisoner"
        QuestName = "PrisonerQuest"
        QuestLevel = 2
        Mon = "Dangerous Prisoner"
        NPCPosition = CFrame.new(5308.93115, 1.65517521, 475.120514, - 0.0894274712, - 5.00292918e-9, - 0.995993316, 1.60817859e-9, 1, - 5.16744869e-9, 0.995993316, - 2.06384709e-9, - 0.0894274712)
        local v37 = string.gsub(MobName, "Lv. ", "")
        local v38 = string.gsub(v37, "[%[%]]", "")
        local v39 = string.gsub(v38, "%d+", "")
        local v40 = string.gsub(v39, "%s+", "")
        local v41, v42, v43 = pairs(game.workspace.EnemySpawns:GetChildren())
        local v44 = {}
        while true do
            local v45
            v43, v45 = v41(v42, v43)
            if v43 == nil then
                break
            end
            if v45.Name == v40 then
                table.insert(v44, v45.CFrame)
            end
            MobCFrame = v44
        end
        return {
            QuestLevel,
            NPCPosition,
            MobName,
            QuestName,
            LevelRequire,
            Mon,
            MobCFrame
        }
    end
    local v46 = require(game:GetService("ReplicatedStorage").GuideModule)
    local v47 = require(game:GetService("ReplicatedStorage").Quests)
    local v48, v49, v50 = pairs(v46.Data.NPCList)
    while true do
        local v51
        v50, v51 = v48(v49, v50)
        if v50 == nil then
            break
        end
        local v52, v53, v54 = pairs(v51.Levels)
        local v55 = v50
        while true do
            local v56
            v54, v56 = v52(v53, v54)
            if v54 == nil then
                break
            end
            if v56 <= v36 then
                if not LevelRequire then
                    LevelRequire = 0
                end
                if LevelRequire < v56 then
                    NPCPosition = v55.CFrame
                    QuestLevel = v54
                    LevelRequire = v56
                end
                if # v51.Levels == 3 and QuestLevel == 3 then
                    NPCPosition = v55.CFrame
                    QuestLevel = 2
                    LevelRequire = v51.Levels[2]
                end
            end
        end
    end
    if 375 <= v36 and (v36 <= 399 and (_G.Level and (NPCPosition.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000)) then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
    end
    if 400 <= v36 and (v36 <= 449 and (_G.Level and (NPCPosition.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000)) then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
    end
    local v57, v58, v59 = pairs(v47)
    while true do
        local v60
        v59, v60 = v57(v58, v59)
        if v59 == nil then
            break
        end
        local v61, v62, v63 = pairs(v60)
        local v64 = v59
        while true do
            local v65
            v63, v65 = v61(v62, v63)
            if v63 == nil then
                break
            end
            if v65.LevelReq == LevelRequire and v64 ~= "CitizenQuest" then
                QuestName = v64
                local v66, v67, v68 = pairs(v65.Task)
                while true do
                    local v69
                    v68, v69 = v66(v67, v68)
                    if v68 == nil then
                        break
                    end
                    MobName = v68
                    Mon = string.split(v68, " [Lv. " .. v65.LevelReq .. "]")[1]
                end
            end
        end
    end
    if QuestName ~= "MarineQuest2" then
        if QuestName ~= "ImpelQuest" then
            if QuestName ~= "SkyExp1Quest" then
                if QuestName == "Area2Quest" and QuestLevel == 2 then
                    QuestName = "Area2Quest"
                    QuestLevel = 1
                    MobName = "Swan Pirate"
                    Mon = "Swan Pirate"
                    LevelRequire = 775
                end
            elseif QuestLevel ~= 1 then
                if QuestLevel == 2 then
                    NPCPosition = CFrame.new(- 7859.09814, 5544.19043, - 381.476196, - 0.422592998, 0, 0.906319618, 0, 1, 0, - 0.906319618, 0, - 0.422592998)
                end
            else
                NPCPosition = CFrame.new(- 4721.88867, 843.874695, - 1949.96643, 0.996191859, 0, - 0.0871884301, 0, 1, 0, 0.0871884301, 0, 0.996191859)
            end
        else
            QuestName = "PrisonerQuest"
            QuestLevel = 2
            MobName = "Dangerous Prisoner"
            Mon = "Dangerous Prisoner"
            LevelRequire = 210
            NPCPosition = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, - 0.999846935, 0, 0.0175017118)
        end
    else
        QuestName = "MarineQuest2"
        QuestLevel = 1
        MobName = "Chief Petty Officer"
        Mon = "Chief Petty Officer"
        LevelRequire = 120
    end
    MobName = MobName:sub(1, # MobName)
    if not MobName:find("Lv") then
        local v70, v71, v72 = pairs(game:GetService("Workspace").Enemies:GetChildren())
        while true do
            local v73
            v72, v73 = v70(v71, v72)
            if v72 == nil then
                break
            end
            MonLV = string.match(v73.Name, "%d+")
            if v73.Name:find(MobName) and (# v73.Name > # MobName and tonumber(MonLV) <= v36 + 50) then
                MobName = v73.Name
            end
        end
    end
    if not MobName:find("Lv") then
        local v74, v75, v76 = pairs(game:GetService("ReplicatedStorage"):GetChildren())
        while true do
            local v77
            v76, v77 = v74(v75, v76)
            if v76 == nil then
                break
            end
            MonLV = string.match(v77.Name, "%d+")
            if v77.Name:find(MobName) and (# v77.Name > # MobName and tonumber(MonLV) <= v36 + 50) then
                MobName = v77.Name
                Mon = a
            end
        end
    end
    local v78 = string.gsub(MobName, "Lv. ", "")
    local v79 = string.gsub(v78, "[%[%]]", "")
    local v80 = string.gsub(v79, "%d+", "")
    local v81 = string.gsub(v80, "%s+", "")
    local v82, v83, v84 = pairs(game.workspace.EnemySpawns:GetChildren())
    local v85 = {}
    while true do
        local v86
        v84, v86 = v82(v83, v84)
        if v84 == nil then
            break
        end
        if v86.Name ~= v81 then
            table.insert(v85, nil)
        else
            table.insert(v85, v86.CFrame)
        end
        MobCFrame = v85
    end
    return {
        QuestLevel,
        NPCPosition,
        MobName,
        QuestName,
        LevelRequire,
        Mon,
        MobCFrame,
        MonQ,
        MobCFrameNuber
    }
end
function Hop()
    local vu88 = game.PlaceId
    local vu89 = {}
    local vu90 = ""
    local vu91 = os.date("!*t").hour
    function TPReturner()
		-- upvalues: (ref) vu90, (ref) vu88, (ref) vu89, (ref) vu91
        local v92
        if vu90 ~= "" then
            v92 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. vu88 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. vu90))
        else
            v92 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. vu88 .. "/servers/Public?sortOrder=Asc&limit=100"))
        end
        if v92.nextPageCursor and (v92.nextPageCursor ~= "null" and v92.nextPageCursor ~= nil) then
            vu90 = v92.nextPageCursor
        end
        local v93, v94, v95 = pairs(v92.data)
        local v96 = 0
        while true do
            local v97
            v95, v97 = v93(v94, v95)
            if v95 == nil then
                break
            end
            local v98 = true
            local vu99 = tostring(v97.id)
            if tonumber(v97.maxPlayers) > tonumber(v97.playing) then
                local v100, v101, v102 = pairs(vu89)
                while true do
                    local v103
                    v102, v103 = v100(v101, v102)
                    if v102 == nil then
                        break
                    end
                    if v96 == 0 then
                        if tonumber(vu91) ~= tonumber(v103) then
                            pcall(function()
								-- upvalues: (ref) vu89, (ref) vu91
                                vu89 = {}
                                table.insert(vu89, vu91)
                            end)
                        end
                    elseif vu99 == tostring(v103) then
                        v98 = false
                    end
                    v96 = v96 + 1
                end
                if v98 == true then
                    table.insert(vu89, vu99)
                    wait()
                    pcall(function()
						-- upvalues: (ref) vu88, (ref) vu99
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(vu88, vu99, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    function Teleport()
		-- upvalues: (ref) vu90
        while wait() do
            pcall(function()
				-- upvalues: (ref) vu90
                TPReturner()
                if vu90 ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end
function UpdateDevilChams()
    local v104, v105, v106 = pairs(game.Workspace:GetChildren())
    while true do
        local vu107
        v106, vu107 = v104(v105, v106)
        if v106 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu107
            if DevilFruitESP then
                if vu107:FindFirstChild("Handle") then
                    if vu107.Handle:FindFirstChild("NameEsp" .. Number) then
                        vu107.Handle["NameEsp" .. Number].TextLabel.Text = vu107.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - vu107.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v108 = Instance.new("BillboardGui", vu107.Handle)
                        v108.Name = "NameEsp" .. Number
                        v108.ExtentsOffset = Vector3.new(0, 1, 0)
                        v108.Size = UDim2.new(1, 200, 1, 30)
                        v108.Adornee = vu107.Handle
                        v108.AlwaysOnTop = true
                        local v109 = Instance.new("TextLabel", v108)
                        v109.Font = Enum.Font.GothamSemibold
                        v109.FontSize = "Size14"
                        v109.TextWrapped = true
                        v109.Size = UDim2.new(1, 0, 1, 0)
                        v109.TextYAlignment = "Top"
                        v109.BackgroundTransparency = 1
                        v109.TextStrokeTransparency = 0.5
                        v109.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v109.Text = vu107.Name .. " \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - vu107.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            elseif vu107.Handle:FindFirstChild("NameEsp" .. Number) then
                vu107.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end)
    end
end
function UpdateFlowerChams()
    local v110, v111, v112 = pairs(game.Workspace:GetChildren())
    while true do
        local vu113
        v112, vu113 = v110(v111, v112)
        if v112 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu113
            if vu113.Name == "Flower2" or vu113.Name == "Flower1" then
                if FlowerESP then
                    if vu113:FindFirstChild("NameEsp" .. Number) then
                        vu113["NameEsp" .. Number].TextLabel.Text = vu113.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - vu113.Position).Magnitude / 3) .. " Distance"
                    else
                        local v114 = Instance.new("BillboardGui", vu113)
                        v114.Name = "NameEsp" .. Number
                        v114.ExtentsOffset = Vector3.new(0, 1, 0)
                        v114.Size = UDim2.new(1, 200, 1, 30)
                        v114.Adornee = vu113
                        v114.AlwaysOnTop = true
                        local v115 = Instance.new("TextLabel", v114)
                        v115.Font = Enum.Font.GothamSemibold
                        v115.FontSize = "Size14"
                        v115.TextWrapped = true
                        v115.Size = UDim2.new(1, 0, 1, 0)
                        v115.TextYAlignment = "Top"
                        v115.BackgroundTransparency = 1
                        v115.TextStrokeTransparency = 0.5
                        v115.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if vu113.Name == "Flower1" then
                            v115.Text = "Blue Flower" .. " \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - vu113.Position).Magnitude / 3) .. " Distance"
                            v115.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if vu113.Name == "Flower2" then
                            v115.Text = "Red Flower" .. " \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - vu113.Position).Magnitude / 3) .. " Distance"
                            v115.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                elseif vu113:FindFirstChild("NameEsp" .. Number) then
                    vu113:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function isnil(p116)
    return p116 == nil
end
local function vu118(p117)
    return math.floor(tonumber(p117) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
	-- upvalues: (ref) vu118
    local v119, v120, v121 = pairs(game:GetService("Players"):GetChildren())
    while true do
        local vu122
        v121, vu122 = v119(v120, v121)
        if v121 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu122, (ref) vu118
            if not isnil(vu122.Character) then
                if ESPPlayer then
                    if isnil(vu122.Character.Head) or vu122.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        vu122.Character.Head["NameEsp" .. Number].TextLabel.Text = vu122.Name .. " | " .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu122.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth: " .. vu118(vu122.Character.Humanoid.Health * 100 / vu122.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v123 = Instance.new("BillboardGui", vu122.Character.Head)
                        v123.Name = "NameEsp" .. Number
                        v123.ExtentsOffset = Vector3.new(0, 1, 0)
                        v123.Size = UDim2.new(1, 200, 1, 30)
                        v123.Adornee = vu122.Character.Head
                        v123.AlwaysOnTop = true
                        local v124 = Instance.new("TextLabel", v123)
                        v124.Font = "Code"
                        v124.FontSize = "Size14"
                        v124.TextWrapped = true
                        v124.Text = vu122.Name .. " \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu122.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v124.Size = UDim2.new(1, 0, 1, 0)
                        v124.TextYAlignment = "Top"
                        v124.BackgroundTransparency = 1
                        v124.TextStrokeTransparency = 0.5
                        if vu122.Team ~= game.Players.LocalPlayer.Team then
                            v124.TextColor3 = Color3.new(0, 134, 139)
                        else
                            v124.TextColor3 = Color3.new(0, 134, 139)
                        end
                    end
                elseif vu122.Character.Head:FindFirstChild("NameEsp" .. Number) then
                    vu122.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateDevilChams()
	-- upvalues: (ref) vu118
    local v125, v126, v127 = pairs(game.Workspace:GetChildren())
    while true do
        local vu128
        v127, vu128 = v125(v126, v127)
        if v127 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu128, (ref) vu118
            if DevilFruitESP then
                if vu128:FindFirstChild("Handle") then
                    if vu128.Handle:FindFirstChild("NameEsp" .. Number) then
                        vu128.Handle["NameEsp" .. Number].TextLabel.Text = vu128.Name .. "   \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu128.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v129 = Instance.new("BillboardGui", vu128.Handle)
                        v129.Name = "NameEsp" .. Number
                        v129.ExtentsOffset = Vector3.new(0, 1, 0)
                        v129.Size = UDim2.new(1, 200, 1, 30)
                        v129.Adornee = vu128.Handle
                        v129.AlwaysOnTop = true
                        local v130 = Instance.new("TextLabel", v129)
                        v130.Font = Enum.Font.GothamSemibold
                        v130.FontSize = "Size14"
                        v130.TextWrapped = true
                        v130.Size = UDim2.new(1, 0, 1, 0)
                        v130.TextYAlignment = "Top"
                        v130.BackgroundTransparency = 1
                        v130.TextStrokeTransparency = 0.5
                        v130.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v130.Text = vu128.Name .. " \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu128.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            elseif vu128.Handle:FindFirstChild("NameEsp" .. Number) then
                vu128.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end)
    end
end
function UpdateFlowerChams()
	-- upvalues: (ref) vu118
    local v131, v132, v133 = pairs(game.Workspace:GetChildren())
    while true do
        local vu134
        v133, vu134 = v131(v132, v133)
        if v133 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu134, (ref) vu118
            if vu134.Name == "Flower2" or vu134.Name == "Flower1" then
                if FlowerESP then
                    if vu134:FindFirstChild("NameEsp" .. Number) then
                        vu134["NameEsp" .. Number].TextLabel.Text = vu134.Name .. "   \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu134.Position).Magnitude / 3) .. " Distance"
                    else
                        local v135 = Instance.new("BillboardGui", vu134)
                        v135.Name = "NameEsp" .. Number
                        v135.ExtentsOffset = Vector3.new(0, 1, 0)
                        v135.Size = UDim2.new(1, 200, 1, 30)
                        v135.Adornee = vu134
                        v135.AlwaysOnTop = true
                        local v136 = Instance.new("TextLabel", v135)
                        v136.Font = Enum.Font.GothamSemibold
                        v136.FontSize = "Size14"
                        v136.TextWrapped = true
                        v136.Size = UDim2.new(1, 0, 1, 0)
                        v136.TextYAlignment = "Top"
                        v136.BackgroundTransparency = 1
                        v136.TextStrokeTransparency = 0.5
                        v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if vu134.Name == "Flower1" then
                            v136.Text = "Blue Flower" .. " \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu134.Position).Magnitude / 3) .. " Distance"
                            v136.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if vu134.Name == "Flower2" then
                            v136.Text = "Red Flower" .. " \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu134.Position).Magnitude / 3) .. " Distance"
                            v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                elseif vu134:FindFirstChild("NameEsp" .. Number) then
                    vu134:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateIslandMirageESP()
	-- upvalues: (ref) vu118
    local v137, v138, v139 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
    while true do
        local vu140
        v139, vu140 = v137(v138, v139)
        if v139 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu140, (ref) vu118
            if MirageIslandESP then
                if vu140.Name == "Mirage Island" then
                    if vu140:FindFirstChild("NameEsp") then
                        vu140.NameEsp.TextLabel.Text = vu140.Name .. "   \n" .. vu118((game:GetService("Players").LocalPlayer.Character.Head.Position - vu140.Position).Magnitude / 3) .. " M"
                    else
                        local v141 = Instance.new("BillboardGui", vu140)
                        v141.Name = "NameEsp"
                        v141.ExtentsOffset = Vector3.new(0, 1, 0)
                        v141.Size = UDim2.new(1, 200, 1, 30)
                        v141.Adornee = vu140
                        v141.AlwaysOnTop = true
                        local v142 = Instance.new("TextLabel", v141)
                        v142.Font = "Code"
                        v142.FontSize = "Size14"
                        v142.TextWrapped = true
                        v142.Size = UDim2.new(1, 0, 1, 0)
                        v142.TextYAlignment = "Top"
                        v142.BackgroundTransparency = 1
                        v142.TextStrokeTransparency = 0.5
                        v142.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            elseif vu140:FindFirstChild("NameEsp") then
                vu140:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function InfAb()
    if InfAbility then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local v143 = Instance.new("ParticleEmitter")
            v143.Acceleration = Vector3.new(0, 0, 0)
            v143.Archivable = true
            v143.Drag = 20
            v143.EmissionDirection = Enum.NormalId.Top
            v143.Enabled = true
            v143.Lifetime = NumberRange.new(0, 0)
            v143.LightInfluence = 0
            v143.LockedToPart = true
            v143.Name = "Agility"
            v143.Rate = 500
            local v144 = {
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 4)
            }
            v143.Size = NumberSequence.new(v144)
            v143.RotSpeed = NumberRange.new(9999, 99999)
            v143.Rotation = NumberRange.new(0, 0)
            v143.Speed = NumberRange.new(30, 30)
            v143.SpreadAngle = Vector2.new(0, 0, 0, 0)
            v143.Texture = ""
            v143.VelocityInheritance = 0
            v143.ZOffset = 2
            v143.Transparency = NumberSequence.new(0)
            v143.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
            v143.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        end
    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
    end
end
local vu145 = game:GetService("Players").LocalPlayer
local vu146 = vu145.Character.Energy.Value
function infinitestam()
	-- upvalues: (ref) vu145, (ref) vu146
    vu145.Character.Energy.Changed:connect(function()
		-- upvalues: (ref) vu145, (ref) vu146
        if InfiniteEnergy then
            vu145.Character.Energy.Value = vu146
        end
    end)
end
spawn(function()
	-- upvalues: (ref) vu146, (ref) vu145
    pcall(function()
		-- upvalues: (ref) vu146, (ref) vu145
        while wait(0.1) do
            if InfiniteEnergy then
                wait(0.1)
                vu146 = vu145.Character.Energy.Value
                infinitestam()
            end
        end
    end)
end)
function NoDodgeCool()
    if nododgecool then
        local v147 = next
        local v148, v149 = getgc()
        while true do
            local v150
            v149, v150 = v147(v148, v149)
            if v149 == nil then
                break
            end
            if game:GetService("Players").LocalPlayer.Character.Dodge and typeof(v150) == "function" and getfenv(v150).script == game:GetService("Players").LocalPlayer.Character.Dodge then
                local v151 = next
                local v152, v153 = getupvalues(v150)
                while true do
                    local v154
                    v153, v154 = v151(v152, v153)
                    if v153 == nil then
                        break
                    end
                    if tostring(v154) == "0.1" then
                        local v155 = v153
                        repeat
                            wait(0.1)
                            setupvalue(v150, v153, 0)
                        until not nododgecool
                        v153 = v155
                    end
                end
            end
        end
    end
end
local vu156 = "indq9pdnq0"
local vu157 = "Fpjq90pdfhipqdm"
local vu158 = nil
local vu159 = nil
RunService = game:GetService("RunService")
speaker = game.Players.LocalPlayer
vehicleflyspeed = 5
function getRoot(p160)
    return p160:FindFirstChild("HumanoidRootPart") or (p160:FindFirstChild("Torso") or p160:FindFirstChild("UpperTorso"))
end
local function vu163(pu161)
	-- upvalues: (ref) vu156, (ref) vu157, (ref) vu158, (ref) vu159
    pcall(function()
		-- upvalues: (ref) pu161, (ref) vu156, (ref) vu157, (ref) vu158, (ref) vu159
        FLYING = false
        local v162 = getRoot(pu161.Character)
        v162:FindFirstChild(vu156):Destroy()
        v162:FindFirstChild(vu157):Destroy()
        pu161.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
        vu158:Disconnect()
        vu159:Disconnect()
    end)
end
local function vu180(pu164, pu165)
	-- upvalues: (ref) vu163, (ref) vu156, (ref) vu157, (ref) vu158, (ref) vu159
    vu163(pu164)
    FLYING = true
    local vu166 = getRoot(pu164.Character)
    local vu167 = workspace.CurrentCamera
    local vu168 = Vector3.new()
    local vu169 = Vector3.new(0, 0, 0)
    local vu170 = Vector3.new(9000000000, 9000000000, 9000000000)
    local vu171 = require(pu164.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
    local v172 = Instance.new("BodyVelocity")
    v172.Name = vu156
    v172.Parent = vu166
    v172.MaxForce = vu169
    v172.Velocity = vu169
    local v173 = Instance.new("BodyGyro")
    v173.Name = vu157
    v173.Parent = vu166
    v173.MaxTorque = vu170
    v173.P = 1000
    v173.D = 50
    vu158 = pu164.CharacterAdded:Connect(function()
		-- upvalues: (ref) vu156, (ref) vu166, (ref) vu169, (ref) vu157, (ref) vu170
        local v174 = Instance.new("BodyVelocity")
        v174.Name = vu156
        v174.Parent = vu166
        v174.MaxForce = vu169
        v174.Velocity = vu169
        local v175 = Instance.new("BodyGyro")
        v175.Name = vu157
        v175.Parent = vu166
        v175.MaxTorque = vu170
        v175.P = 1000
        v175.D = 50
    end)
    vu159 = RunService.RenderStepped:Connect(function()
		-- upvalues: (ref) vu166, (ref) pu164, (ref) vu167, (ref) vu156, (ref) vu157, (ref) vu170, (ref) pu165, (ref) vu168, (ref) vu171
        vu166 = getRoot(pu164.Character)
        vu167 = workspace.CurrentCamera
        if pu164.Character:FindFirstChildWhichIsA("Humanoid") and vu166 and (vu166:FindFirstChild(vu156) and vu166:FindFirstChild(vu157)) then
            local v176 = pu164.Character:FindFirstChildWhichIsA("Humanoid")
            local v177 = vu166:FindFirstChild(vu156)
            local v178 = vu166:FindFirstChild(vu157)
            v177.MaxForce = vu170
            v178.MaxTorque = vu170
            if not pu165 then
                v176.PlatformStand = true
            end
            v178.CFrame = vu167.CoordinateFrame
            v177.Velocity = vu168
            local v179 = vu171:GetMoveVector()
            if v179.X > 0 then
                v177.Velocity = v177.Velocity + vu167.CFrame.RightVector * (v179.X * ((pu165 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if v179.X < 0 then
                v177.Velocity = v177.Velocity + vu167.CFrame.RightVector * (v179.X * ((pu165 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if v179.Z > 0 then
                v177.Velocity = v177.Velocity - vu167.CFrame.LookVector * (v179.Z * ((pu165 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if v179.Z < 0 then
                v177.Velocity = v177.Velocity - vu167.CFrame.LookVector * (v179.Z * ((pu165 and vehicleflyspeed or iyflyspeed) * 50))
            end
            if v177.Velocity.Magnitude > 350 then
                v177.Velocity = v177.Velocity.Unit * 350
            end
        end
    end)
end
function EquipWeapon(p181)
    if not Nill and game.Players.LocalPlayer.Backpack:FindFirstChild(p181) then
        Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(p181)
        wait(0.1)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
    end
end
function GetWeaponInventory(p182)
    local v183, v184, v185 = pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory"))
    while true do
        local v186
        v185, v186 = v183(v184, v185)
        if v185 == nil then
            break
        end
        if type(v186) == "table" and (v186.Type == "Sword" and v186.Name == p182) then
            return true
        end
    end
    return false
end
function GetMaterial(p187)
    local v188, v189, v190 = pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory"))
    while true do
        local v191
        v190, v191 = v188(v189, v190)
        if v190 == nil then
            break
        end
        if type(v191) == "table" and (v191.Type == "Material" and v191.Name == p187) then
            return v191.Count
        end
    end
    return 0
end
local vu192 = false
function WaitHRP(p193)
    if p193 then
        return p193.Character:WaitForChild("HumanoidRootPart", 9)
    end
end
function CheckNearestTeleporter(p194)
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
function requestEntrance(p206)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", p206)
    local v207 = game.Players.LocalPlayer.Character.HumanoidRootPart
    v207.CFrame = v207.CFrame + Vector3.new(0, 50, 0)
    task.wait(0.5)
end
function topos(pu208)
	-- upvalues: (ref) vu192
    local vu209 = game.Players.LocalPlayer
    if vu209.Character and vu209.Character.Humanoid.Health > 0 and vu209.Character:FindFirstChild("HumanoidRootPart") then
        if not pu208 then
            return
        end
        local v210 = (pu208.Position - vu209.Character.HumanoidRootPart.Position).Magnitude
        local v211 = CheckNearestTeleporter(pu208)
        local _ = getgenv().TweenSpeed
        if v211 then
            requestEntrance(v211)
            task.wait(0.2)
            v210 = (pu208.Position - vu209.Character.HumanoidRootPart.Position).Magnitude
        end
        if not vu209.Character:FindFirstChild("PartTele") then
            local vu212 = Instance.new("Part", vu209.Character)
            vu212.Size = Vector3.new(10, 1, 10)
            vu212.Name = "PartTele"
            vu212.Anchored = true
            vu212.Transparency = 1
            vu212.CanCollide = false
            vu212.CFrame = WaitHRP(vu209).CFrame
            local v213 = vu212
            vu212.GetPropertyChangedSignal(v213, "CFrame"):Connect(function()
				-- upvalues: (ref) vu192, (ref) vu209, (ref) vu212, (ref) pu208
                if vu192 then
                    task.wait()
                    if vu209.Character and vu209.Character:FindFirstChild("HumanoidRootPart") then
                        local v214 = vu212.CFrame
                        WaitHRP(vu209).CFrame = CFrame.new(v214.Position.X, pu208.Position.Y, v214.Position.Z)
                    end
                end
            end)
        end
        vu192 = true
        local v215 = getgenv().TweenSpeed
        if v210 <= 300 then
            v215 = v215 * 4
        end
        CFrame.new(pu208.Position.X, pu208.Position.Y, pu208.Position.Z)
        local v216 = game:GetService("TweenService"):Create(vu209.Character.PartTele, TweenInfo.new(v210 / v215, Enum.EasingStyle.Linear), {
            ["CFrame"] = pu208
        })
        v216:Play()
        v216.Completed:Connect(function(p217)
			-- upvalues: (ref) vu209, (ref) vu192
            if p217 == Enum.PlaybackState.Completed then
                if vu209.Character:FindFirstChild("PartTele") then
                    vu209.Character.PartTele:Destroy()
                end
                vu192 = false
            end
        end)
    end
end
getgenv().TweenSpeed = 350
function TP1(p218)
    topos(p218)
end
local vu219 = game.Players.LocalPlayer
local _ = vu219.Character.HumanoidRootPart
Players = game.Players
recentlySpawn = 0
function dist(p220, pu221, pu222)
	-- upvalues: (ref) vu219
    local vu223 = Vector3.new(p220.X, pu222 and 0 or (p220.Y or 0), p220.Z)
    local v225, v226 = pcall(function()
		-- upvalues: (ref) pu221, (ref) vu219, (ref) pu222, (ref) vu223
        if not pu221 then
            while true do
                local v224 = vu219.Character
                if v224 then
                    v224 = vu219.Character:FindFirstChild("HumanoidRootPart")
                end
                if v224 and v224.Position then
                    break
                end
                wait(0.5)
            end
            pu221 = v224.Position
        end
        return (vu223 - Vector3.new(pu221.X, not pu222 and pu221.Y or 0, pu221.Z)).magnitude
    end)
    if v225 then
        return v226
    end
    warn("Dist", v226)
    return nil
end
function InArea(p227, p228)
    local v229 = nil
    local v230 = 0
    if p228 and dist(p227, p228.Position, true) <= p228.Mesh.Scale.X / 2 + 500 then
        return p228
    end
    local v231, v232, v233 = pairs(workspace._WorldOrigin.Locations:GetChildren())
    while true do
        local v234
        v233, v234 = v231(v232, v233)
        if v233 == nil then
            break
        end
        if dist(p227, v234.Position, true) <= v234.Mesh.Scale.X / 2 + 500 and v230 < v234.Mesh.Scale.X then
            v230 = v234.Mesh.Scale.X
            v229 = v234
        end
    end
    return v229
end
function TP2(...)
	-- upvalues: (ref) vu219
    local vu236 = (function(p235)
        if typeof(p235) ~= "Vector3" then
            if typeof(p235) ~= "CFrame" then
                return nil
            else
                return p235
            end
        else
            return CFrame.new(p235)
        end
    end)(...)
    if vu219.Character:FindFirstChild("HumanoidRootPart") then
        if not tweenPause then
            local vu237 = nil
            local v252, v253 = pcall(function()
				-- upvalues: (ref) vu236, (ref) vu237, (ref) vu219
                local v238 = CheckNearestTeleporter(vu236)
                if v238 then
                    requestEntrance(v238)
                end
                if not tweenActive or (not lastTweenTarget or dist(vu236, lastTweenTarget) >= 10 and dist(lastTweenTarget) < 10) then
                    tweenid = (tweenid or 0) + 1
                    lastTweenTarget = vu236
                    vu237 = tweenid
                    Util = require(game:GetService("ReplicatedStorage").Util)
                    if Util.FPSTracker.FPS > 60 then
                        setfpscap(200)
                    end
                    task.spawn(pcall, function()
						-- upvalues: (ref) vu236, (ref) vu219, (ref) vu237
                        lastPos = {
                            tick(),
                            vu236
                        }
                        local vu239 = dist(vu219.Character.HumanoidRootPart.Position, vu236, true)
                        local vu240 = vu239
                        vu219.Character.Humanoid:SetStateEnabled(13, false)
                        if getgenv().TweenPosY then
                            if vu239 > 60 then
                                vu219.Character.HumanoidRootPart.CFrame = CFrame.new(vu219.Character.HumanoidRootPart.Position.X, vu219.Character.HumanoidRootPart.Position.Y + 200, vu219.Character.HumanoidRootPart.Position.Z)
                            else
                                vu219.Character.HumanoidRootPart.CFrame = CFrame.new(vu236.Position.X, vu236.Position.Y, vu236.Position.Z)
                            end
                        else
                            vu219.Character.HumanoidRootPart.CFrame = CFrame.new(vu219.Character.HumanoidRootPart.CFrame.X, vu236.Y, vu219.Character.HumanoidRootPart.CFrame.Z)
                        end
                        while vu219.Character:FindFirstChild("HumanoidRootPart") and (75 < vu239 and (vu237 == tweenid and vu219.Character.Humanoid.Health > 0)) do
                            local v241 = 58 / math.clamp(Util.FPSTracker.FPS, 0, 60)
                            local v242 = 5.5 * v241
                            local v243 = vu219.Character.HumanoidRootPart.Position
                            local v244 = Vector3.new(vu236.X, 0, vu236.Z) - Vector3.new(v243.X, 0, v243.Z)
                            local v245 = (v244.X < 0 and - 1 or 1) * v242
                            local v246 = (v244.Z < 0 and - 1 or 1) * v242
                            if math.abs(v244.X) < v245 then
                                v245 = v244.X or v245
                            end
                            if math.abs(v244.Z) < v246 then
                                v246 = v244.Z or v246
                            end
                            task.spawn(function()
								-- upvalues: (ref) vu239, (ref) vu219, (ref) vu236, (ref) vu240
                                vu239 = dist(vu219.Character.HumanoidRootPart.Position, vu236, true)
                                if vu239 > vu240 + 10 then
                                    tweenid = - 1
                                    tweenPause = false
                                    vu219.Character.HumanoidRootPart.Anchored = true
                                    task.wait()
                                    tweenPause = false
                                    vu219.Character.HumanoidRootPart.Anchored = false
                                end
                                vu240 = vu239
                            end)
                            local v247 = vu219.Character.HumanoidRootPart
                            local v248 = vu219.Character.HumanoidRootPart.CFrame
                            local v249 = Vector3.new
                            local v250
                            if math.abs(v246) >= 5 * v241 or not v245 then
                                v250 = v245 / 1.5
                            else
                                v250 = v245
                            end
                            local v251 = 0
                            if math.abs(v245) >= 5 * v241 or not v246 then
                                v246 = v246 / 1.5
                            end
                            v247.CFrame = v248 + v249(v250, v251, v246)
                            tweenActive = true
                            task.wait()
                        end
                        vu219.Character.Humanoid:SetStateEnabled(13, true)
                        tweenActive = false
                        if vu239 <= 100 and vu237 == tweenid then
                            vu219.Character.HumanoidRootPart.CFrame = vu236
                        end
                    end)
                end
            end)
            if not v252 then
                warn("TP :", v253)
            end
            return vu237
        end
    end
end
function stopTeleport()
	-- upvalues: (ref) vu192
    vu192 = false
    local v254 = game.Players.LocalPlayer
    if v254.Character:FindFirstChild("PartTele") then
        v254.Character.PartTele:Destroy()
    end
end
spawn(function()
	-- upvalues: (ref) vu192
    while task.wait() do
        if not vu192 then
            stopTeleport()
        end
    end
end)
spawn(function()
    local vu255 = game.Players.LocalPlayer
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu255
            if vu255.Character:FindFirstChild("PartTele") and (vu255.Character.HumanoidRootPart.Position - vu255.Character.PartTele.Position).Magnitude >= 100 then
                stopTeleport()
            end
        end)
    end
end)
local vu256 = game.Players.LocalPlayer
local function v258(p257)
    p257:WaitForChild("Humanoid").Died:Connect(function()
        stopTeleport()
    end)
end
vu256.CharacterAdded:Connect(v258)
if vu256.Character then
    v258(vu256.Character)
end
function TPB(p259, _)
    local v260 = {}
    local v261 = game:GetService("Workspace").Boats[_G.SelectedBoat]
    if v261 then
        v261 = v261.VehicleSeat
    end
    if v261 then
        if (v261.Position - p259.Position).Magnitude <= 25 then
            p259 = CFrame.new(p259.Position.X, 60, p259.Position.Z)
            v261.CFrame = p259
            if v261:FindFirstChild("Root") then
                v261.Root:Destroy()
                wait()
                TweenBoat(v261.CFrame)
                wait()
            end
        end
        if not v261:FindFirstChild("Root") then
            local v262 = Instance.new("Part", v261)
            v262.Size = Vector3.new(1, 0.5, 1)
            v262.Name = "Root"
            v262.Anchored = true
            v262.Transparency = 1
            v262.CanCollide = false
            v262.CFrame = v261.CFrame
        end
        local vu263 = v261:FindFirstChild("Root")
        if vu263 then
            local v264 = (v261.Position - p259.Position).Magnitude
            local vu265 = game:GetService("TweenService"):Create(vu263, TweenInfo.new(v264 / getgenv().SpeedBoat, Enum.EasingStyle.Linear), {
                ["CFrame"] = CFrame.new(p259.Position.X, 60, p259.Position.Z)
            })
            local v266 = vu265
            vu265.Play(v266)
            function v260.Stop(_)
				-- upvalues: (ref) vu265, (ref) vu263
                if vu265 then
                    vu265:Cancel()
                end
                if vu263 then
                    vu263:Destroy()
                end
            end
            return v260
        end
    end
end
task.spawn(function()
    while task.wait() do
        pcall(function()
            local v267 = game:GetService("Workspace").Boats[_G.SelectedBoat]
            if v267 then
                v267 = v267.VehicleSeat
            end
            if v267 then
                v267.CFrame = CFrame.new(v267.Root.CFrame.Position.X, getgenv().PosYBoat, v267.Root.CFrame.Position.Z)
                if (v267.Root.Position - v267.Position).Magnitude >= 1 then
                    v267.Root.CFrame = v267.CFrame
                end
            end
        end)
    end
end)
function fastpos(p268)
    local v269 = (p268.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(v269 / 1000, Enum.EasingStyle.Linear), {
        ["CFrame"] = p268
    }):Play()
end
Type = 1
spawn(function()
    while task.wait() do
        if Type ~= 1 then
            if Type ~= 2 then
                if Type ~= 3 then
                    if Type == 4 then
                        Pos = CFrame.new(- 19, PosY, 0)
                    end
                else
                    Pos = CFrame.new(0, PosY, 19)
                end
            else
                Pos = CFrame.new(19, PosY, 0)
            end
        else
            Pos = CFrame.new(0, PosY, - 19)
        end
    end
end)
spawn(function()
    while task.wait(0.1) do
        Type = 1
        wait(0.2)
        Type = 2
        wait(0.2)
        Type = 3
        wait(0.2)
        Type = 4
        wait(0.2)
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if (_G.AdvanceDungeon or (_G.DoughKingRaid or (_G.DoughtBoss or (_G.FarmChest or (_G.Factory or (_G.FarmBossHallow or (_G.FarmSwanGlasses or (_G.LongSword or (_G.BlackSpikeycoat or (_G.ElectricClaw or (_G.FarmGunMastery or (_G.HolyTorch or (_G.LawRaid or (_G.FarmBoss or (_G.TwinHooks or (_G.OpenSwanDoor or (_G.Dragon_Trident or (_G.Saber or (_G.FarmFruitMastery or (_G.FarmGunMastery or (_G.TeleportIsland or (_G.EvoRace or (_G.FarmAllMsBypassType or (_G.Observationv2 or (_G.MusketeerHat or (_G.Ectoplasm or (_G.Rengoku or (_G.AutoDarkbeard or (_G.Rainbow_Haki or (_G.Observation or (_G.DarkDagger or (_G.Safe_Mode or (_G.MasteryFruit or (_G.BudySword or (_G.OderSword or (_G.AllBoss or (_G.Sharkman or (_G.Mastery_Fruit or (_G.Mastery_Gun or (_G.Dungeon or (_G.Cavender or (_G.Pole or (_G.Kill_Ply or (_G.Factory or (_G.SecondSea or (_G.TeleportPly or (_G.Bartilo or (_G.DarkBoss or (_G.GrabChest or (_G.Holy_Torch or (_G.Level or (_G.KillAfterTrials or (_G.Clip or (FarmBoss or (_G.Elitehunter or (_G.CollectBerry or (_G.ThirdSea or (_G.Bone or (_G.Train or (_G.heart or (_G.FarmMaterial or (_G.Guitar or (Auto_Quest_Soul_Guitar or (_G.Dragon_Trident or (_G.tushita or (_G.d or (_G.waden or (_G.Greybeard or (_G.pole or (_G.saw or (_G.FarmNearest or (_G.FarmChest or (_G.Carvender or (_G.TwinHook or (AutoMobAura or (_G.Tweenfruit or (_G.TeleportNPC or (_G.Leather or (_G.Wing or (_G.Umm or (_G.Makori_gay or (Radioactive or (Fish or (Gunpowder or (Dragon_Scale or (Cocoafarm or (Scrap or (MiniHee or (_G.FarmSeabaest or (Yama_Quest or (Get_Cursed or (Tushita_Quest or (_G.FarmMob or (_G.MysticIsland or (_G.FarmDungeon or (_G.RaidPirate or (_G.QuestRace or (_G.TweenMGear or (getgenv().AutoFarm or (_G.PlayerHunter or (_G.Factory or (Grab_Chest or (_G.Seabest or (_G.SeaBest or (_G.KillTial or (_G.Saber or (_G.Position_Spawn or (_G.Farmfast or (_G.Race or (_G.RaidPirate or (Open_Color_Haki or (_G.Terrorshark or (FarmShark or (_G.farmpiranya or (_G.DefendVolcano or (_G.KillGolem or (_G.TpPrehistoric or (_G.TpSkullCore or (_G.Fish_Crew_Member or (_G.AppleAutoDriveBoat or (_G.bjirFishBoat or (_G.KillGhostShip or (_G.KillLeviathan or (_G.SegmentLeviathan or (_G.FrozenDimension or _G.FKitsune))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) and not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                local v270 = Instance.new("BodyVelocity")
                v270.Name = "BodyClip"
                v270.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                v270.MaxForce = Vector3.new(100000, 100000, 100000)
                v270.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.AdvanceDungeon or (_G.DoughKingRaid or (_G.DoughtBoss or (_G.Factory or (_G.FarmBossHallow or (_G.FarmSwanGlasses or (_G.LongSword or (_G.BlackSpikeycoat or (_G.ElectricClaw or (_G.FarmGunMastery or (_G.HolyTorch or (_G.LawRaid or (_G.FarmBoss or (_G.TwinHooks or (_G.OpenSwanDoor or (_G.Dragon_Trident or (_G.Saber or (_G.NoClip or (_G.FarmFruitMastery or (_G.FarmGunMastery or (_G.TeleportIsland or (_G.EvoRace or (_G.FarmAllMsBypassType or (_G.Observationv2 or (_G.MusketeerHat or (_G.Ectoplasm or (_G.Rengoku or (_G.AutoDarkbeard or (_G.Rainbow_Haki or (_G.Observation or (_G.DarkDagger or (_G.Safe_Mode or (_G.MasteryFruit or (_G.BudySword or (_G.OderSword or (_G.AllBoss or (_G.Sharkman or (_G.Mastery_Fruit or (_G.Mastery_Gun or (_G.Dungeon or (_G.Cavender or (_G.Pole or (_G.Kill_Ply or (_G.Factory or (_G.SecondSea or (_G.TeleportPly or (_G.Bartilo or (_G.DarkBoss or (_G.GrabChest or (_G.Holy_Torch or (_G.Level or (_G.KillAfterTrials or (_G.Clip or (_G.Elitehunter or (_G.CollectBerry or (_G.ThirdSea or (_G.Bone or (_G.Train or (_G.heart or (_G.FarmMaterial or (_G.Guitar or (Auto_Quest_Soul_Guitar or (_G.Dragon_Trident or (_G.tushita or (_G.waden or (_G.pole or (_G.Greybeard or (_G.saw or (_G.FarmNearest or (_G.Carvender or (_G.TwinHook or (AutoMobAura or (_G.Tweenfruit or (_G.TeleportNPC or (_G.Kai or (_G.Leather or (_G.Wing or (_G.Umm or (_G.Makori_gay or (Radioactive or (Fish or (Gunpowder or (Dragon_Scale or (Cocoafarm or (Scrap or (MiniHee or (_G.FarmSeabaest or (Yama_Quest or (Get_Cursed or (Tushita_Quest or (_G.FarmMob or (_G.MysticIsland or (_G.FarmDungeon or (_G.RaidPirate or (_G.QuestRace or (_G.TweenMGear or (getgenv().AutoFarm or (_G.PlayerHunter or (_G.Factory or (_G.Seabest or (_G.SeaBest or (_G.KillTial or (_G.Saber or (_G.Position_Spawn or (_G.TPB or (_G.Farmfast or (_G.Race or (_G.RaidPirate or (Open_Color_Haki or (_G.Terrorshark or (_G.KillLeviathan or (_G.SegmentLeviathan or (_G.DefendVolcano or (_G.KillGolem or (_G.TpPrehistoric or (_G.TpSkullCore or (FarmShark or (_G.farmpiranya or (_G.Fish_Crew_Member or (_G.AppleAutoDriveBoat or (_G.FrozenDimension or _G.FKitsune)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) then
                local v271, v272, v273 = pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants())
                while true do
                    local v274
                    v273, v274 = v271(v272, v273)
                    if v273 == nil then
                        break
                    end
                    if v274:IsA("BasePart") then
                        v274.CanCollide = false
                    end
                end
            end
        end)
    end)
end)
function StopTween(p275)
    if not p275 then
        _G.StopTween = true
        wait()
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
        end
        _G.StopTween = false
        _G.Clip = false
    end
    if game.Players.LocalPlayer.Character:FindFirstChild("Highlight") then
        game.Players.LocalPlayer.Character:FindFirstChild("Highlight"):Destroy()
    end
end
spawn(function()
    pcall(function()
        while task.wait() do
            local v276, v277, v278 = pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())
            while true do
                local v279
                v278, v279 = v276(v277, v278)
                if v278 == nil then
                    break
                end
                if v279:IsA("Tool") and v279:FindFirstChild("RemoteFunctionShoot") then
                    SelectWeaponGun = v279.Name
                end
            end
        end
    end)
end)
local vu280 = v6:CreateWindow({
    ["Title"] = "Bap Red (Beta)",
    ["SubTitle"] = "https://discord.gg/nDURhyF5Je",
    ["TabWidth"] = 140,
    ["Size"] = UDim2.fromOffset(480, 360),
    ["Acrylic"] = false,
    ["Theme"] = "Dark",
    ["MinimizeKey"] = Enum.KeyCode.End
})
local v281 = {}
local v282 = vu280
v281.I = vu280.T(v282, {
    ["Title"] = "Status",
    ["Icon"] = ""
})
local v283 = vu280
v281.Mn = vu280.T(v283, {
    ["Title"] = "General",
    ["Icon"] = ""
})
local v284 = vu280
v281.St = vu280.T(v284, {
    ["Title"] = "Setting",
    ["Icon"] = ""
})
local v285 = vu280
v281.M = vu280.T(v285, {
    ["Title"] = "Quest & Item",
    ["Icon"] = ""
})
local v286 = vu280
v281.V4 = vu280.T(v286, {
    ["Title"] = "Race & Mirage",
    ["Icon"] = ""
})
local v287 = vu280
v281.E = vu280.T(v287, {
    ["Title"] = "Sea Event",
    ["Icon"] = ""
})
local v288 = vu280
v281.Ve = vu280.T(v288, {
    ["Title"] = "Volcano Event",
    ["Icon"] = ""
})
local v289 = vu280
v281.P = vu280.T(v289, {
    ["Title"] = "Local Player",
    ["Icon"] = ""
})
local v290 = vu280
v281.V = vu280.T(v290, {
    ["Title"] = "Visual",
    ["Icon"] = ""
})
local v291 = vu280
v281.R = vu280.T(v291, {
    ["Title"] = "Dungeon",
    ["Icon"] = ""
})
local v292 = vu280
v281.T = vu280.T(v292, {
    ["Title"] = "Teleport",
    ["Icon"] = ""
})
local v293 = vu280
v281.S = vu280.T(v293, {
    ["Title"] = "Shop",
    ["Icon"] = ""
})
local v294 = vu280
v281.D = vu280.T(v294, {
    ["Title"] = "Devil Fruit",
    ["Icon"] = ""
})
local v295 = vu280
v281.Mc = vu280.T(v295, {
    ["Title"] = "Miscellaneous",
    ["Icon"] = ""
})
local v296 = Instance.new("ScreenGui")
local v297 = Instance.new("ImageButton")
local v298 = Instance.new("UICorner")
Instance.new("Frame")
v296.Name = "Bap"
v296.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
v296.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v297.Name = "ToggleUIButton"
v297.Parent = v296
v297.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
v297.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
v297.Size = UDim2.new(0, 53, 0, 53)
v297.Image = "rbxassetid://110905876048511"
v297.Visible = true
v297.Draggable = true
v298.Parent = v297
v297.MouseButton1Click:Connect(function()
	-- upvalues: (ref) vu280
    vu280:Minimize()
end)
v281.I:AddSection("Join Discord")
v281.I:AddButton({
    ["Title"] = "Discord | Bap Red",
    ["Description"] = "Copy Link Discord",
    ["Callback"] = function()
        setclipboard("https://discord.gg/nDURhyF5Je")
    end
})
v281.I:AddSection("Time")
local vu299 = v281.I:AddParagraph({
    ["Title"] = "Executer Time",
    ["Content"] = ""
})
function UpdateTime()
	-- upvalues: (ref) vu299
    local v300 = math.floor(workspace.DistributedGameTime + 0.5)
    vu299:SetDesc("[Server Time]: Hours: " .. math.floor(v300 / 3600) % 24 .. " Min: " .. math.floor(v300 / 60) % 60 .. " Sec: " .. math.floor(v300 / 1) % 60)
end
spawn(function()
    while task.wait() do
        pcall(function()
            UpdateTime()
        end)
    end
end)
local vu301 = v281.I:AddParagraph({
    ["Title"] = "FPS",
    ["Content"] = ""
})
function UpdateClient()
	-- upvalues: (ref) vu301
    vu301:SetDesc("[FPS]: " .. workspace:GetRealPhysicsFPS())
end
spawn(function()
    while task.wait(0.1) do
        pcall(UpdateClient)
    end
end)
local vu302 = v281.I:AddParagraph({
    ["Title"] = "Ping",
    ["Content"] = ""
})
function UpdateClient1()
	-- upvalues: (ref) vu302
    vu302:SetDesc("[PING]: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString())
end
spawn(function()
    while task.wait(0.1) do
        pcall(UpdateClient1)
    end
end)
v281.I:AddSection("Status Player")
local vu303 = v281.I:AddParagraph({
    ["Title"] = "Race",
    ["Content"] = ""
})
local vu304 = v281.I:AddParagraph({
    ["Title"] = "Beli",
    ["Content"] = ""
})
local vu305 = v281.I:AddParagraph({
    ["Title"] = "Fragments",
    ["Content"] = ""
})
local vu306 = v281.I:AddParagraph({
    ["Title"] = "Bounty",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu303, (ref) vu304, (ref) vu306, (ref) vu305
    while task.wait(1) do
        pcall(function()
			-- upvalues: (ref) vu303, (ref) vu304, (ref) vu306, (ref) vu305
            vu303:SetDesc("Race: " .. game:GetService("Players").LocalPlayer.Data.Race.Value)
            vu304:SetDesc("Beli: " .. game:GetService("Players").LocalPlayer.Data.Beli.Value)
            vu306:SetDesc("Bounty / Honor: " .. game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value)
            vu305:SetDesc("Fragments: " .. game:GetService("Players").LocalPlayer.Data.Fragments.Value)
        end)
    end
end)
local vu307 = v281.I:AddParagraph({
    ["Title"] = "Devil Fruit",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu307
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu307
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                vu307:SetDesc("Devil Fruit: " .. game:GetService("Players").LocalPlayer.Data.DevilFruit.Value)
            else
                vu307:SetDesc("Not Have Devil Fruit")
            end
        end)
    end
end)
v281.Mn:AddSection("Farm Mode")
_G.SelectWeapon = "Melee"
Dropdown = v281.Mn:AddDropdown("Dropdown", {
    ["Title"] = "Select Weapon",
    ["Values"] = {
        "Melee",
        "Sword",
        "Fruit",
        "Gun"
    },
    ["Multi"] = false
})
Dropdown:SetValue(_G.SelectWeapon)
Dropdown:OnChanged(function(p308)
    _G.SelectWeapon = p308
end)
task.spawn(function()
    while wait() do
        pcall(function()
            if _G.SelectWeapon ~= "Melee" then
                if _G.SelectWeapon ~= "Sword" then
                    if _G.SelectWeapon ~= "Gun" then
                        if _G.SelectWeapon == "Fruit" then
                            local v309, v310, v311 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                            while true do
                                local v312
                                v311, v312 = v309(v310, v311)
                                if v311 == nil then
                                    break
                                end
                                if v312.ToolTip == "Blox Fruit" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v312.Name)) then
                                    _G.SelectWeapon = v312.Name
                                end
                            end
                        end
                    else
                        local v313, v314, v315 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                        while true do
                            local v316
                            v315, v316 = v313(v314, v315)
                            if v315 == nil then
                                break
                            end
                            if v316.ToolTip == "Gun" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v316.Name)) then
                                _G.SelectWeapon = v316.Name
                            end
                        end
                    end
                else
                    local v317, v318, v319 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                    while true do
                        local v320
                        v319, v320 = v317(v318, v319)
                        if v319 == nil then
                            break
                        end
                        if v320.ToolTip == "Sword" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v320.Name)) then
                            _G.SelectWeapon = v320.Name
                        end
                    end
                end
            else
                local v321, v322, v323 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                while true do
                    local v324
                    v323, v324 = v321(v322, v323)
                    if v323 == nil then
                        break
                    end
                    if v324.ToolTip == "Melee" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v324.Name)) then
                        _G.SelectWeapon = v324.Name
                    end
                end
            end
        end)
    end
end)
FireCooldown = "Super Attack"
Dropdown = v281.Mn:AddDropdown("Dropdown", {
    ["Title"] = "Fast Attack Delay",
    ["Values"] = {
        "Normal Attack",
        "Fast Attack",
        "Super Attack",
        "Bap Attack"
    },
    ["Multi"] = false
})
Dropdown:SetValue(FireCooldown)
Dropdown:OnChanged(function(p325)
    FireCooldown = p325
end)
v281.Mn:AddSection("Farming")
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Level",
    ["Default"] = false
})
Toggle:OnChanged(function(p326)
    _G.Level = p326
    StopTween(_G.Farm)
end)
_G.Auto_CFrame = true
PosLv = CFrame.new(0, 25, 0)
local vu327 = 1
spawn(function()
	-- upvalues: (ref) vu87, (ref) vu327
    while wait() do
        local _ = game.Players.LocalPlayer.Data.Level.Value
        local vu328 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
        pcall(function()
			-- upvalues: (ref) vu328, (ref) vu87, (ref) vu327
			-- block 54
            if not _G.Level then
				-- ::l3::
                return
            end
            if vu328.Visible ~= true then
                topos(vu87()[2])
                if (vu87()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
                    StartMagnetLv = false
                    wait(0.2)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", vu87()[4], vu87()[1])
                    wait(0.2)
                    topos(vu87()[7][1] * PosLv)
                end
				-- goto l3
            end
            local v329 = vu328.Container.QuestTitle.Title.Text
            if not string.find(v329, vu87()[6]) then
                StartMagnetLv = false
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                wait(0.5)
                topos(vu87()[2])
                if (vu87()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
                    wait(0.2)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", vu87()[4], vu87()[1])
                    wait(0.2)
                    topos(vu87()[7][1] * PosLv)
                end
				-- goto l3
            end
            if not game:GetService("Workspace").Enemies:FindFirstChild(vu87()[3]) then
                if _G.Auto_CFrame then
                    topos(vu87()[7][vu327] * PosLv)
                    if (vu87()[7][vu327].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                        if vu327 == nil or vu327 == "" then
                            vu327 = 1
                        elseif vu327 >= # vu87()[7] then
                            vu327 = 1
                        end
                        vu327 = vu327 + 1
                        wait(0.5)
                    end
                end
				-- goto l3
            end
            local v330, v331, v332 = pairs(game:GetService("Workspace").Enemies:GetChildren())
			-- goto l15
			-- ::l2::
			-- goto l24
			-- ::l24::
            task.wait()
            if _G.Auto_CFrame then
                vu327 = 1
            end
            PosMonLv = v333.HumanoidRootPart.CFrame
            v333.HumanoidRootPart.CanCollide = false
            v333.Humanoid.WalkSpeed = 0
            v333.Head.CanCollide = false
            StartMagnetLv = true
            EquipWeapon(_G.SelectWeapon)
            v333.HumanoidRootPart.Transparency = 1
            TP2(v333.HumanoidRootPart.CFrame * Pos)
            if _G.Level and (v333.Parent and (v333.Humanoid.Health > 0 and (vu328.Visible ~= false and v333:FindFirstChild("HumanoidRootPart")))) then
				-- goto l24
            end
			-- ::l15::
            local v333
            v332, v333 = v330(v331, v332)
            if v332 == nil then
				-- goto l3
            end
            if v333.Name ~= vu87()[3] or (not v333:FindFirstChild("Humanoid") or (not v333:FindFirstChild("HumanoidRootPart") or v333.Humanoid.Health <= 0)) then
				-- goto l15
            else
				-- goto l2
            end
        end)
    end
end)
if World1 then
    Toggle = v281.Mn:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Skip (Farm Lv.1-100)",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p334)
        _G.Farmfast = p334
        _G.Stats_Kaitun = p334
        StopTween(_G.Farmfast)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.Farmfast and World1 then
                    local v335 = game.Players.LocalPlayer.Data.Level.Value
                    if v335 >= 1 then
                        _G.Level = false
                        _G.Farmfast = true
                    end
                    if v335 >= 100 then
                        _G.Level = true
                        _G.Farmfast = false
                    end
                    if v335 >= 1 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
                        local v336, v337, v338 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v339
                            v338, v339 = v336(v337, v338)
                            if v338 == nil then
                                break
                            end
                            if v339.Name == "Shanda" and (v339:FindFirstChild("Humanoid") and (v339:FindFirstChild("HumanoidRootPart") and v339.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v339.HumanoidRootPart.CanCollide = false
                                    v339.Humanoid.WalkSpeed = 0
                                    StartMagnet = true
                                    _G.PosMon = v339.HumanoidRootPart.CFrame
                                    TP2(v339.HumanoidRootPart.CFrame * Pos)
                                until not _G.Farmfast or (not v339.Parent or v339.Humanoid.Health <= 0)
                                StartMagnet = false
                                TP1(CFrame.new(- 7678.48974609375, 5566.40380859375, - 497.2156066894531))
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Shanda") then
                        TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Shanda").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end
            end
        end)
    end)
end
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Kaitun",
    ["Default"] = false
})
Toggle:OnChanged(function(p340)
    _G.Level = p340
    _G.Stats_Kaitun = p340
    _G.Superhuman = p340
    _G.SecondSea = p340
    _G.ThirdSea = p340
    _G.BuyLegendarySword = p340
    _G.StoreFruit = p340
    _G.BuyAllAib = p340
    _G.BuyAllSword = p340
    StopTween(_G.Farm)
end)
spawn(function()
    while wait() do
        if _G.BuyAllSword then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
                if _G.BuyHop then
                    wait(10)
                    Hop()
                end
            end)
        end
        if _G.BuyAllAib then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
                if _G.HopBuy then
                    wait(10)
                    Hop()
                end
            end)
        end
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Nearest",
    ["Default"] = false
})
Toggle:OnChanged(function(p341)
    _G.FarmNearest = p341
    StopTween(_G.FarmNearest)
end)
spawn(function()
    while wait() do
        if _G.FarmNearest then
            local v342, v343, v344 = pairs(game:GetService("Workspace").Enemies:GetChildren())
            while true do
                local v345
                v344, v345 = v342(v343, v344)
                if v344 == nil then
                    break
                end
                if v345.Name and (v345:FindFirstChild("Humanoid") and (v345:FindFirstChild("HumanoidRootPart") and ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v345.HumanoidRootPart.Position).Magnitude <= 2000 and v345.Humanoid.Health > 0))) then
                    repeat
                        wait()
                        EquipWeapon(_G.SelectWeapon)
                        TP2(v345.HumanoidRootPart.CFrame * Pos)
                        v345.HumanoidRootPart.CanCollide = false
                        StartMagnet = true
                        _G.PosMon = v345.HumanoidRootPart.CFrame
                    until not _G.FarmNearest or (not v345.Parent or v345.Humanoid.Health <= 0)
                    StartMagnet = false
                end
            end
        end
    end
end)
v281.Mn:AddSection("Berry")
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Collect Berry",
    ["Default"] = false
})
Toggle:OnChanged(function(p346)
    _G.CollectBerry = p346
    StopTween(_G.CollectBerry)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Collect Berry Hop",
    ["Default"] = false
})
Toggle:OnChanged(function(p347)
    _G.CollectBerryHop = p347
end)
spawn(function()
    while wait() do
        if _G.CollectBerry then
            local v348 = game:GetService("Players").LocalPlayer
            local v349 = (v348.Character or v348.CharacterAdded:Wait()):GetPivot().Position
            local v350 = game:GetService("CollectionService"):GetTagged("BerryBush")
            local v351 = math.huge
            local v352 = nil
            for v353 = 1, # v350 do
                local v354 = v350[v353]
                local v355, v356, v357 = pairs(v354:GetAttributes())
                while true do
                    local v358
                    v357, v358 = v355(v356, v357)
                    if v357 == nil then
                        break
                    end
                    local v359 = (v354.Parent:GetPivot().Position - v349).Magnitude
                    if v359 < v351 then
                        v352 = v354
                        v351 = v359
                    end
                end
            end
            if v352 then
                local v360 = v352.Parent:GetPivot().Position
                local v361 = CFrame.new(v360)
                topos(v361)
            elseif _G.CollectBerryHop then
                Hop()
            end
        end
    end
end)
v281.Mn:AddSection("Misc Elite")
local vu362 = v281.Mn:AddParagraph({
    ["Title"] = "Total Elite Hunter :",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu362
    while task.wait() do
        vu362:SetDesc("Total Elite Hunter : " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
    end
end)
local vu363 = v281.Mn:AddParagraph({
    ["Title"] = "Status:",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu363
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu363
            if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or (game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or (game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or (game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban"))))) then
                vu363:SetDesc("Status: Elite Spawn!")
            else
                vu363:SetDesc("Status: Elite Not Spawn")
            end
        end)
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Elite Hunter",
    ["Default"] = false
})
Toggle:OnChanged(function(p364)
    _G.Elitehunter = p364
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    StopTween(_G.Elitehunter)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Elite Hunter Hop",
    ["Default"] = false
})
Toggle:OnChanged(function(p365)
    _G.EliteHunterHop = p365
end)
spawn(function()
    while wait() do
        if _G.Elitehunter and World3 then
            pcall(function()
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= true then
                    if _G.EliteHunterHop and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter") == "I don\'t have anything for you right now. Come back later." then
                        hop()
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                        local v366, v367, v368 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v369
                            v368, v369 = v366(v367, v368)
                            if v368 == nil then
                                break
                            end
                            if (v369.Name == "Diablo" or (v369.Name == "Deandre" or v369.Name == "Urban")) and (v369:FindFirstChild("Humanoid") and (v369:FindFirstChild("HumanoidRootPart") and v369.Humanoid.Health > 0)) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v369.HumanoidRootPart.CanCollide = false
                                    v369.Humanoid.WalkSpeed = 0
                                    TP2(v369.HumanoidRootPart.CFrame * CFrame.new(PosX, PosY, PosZ))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until _G.Elitehunter == false or (v369.Humanoid.Health <= 0 or not v369.Parent)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end
            end)
        end
    end
end)
v281.Mn:AddSection("Chest Farm")
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Chest",
    ["Default"] = false
})
Toggle:OnChanged(function(p370)
    _G.FarmChest = p370
    StopTween(_G.FarmChest)
end)
spawn(function()
    while wait() do
        if _G.FarmChest then
            local v371 = game:GetService("Players").LocalPlayer
            local v372 = (v371.Character or v371.CharacterAdded:Wait()):GetPivot().Position
            local v373 = game:GetService("CollectionService"):GetTagged("_ChestTagged")
            local v374 = math.huge
            local v375 = nil
            for v376 = 1, # v373 do
                local v377 = v373[v376]
                local v378 = (v377:GetPivot().Position - v372).Magnitude
                if not v377:GetAttribute("IsDisabled") then
                    if v378 < v374 then
                        v375 = v377
                        v374 = v378
                    end
                end
            end
            if v375 then
                local v379 = v375:GetPivot().Position
                local v380 = CFrame.new(v379)
                topos(v380)
            end
        end
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Farm Chest Bypass",
    ["Default"] = false
})
Toggle:OnChanged(function(p381)
    _G.ChestBypass = p381
end)
spawn(function()
    while true do
        if not wait() then
            return
        end
        if _G.ChestBypass then
            local v382 = game:GetService("Players").LocalPlayer
            local v383 = game:GetService("CollectionService")
            if not v382.Character then
                v382.CharacterAdded:Wait()
            end
            local v384 = tick()
            while tick() - v384 < 4 do
                local v385 = v382.Character or v382.CharacterAdded:Wait()
                local v386 = v385:GetPivot().Position
                local v387 = v383:GetTagged("_ChestTagged")
                local v388 = math.huge
                local v389 = nil
                for v390 = 1, # v387 do
                    local v391 = v387[v390]
                    local v392 = (v391:GetPivot().Position - v386).Magnitude
                    if not v391:GetAttribute("IsDisabled") then
                        if v392 < v388 then
                            v389 = v391
                            v388 = v392
                        end
                    end
                end
                if not v389 then
                    break
                end
                local v393 = v389:GetPivot().Position
                v385:PivotTo(CFrame.new(v393))
                task.wait(0.2)
            end
            if v382.Character then
                v382.Character:BreakJoints()
                v382.CharacterAdded:Wait()
            end
        end
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Stop Items",
    ["Default"] = false
})
Toggle:OnChanged(function(p394)
    _G.StopItemsChest = p394
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.StopItemsChest and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("God\'s Chalice") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fist of Darkness")) then
                _G.ChestBypass = false
                topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    end
end)
v281.Mn:AddSection("Pirates Raid")
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Pirates Raid",
    ["Default"] = false
})
Toggle:OnChanged(function(p395)
    _G.RaidPirate = p395
    StopTween(_G.RaidPirate)
end)
spawn(function()
    while wait() do
        if _G.RaidPirate then
            pcall(function()
                local v396 = CFrame.new(- 5496.17432, 363.768921, - 2841.53027)
                if (CFrame.new(- 5539.3115234375, 313.800537109375, - 2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                    topos(v396)
                else
                    local v397, v398, v399 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v400
                        v399, v400 = v397(v398, v399)
                        if v399 == nil then
                            break
                        end
                        if _G.RaidPirate and (v400:FindFirstChild("HumanoidRootPart") and (v400:FindFirstChild("Humanoid") and (v400.Humanoid.Health > 0 and (v400.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000))) then
                            repeat
                                task.wait()
                                EquipWeapon(_G.SelectWeapon)
                                v400.HumanoidRootPart.CanCollide = false
                                TP2(v400.HumanoidRootPart.CFrame * Pos)
                            until v400.Humanoid.Health <= 0 or not (v400.Parent and _G.RaidPirate)
                        end
                    end
                end
                topos(CFrame.new(- 5496.17432, 313.768921, - 2841.53027))
            end)
        end
    end
end)
v281.Mn:AddSection("Misc Bone")
local vu401 = {
    ["Reborn Skeleton"] = CFrame.new(- 8769.58984, 142.13063, 6055.27637),
    ["Living Zombie"] = CFrame.new(- 10156.4531, 138.652481, 5964.5752),
    ["Demonic Soul"] = CFrame.new(- 9525.17188, 172.13063, 6152.30566),
    ["Posessed Mummy"] = CFrame.new(- 9570.88281, 5.81831884, 6187.86279)
}
spawn(function()
	-- upvalues: (ref) vu401
    spawn(function()
		-- upvalues: (ref) vu401
        while task.wait(0.1) do
            if BonesBring then
                pcall(function()
					-- upvalues: (ref) vu401
                    local v402, v403, v404 = pairs(game.Workspace.Enemies:GetChildren())
                    while true do
                        local v405
                        v404, v405 = v402(v403, v404)
                        if v404 == nil then
                            break
                        end
                        if v405.Name == "Reborn Skeleton" or (v405.Name == "Living Zombie" or (v405.Name == "Demonic Soul" or v405.Name == "Posessed Mummy")) then
                            local v406 = vu401[v405.Name]
                            if v406 then
                                v405.HumanoidRootPart.CFrame = v406
                            end
                            v405.Head.CanCollide = false
                            v405.Humanoid.Sit = false
                            v405.Humanoid:ChangeState(14)
                            v405.HumanoidRootPart.CanCollide = false
                            v405.Humanoid.JumpPower = 0
                            v405.Humanoid.WalkSpeed = 0
                            if v405.Humanoid:FindFirstChild("Animator") then
                                v405.Humanoid:FindFirstChild("Animator"):Destroy()
                            end
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                end)
            end
        end
    end)
end)
local vu407 = v281.Mn:AddParagraph({
    ["Title"] = "Total Bone:",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu407
    while task.wait(2) do
        pcall(function()
			-- upvalues: (ref) vu407
            vu407:SetDesc("Total Bone: " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check"))
        end)
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Bone",
    ["Default"] = false
})
Toggle:OnChanged(function(p408)
    _G.Bone = p408
    StopTween(_G.Bone)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Accept Quest Bone",
    ["Default"] = true
})
Toggle:OnChanged(function(p409)
    _G.QuestBone = p409
end)
local vu410 = CFrame.new(- 9506.234375, 172.130615234375, 6117.0771484375)
spawn(function()
	-- upvalues: (ref) vu410
    while wait() do
        if _G.Bone and (not _G.QuestBone and World3) then
            pcall(function()
				-- upvalues: (ref) vu410
                if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy"))) then
                    local v411, v412, v413 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v414
                        v413, v414 = v411(v412, v413)
                        if v413 == nil then
                            break
                        end
                        if (v414.Name == "Reborn Skeleton" or (v414.Name == "Living Zombie" or (v414.Name == "Demonic Soul" or v414.Name == "Posessed Mummy"))) and (v414:FindFirstChild("Humanoid") and (v414:FindFirstChild("HumanoidRootPart") and v414.Humanoid.Health > 0)) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                v414.HumanoidRootPart.CanCollide = false
                                v414.Humanoid.WalkSpeed = 0
                                v414.Head.CanCollide = false
                                BonesBring = true
                                PosMonBone = v414.HumanoidRootPart.CFrame
                                TP2(v414.HumanoidRootPart.CFrame * Pos)
                            until not _G.Bone or (not v414.Parent or v414.Humanoid.Health <= 0)
                        end
                    end
                else
                    BonesBring = false
                    topos(vu410)
                    local v415, v416, v417 = pairs(game:GetService("ReplicatedStorage"):GetChildren())
                    while true do
                        local v418
                        v417, v418 = v415(v416, v417)
                        if v417 == nil then
                            break
                        end
                        if v418.Name ~= "Reborn Skeleton" then
                            if v418.Name ~= "Living Zombie" then
                                if v418.Name ~= "Demonic Soul" then
                                    if v418.Name == "Posessed Mummy" then
                                        TP2(v418.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                    end
                                else
                                    TP2(v418.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                end
                            else
                                TP2(v418.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                            end
                        else
                            TP2(v418.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end
            end)
        end
    end
end)
local vu419 = CFrame.new(- 9515.75, 174.8521728515625, 6079.40625)
spawn(function()
	-- upvalues: (ref) vu419
    while wait() do
        if _G.Bone and (_G.QuestBone and World3) then
            pcall(function()
				-- upvalues: (ref) vu419
                local v420 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                if not string.find(v420, "Demonic Soul") then
                    BonesBring = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy"))) then
                            local v421, v422, v423 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v424
                                v423, v424 = v421(v422, v423)
                                if v423 == nil then
                                    break
                                end
                                if v424:FindFirstChild("HumanoidRootPart") and (v424:FindFirstChild("Humanoid") and (v424.Humanoid.Health > 0 and (v424.Name == "Reborn Skeleton" or (v424.Name == "Living Zombie" or (v424.Name == "Demonic Soul" or v424.Name == "Posessed Mummy"))))) then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                                        repeat
                                            task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            PosMonBone = v424.HumanoidRootPart.CFrame
                                            TP2(v424.HumanoidRootPart.CFrame * Pos)
                                            v424.HumanoidRootPart.CanCollide = false
                                            v424.Humanoid.WalkSpeed = 0
                                            v424.Head.CanCollide = false
                                            BonesBring = true
                                        until not _G.Bone or (v424.Humanoid.Health <= 0 or not v424.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        BonesBring = false
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                    end
                                end
                            end
                        else
                            BonesBring = false
                            if game:GetService("ReplicatedStorage"):FindFirstChild("Demonic Soul [Lv. 2025]") then
                                topos(game:GetService("ReplicatedStorage"):FindFirstChild("Demonic Soul [Lv. 2025]").HumanoidRootPart.CFrame * CFrame.new(15, 10, 2))
                            end
                        end
                    end
                else
                    BonesBring = false
                    topos(vu419)
                    if (vu419.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest2", 1)
                    end
                end
            end)
        end
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Random Surprise",
    ["Default"] = false
})
Toggle:OnChanged(function(p425)
    _G.Random_Bone = p425
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.Random_Bone then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
            end
        end
    end)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Pray",
    ["Default"] = false
})
Toggle:OnChanged(function(p426)
    _G.Pray = p426
    StopTween(_G.Pray)
end)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Pray then
                TP1(CFrame.new(- 8652.99707, 143.450119, 6170.50879, - 0.983064115, - 2.48005533e-10, 0.18326205, - 1.78910387e-9, 1, - 8.24392288e-9, - 0.18326205, - 8.43218029e-9, - 0.983064115))
                wait()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 1)
            end
        end
    end)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Try Luck",
    ["Default"] = false
})
Toggle:OnChanged(function(p427)
    _G.Trylux = p427
    StopTween(_G.Trylux)
end)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Trylux then
                TP1(CFrame.new(- 8652.99707, 143.450119, 6170.50879, - 0.983064115, - 2.48005533e-10, 0.18326205, - 1.78910387e-9, 1, - 8.24392288e-9, - 0.18326205, - 8.43218029e-9, - 0.983064115))
                wait()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
            end
        end
    end)
end)
v281.Mn:AddSection("Dought Boss")
local vu428 = {
    ["Cookie Crafter"] = CFrame.new(- 2333.28052, 37.8239059, - 12093.2861),
    ["Cake Guard"] = CFrame.new(- 1575.56433, 37.8238907, - 12416.2529),
    ["Baking Staff"] = CFrame.new(- 1872.35742, 37.8239517, - 12899.4248),
    ["Head Baker"] = CFrame.new(- 2223.1416, 53.5283203, - 12854.752)
}
spawn(function()
	-- upvalues: (ref) vu428
    spawn(function()
		-- upvalues: (ref) vu428
        while task.wait(0.1) do
            if CakeBring then
                pcall(function()
					-- upvalues: (ref) vu428
                    local v429, v430, v431 = pairs(game.Workspace.Enemies:GetChildren())
                    while true do
                        local v432
                        v431, v432 = v429(v430, v431)
                        if v431 == nil then
                            break
                        end
                        if v432.Name == "Cookie Crafter" or (v432.Name == "Cake Guard" or (v432.Name == "Baking Staff" or v432.Name == "Head Baker")) then
                            local v433 = vu428[v432.Name]
                            if v433 then
                                v432.HumanoidRootPart.CFrame = v433
                            end
                            v432.Head.CanCollide = false
                            v432.Humanoid.Sit = false
                            v432.Humanoid:ChangeState(14)
                            v432.HumanoidRootPart.CanCollide = false
                            v432.Humanoid.JumpPower = 0
                            v432.Humanoid.WalkSpeed = 0
                            if v432.Humanoid:FindFirstChild("Animator") then
                                v432.Humanoid:FindFirstChild("Animator"):Destroy()
                            end
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                end)
            end
        end
    end)
end)
local vu434 = v281.Mn:AddParagraph({
    ["Title"] = "Killed",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu434
    while task.wait(2) do
        pcall(function()
			-- upvalues: (ref) vu434
            if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) ~= 88 then
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) ~= 87 then
                    if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) ~= 86 then
                        vu434:SetDesc("Boss Is Spawning")
                    else
                        vu434:SetDesc("Defeat: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 39))
                    end
                else
                    vu434:SetDesc("Defeat: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 40))
                end
            else
                vu434:SetDesc("Defeat: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 41))
            end
        end)
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Cake Prince",
    ["Default"] = false
})
Toggle:OnChanged(function(p435)
    _G.DoughtBoss = p435
    StopTween(_G.DoughtBoss)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Accept Quest Cake Prince",
    ["Default"] = true
})
Toggle:OnChanged(function(p436)
    _G.QuestCake = p436
end)
spawn(function()
    while wait() do
        if _G.DoughtBoss and not _G.QuestCake then
            pcall(function()
                local v437 = CFrame.new(- 2091.911865234375, 70.00884246826172, - 12142.8359375)
                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                    local v438, v439, v440 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v441
                        v440, v441 = v438(v439, v440)
                        if v440 == nil then
                            break
                        end
                        if (v441.Name == "Cake Prince" or v441.Name == "Dough King") and (v441:FindFirstChild("Humanoid") and (v441:FindFirstChild("HumanoidRootPart") and v441.Humanoid.Health > 0)) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                v441.HumanoidRootPart.CanCollide = false
                                v441.Humanoid.WalkSpeed = 0
                                TP2(v441.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.DoughtBoss or (not v441.Parent or v441.Humanoid.Health <= 0)
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Dough King").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                elseif game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or (game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or (game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker"))) then
                    local v442, v443, v444 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v445
                        v444, v445 = v442(v443, v444)
                        if v444 == nil then
                            break
                        end
                        if (v445.Name == "Cookie Crafter" or (v445.Name == "Cake Guard" or (v445.Name == "Baking Staff" or v445.Name == "Head Baker"))) and (v445:FindFirstChild("Humanoid") and (v445:FindFirstChild("HumanoidRootPart") and v445.Humanoid.Health > 0)) then
                            repeat
                                task.wait()
                                EquipWeapon(_G.SelectWeapon)
                                v445.HumanoidRootPart.CanCollide = false
                                v445.Humanoid.WalkSpeed = 0
                                v445.Head.CanCollide = false
                                CakeBring = true
                                PosMonDoughtOpenDoor = v445.HumanoidRootPart.CFrame
                                TP2(v445.HumanoidRootPart.CFrame * Pos)
                            until not _G.DoughtBoss or (not v445.Parent or v445.Humanoid.Health <= 0) or (game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or (game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or KillMob == 0))
                        end
                    end
                else
                    CakeBring = false
                    topos(v437)
                    if game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Guard") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Guard").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Baking Staff") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Baking Staff").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Head Baker") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Head Baker").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if _G.DoughtBoss and (_G.QuestCake and World3) then
            pcall(function()
                local v446 = CFrame.new(- 2021.32007, 37.7982254, - 12028.7295, 0.957576931, - 8.80302053e-8, 0.288177818, 6.9301187e-8, 1, 7.51931211e-8, - 0.288177818, - 5.2032135e-8, 0.957576931)
                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                    local v447, v448, v449 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v450
                        v449, v450 = v447(v448, v449)
                        if v449 == nil then
                            break
                        end
                        if (v450.Name == "Cake Prince" or v450.Name == "Dough King") and (v450:FindFirstChild("Humanoid") and (v450:FindFirstChild("HumanoidRootPart") and v450.Humanoid.Health > 0)) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                v450.HumanoidRootPart.CanCollide = false
                                v450.Humanoid.WalkSpeed = 0
                                TP2(v450.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.DoughtBoss or (not v450.Parent or v450.Humanoid.Health <= 0)
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Dough King").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                else
                    local v451 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    if not string.find(v451, "Cookie Crafter") then
                        CakeBring = false
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or (game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or (game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker"))) then
                                local v452, v453, v454 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                while true do
                                    local v455
                                    v454, v455 = v452(v453, v454)
                                    if v454 == nil then
                                        break
                                    end
                                    if v455:FindFirstChild("HumanoidRootPart") and (v455:FindFirstChild("Humanoid") and (v455.Humanoid.Health > 0 and (v455.Name == "Cookie Crafter" or (v455.Name == "Cake Guard" or (v455.Name == "Baking Staff" or v455.Name == "Head Baker"))))) then
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Cookie Crafter") then
                                            repeat
                                                wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                TP2(v455.HumanoidRootPart.CFrame * Pos)
                                                v455.HumanoidRootPart.CanCollide = false
                                                v455.Humanoid.WalkSpeed = 0
                                                v455.Head.CanCollide = false
                                                CakeBring = true
                                                PosMonDoughtOpenDoor = v455.HumanoidRootPart.CFrame
                                            until not (_G.DoughtBoss and v455.Parent) or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or v455.Humanoid.Health <= 0 or (game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or (game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or KillMob == 0)))
                                        else
                                            CakeBring = false
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        end
                                    end
                                end
                            else
                                CakeBring = false
                                if game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter") then
                                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter").HumanoidRootPart.CFrame * CFrame.new(15, 10, 2))
                                end
                            end
                        end
                    else
                        CakeBring = false
                        topos(v446)
                        if (v446.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CakeQuest1", 1)
                        end
                    end
                end
            end)
        end
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Spawn Cake Prince",
    ["Default"] = false
})
Toggle:OnChanged(function(p456)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", p456)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Dough King Raid",
    ["Default"] = false
})
Toggle:OnChanged(function(p457)
    _G.DoughKingRaid = p457
    StopTween(_G.DoughKingRaid)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Dough King Hop",
    ["Default"] = false
})
Toggle:OnChanged(function(p458)
    _G.doughkingHop = p458
end)
spawn(function()
    while wait() do
        if _G.DoughKingRaid then
            pcall(function()
                if game.Players.LocalPlayer.Backpack:FindFirstChild("God\'s Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God\'s Chalice") then
                    if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SweetChaliceNpc"), "Where") then
                        game.StarterGui:SetCore("SendNotification", {
                            ["Title"] = "Notification",
                            ["Text"] = "Not Have Enough Material",
                            ["Icon"] = "http://www.roblox.com/asset/?id=",
                            ["Duration"] = 2.5
                        })
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                    end
                elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") then
                    if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "Do you want to open the portal now?") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    elseif game.Workspace.Enemies:FindFirstChild("Baking Staff") or (game.Workspace.Enemies:FindFirstChild("Head Baker") or (game.Workspace.Enemies:FindFirstChild("Cake Guard") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter"))) then
                        local v459, v460, v461 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v462
                            v461, v462 = v459(v460, v461)
                            if v461 == nil then
                                break
                            end
                            if (v462.Name == "Baking Staff" or (v462.Name == "Head Baker" or (v462.Name == "Cake Guard" or v462.Name == "Cookie Crafter"))) and v462.Humanoid.Health > 0 then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    CakeBring = true
                                    PosMonDoughtOpenDoor = v462.HumanoidRootPart.CFrame
                                    TP2(v462.HumanoidRootPart.CFrame * Pos)
                                until _G.DoughKingRaid == false or (game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or (not v462.Parent or v462.Humanoid.Health <= 0))
                            end
                        end
                    else
                        CakeBring = false
                        topos(CFrame.new(- 1820.0634765625, 210.74781799316406, - 12297.49609375))
                    end
                elseif game.ReplicatedStorage:FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                        local v463, v464, v465 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v466
                            v465, v466 = v463(v464, v465)
                            if v465 == nil then
                                break
                            end
                            if v466.Name == "Dough King" then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v466.HumanoidRootPart.CanCollide = false
                                    TP2(v466.HumanoidRootPart.CFrame * Pos)
                                until _G.DoughKingRaid == false or (not v466.Parent or v466.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(CFrame.new(- 2009.2802734375, 4532.97216796875, - 14937.3076171875))
                    end
                elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") or game.Players.LocalPlayer.Character:FindFirstChild("Red Key") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "CakeScientist",
                        "Check"
                    }))
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= true then
                    if _G.doughkingHop and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter") == "I don\'t have anything for you right now. Come back later." then
                        hop()
                    else
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                        local v467, v468, v469 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v470
                            v469, v470 = v467(v468, v469)
                            if v469 == nil then
                                break
                            end
                            if (v470.Name == "Diablo" or (v470.Name == "Deandre" or v470.Name == "Urban")) and (v470:FindFirstChild("Humanoid") and (v470:FindFirstChild("HumanoidRootPart") and v470.Humanoid.Health > 0)) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v470.HumanoidRootPart.CanCollide = false
                                    v470.Humanoid.WalkSpeed = 0
                                    TP2(v470.HumanoidRootPart.CFrame * CFrame.new(PosX, PosY, PosZ))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until _G.DoughKingRaid == false or (v470.Humanoid.Health <= 0 or not v470.Parent) or (game.Players.LocalPlayer.Backpack:FindFirstChild("God\'s Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God\'s Chalice"))
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end
            end)
        end
    end
end)
v281.Mn:AddSection("Misc Mastery")
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Mastery Fruit (Delete Function)",
    ["Default"] = false
})
Toggle:OnChanged(function(p471)
    _G.FarmFruitMastery = p471
    StopTween(_G.FarmFruitMastery)
    if not _G.FarmFruitMastery then
        UseSkill = false
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Mastery Gun (Delete Function)",
    ["Default"] = false
})
Toggle:OnChanged(function(p472)
    _G.FarmGunMastery = p472
    StopTween(_G.FarmGunMastery)
end)
v281.Mn:AddSection("Observation")
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Observation",
    ["Default"] = false
})
Toggle:OnChanged(function(p473)
    _G.Observation = p473
    StopTween(_G.Observation)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Observation Hop",
    ["Default"] = false
})
Toggle:OnChanged(function(p474)
    _G.Observation_Hop = p474
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Observation then
                while true do
                    task.wait()
                    if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):SetKeyDown("0x65")
                        wait(2)
                        game:GetService("VirtualUser"):SetKeyUp("0x65")
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or not _G.Observation then
						-- goto l3
                    end
                end
            else
				-- ::l3::
                return
            end
        end)
    end
end)
spawn(function()
    pcall(function()
		-- ::l0::
        while true do
            repeat
                if not wait() then
                    return
                end
            until _G.Observation
            if game:GetService("Players").LocalPlayer.VisionRadius.Value < 3000 then
                break
            end
            wait(2)
        end
		-- ::l8::
        if not World2 then
			-- goto l11
        end
        if not game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate [Lv. 1200]") then
			-- goto l14
        end
        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
			-- goto l17
        end
        task.wait()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
        if _G.Observation ~= false and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
			-- goto l17
        end
		-- goto l0
		-- ::l11::
        if not World1 then
			-- goto l32
        end
        if game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain") then
            if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                task.wait()
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
                if _G.Observation ~= false and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
					-- goto l38
                end
            else
				-- ::l38::
                task.wait()
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                wait(1)
                if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.Observation_Hop == true then
                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                end
                if _G.Observation ~= false and not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
					-- goto l35
                end
            end
        else
			-- ::l35::
            topos(CFrame.new(5533.29785, 88.1079102, 4852.3916))
        end
		-- goto l0
		-- ::l32::
        if not World3 then
			-- goto l0
        end
        if not game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander") then
			-- goto l54
        end
        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
			-- goto l57
        end
        repeat
            task.wait()
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
        until _G.Observation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
		-- goto l0
		-- ::l57::
        task.wait()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
        wait(1)
        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.Observation_Hop == true then
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
        if _G.Observation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
			-- goto l0
        else
			-- goto l57
        end
		-- ::l54::
        topos(CFrame.new(4530.3540039063, 656.75695800781, - 131.60952758789))
		-- goto l0
		-- ::l17::
        task.wait()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0) + wait(1)
        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.Observation_Hop == true then
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
        if _G.Observation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
			-- goto l0
        else
			-- goto l17
        end
		-- ::l14::
        topos(CFrame.new(- 5478.39209, 15.9775667, - 5246.9126))
		-- goto l0
    end)
end)
v281.Mn:AddSection("Boss")
local vu475 = v281.Mn:AddParagraph({
    ["Title"] = "Status",
    ["Content"] = ""
})
spawn(function()
	-- upvalues: (ref) vu475
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu475
            if game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) or game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                vu475:SetDesc("Status : Spawn!")
            else
                vu475:SetDesc("Status : Boss Not Spawn")
            end
        end)
    end
end)
if World1 then
    Dropdown = v281.Mn:AddDropdown("Dropdown", {
        ["Title"] = "Select Boss",
        ["Values"] = {
            "The Saw",
            "The Gorilla King",
            "Bobby",
            "Yeti",
            "Mob Leader",
            "Vice Admiral",
            "Warden",
            "Chief Warden",
            "Swan",
            "Magma Admiral",
            "Fishman Lord",
            "Wysper",
            "Thunder God",
            "Cyborg",
            "Saber Expert"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue(false)
    Dropdown:OnChanged(function(p476)
        _G.SelectBoss = p476
    end)
end
if World2 then
    Dropdown = v281.Mn:AddDropdown("Dropdown", {
        ["Title"] = "Select Boss",
        ["Values"] = {
            "Diamond",
            "Jeremy",
            "Fajita",
            "Don Swan",
            "Smoke Admiral",
            "Cursed Captain",
            "Darkbeard",
            "Order",
            "Awakened Ice Admiral",
            "Tide Keeper"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue(false)
    Dropdown:OnChanged(function(p477)
        _G.SelectBoss = p477
    end)
end
if World3 then
    Dropdown = v281.Mn:AddDropdown("Dropdown", {
        ["Title"] = "Select Boss",
        ["Values"] = {
            "Stone",
            "Island Empress",
            "Kilo Admiral",
            "Captain Elephant",
            "Beautiful Pirate",
            "rip_indra True Form",
            "Longma",
            "Soul Reaper",
            "Cake Queen"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue(false)
    Dropdown:OnChanged(function(p478)
        _G.SelectBoss = p478
    end)
end
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm Boss",
    ["Default"] = false
})
Toggle:OnChanged(function(p479)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    _G.FarmBoss = p479
    StopTween(_G.FarmBoss)
end)
spawn(function()
    while wait() do
        if _G.FarmBoss and not BypassTP then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    local v480, v481, v482 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v483
                        v482, v483 = v480(v481, v482)
                        if v482 == nil then
                            break
                        end
                        if v483.Name == _G.SelectBoss and (v483:FindFirstChild("Humanoid") and (v483:FindFirstChild("HumanoidRootPart") and v483.Humanoid.Health > 0)) then
                            repeat
                                task.wait()
                                EquipWeapon(_G.SelectWeapon)
                                v483.HumanoidRootPart.CanCollide = false
                                v483.Humanoid.WalkSpeed = 0
                                TP2(v483.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.FarmBoss or (not v483.Parent or v483.Humanoid.Health <= 0)
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
                end
            end)
        end
    end
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm All Boss",
    ["Default"] = false
})
Toggle:OnChanged(function(p484)
    _G.AllBoss = p484
    StopTween(_G.AllBoss)
end)
Toggle = v281.Mn:AddToggle("Toggle", {
    ["Title"] = "Auto Farm All Boss Hop",
    ["Default"] = false
})
Toggle:OnChanged(function(p485)
    _G.AllBossHop = p485
end)
spawn(function()
    while wait() do
        if _G.AllBoss then
            pcall(function()
                local v486, v487, v488 = pairs(game.ReplicatedStorage:GetChildren())
                while true do
                    while true do
                        local v489
                        v488, v489 = v486(v487, v488)
                        if v488 == nil then
                            return
                        end
                        if v489.Name == "rip_indra" or (v489.Name == "Ice Admiral" or (v489.Name == "Saber Expert" or (v489.Name == "The Saw" or (v489.Name == "Greybeard" or (v489.Name == "Mob Leader" or (v489.Name == "The Gorilla King" or (v489.Name == "Bobby" or (v489.Name == "Yeti" or (v489.Name == "Vice Admiral" or (v489.Name == "Warden" or (v489.Name == "Chief Warden" or (v489.Name == "Swan" or (v489.Name == "Magma Admiral" or (v489.Name == "Fishman Lord" or (v489.Name == "Wysper" or (v489.Name == "Thunder God" or (v489.Name == "Cyborg" or (v489.Name == "Don Swan" or (v489.Name == "Diamond" or (v489.Name == "Jeremy" or (v489.Name == "Fajita" or (v489.Name == "Smoke Admiral" or (v489.Name == "Awakened Ice Admiral" or (v489.Name == "Tide Keeper" or (v489.Name == "Order" or (v489.Name == "Darkbeard" or (v489.Name == "Stone" or (v489.Name == "Island Empress" or (v489.Name == "Kilo Admiral" or (v489.Name == "Captain Elephant" or (v489.Name == "Beautiful Pirate" or (v489.Name == "Cake Queen" or (v489.Name == "rip_indra True Form" or (v489.Name == "Longma" or (v489.Name == "Soul Reaper" or (v489.Name == "Cake Prince" or v489.Name == "Dough King")))))))))))))))))))))))))))))))))))) then
                            break
                        end
						-- ::l79::
                        if _G.AllBossHop then
                            Hop()
                        end
                    end
                    if (v489.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 17000 then
                        task.wait()
                        EquipWeapon(_G.SelectWeapon)
                        v489.Humanoid.WalkSpeed = 0
                        v489.HumanoidRootPart.CanCollide = false
                        v489.Head.CanCollide = false
                        TP2(v489.HumanoidRootPart.CFrame * Pos)
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        if v489.Humanoid.Health > 0 and (_G.AllBoss ~= false and v489.Parent) then
							-- goto l79
                        end
                    end
                end
            end)
        end
    end
end)
v281.St:AddSection("Speed Tween")
v281.St:AddSlider("Slider", {
    ["Title"] = "Tween Speed",
    ["Min"] = 50,
    ["Max"] = 350,
    ["Default"] = 350,
    ["Rounding"] = 5,
    ["Callback"] = function(p490)
        getgenv().TweenSpeed = p490
    end
})
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "High Tween PosY",
    ["Default"] = false
})
Toggle:OnChanged(function(p491)
    getgenv().TweenPosY = p491
end)
v281.St:AddButton({
    ["Title"] = "Stop All Tween",
    ["Description"] = "",
    ["Callback"] = function()
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        _G.Clip = false
    end
})
v281.St:AddSection("Setting Farming")
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Auto Click",
    ["Default"] = false
})
Toggle:OnChanged(function(p492)
    _G.AutoClick = p492
end)
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.AutoClick then
            pcall(function()
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait()
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
        end
    end)
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Bring Mob",
    ["Default"] = true
})
Toggle:OnChanged(function(p493)
    _G.BringMonster = p493
end)
spawn(function()
	-- upvalues: (ref) vu87
    while task.wait(0.1) do
        if _G.BringMonster then
            pcall(function()
				-- upvalues: (ref) vu87
                vu87()
                local v494, v495, v496 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                while true do
                    local v497
                    v496, v497 = v494(v495, v496)
                    if v496 == nil then
                        break
                    end
                    if v497:FindFirstChild("Humanoid") and (v497:FindFirstChild("HumanoidRootPart") and v497.Humanoid.Health > 0) then
                        local v498 = false
                        if _G.Level and (StartMagnetLv and (v497.Name == Mon and not v498)) then
                            v498 = (v497.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= _G.BringMode
                        end
                        if v498 then
                            v497.HumanoidRootPart.CFrame = PosMonLv
                            v497.HumanoidRootPart.CanCollide = false
                            v497.Head.CanCollide = false
                            v497.Humanoid.JumpPower = 0
                            v497.Humanoid.WalkSpeed = 0
                            v497.Humanoid:ChangeState(14)
                            if v497.Humanoid:FindFirstChild("Animator") then
                                v497.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait(0.1) do
        if StartMagnet then
            pcall(function()
                local v499, v500, v501 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                while true do
                    local v502
                    v501, v502 = v499(v500, v501)
                    if v501 == nil then
                        break
                    end
                    if v502:FindFirstChild("Humanoid") and (v502:FindFirstChild("HumanoidRootPart") and (v502.HumanoidRootPart.Position - _G.PosMon.Position).Magnitude <= _G.BringMode) then
                        v502.HumanoidRootPart.CFrame = _G.PosMon
                        v502.HumanoidRootPart.CanCollide = false
                        v502.Humanoid.JumpPower = 0
                        v502.Humanoid.WalkSpeed = 0
                        v502.Humanoid:ChangeState(14)
                        if v502.Humanoid:FindFirstChild("Animator") then
                            v502.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game.Players.LocalPlayer, "MaximumSimulationRadius", math.huge)
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                    end
                end
            end)
        end
    end
end)
Dropdown = v281.St:AddDropdown("Dropdown", {
    ["Title"] = "Bring Mob Mode",
    ["Values"] = {
        "Low",
        "Normal",
        "Super Bring"
    },
    ["Multi"] = false
})
Dropdown:SetValue("Normal")
Dropdown:OnChanged(function(p503)
    _G.BringMode = p503
end)
spawn(function()
    while wait(0.1) do
        if _G.BringMode then
            pcall(function()
                if _G.BringMode ~= "Low" then
                    if _G.BringMode ~= "Normal" then
                        if _G.BringMode == "Super Bring" then
                            _G.BringMode = 300
                        end
                    else
                        _G.BringMode = 200
                    end
                else
                    _G.BringMode = 100
                end
            end)
        end
    end
end)
v281.St:AddSlider("Slider", {
    ["Title"] = "Select PosY Framing",
    ["Min"] = 1,
    ["Max"] = 100,
    ["Default"] = 25,
    ["Rounding"] = 5,
    ["Callback"] = function(p504)
        PosY = p504
    end
})
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Auto Haki",
    ["Default"] = true
})
Toggle:OnChanged(function(p505)
    _G.Haki = p505
end)
spawn(function()
    while task.wait(0.1) do
        if _G.Haki and not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "Buso"
            }))
        end
    end
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Auto Ken",
    ["Default"] = false
})
Toggle:OnChanged(function(p506)
    _G.Ken = p506
end)
spawn(function()
    while wait() do
        if _G.Ken == true then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
            end)
        end
    end
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Disabled Notifications",
    ["Default"] = false
})
Toggle:OnChanged(function(p507)
    _G.Remove_trct = p507
end)
spawn(function()
    while wait() do
        if _G.Remove_trct then
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
        else
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
        end
    end
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Disabled Damage Counter",
    ["Default"] = false
})
Toggle:OnChanged(function(p508)
    _G.DisabledDame = p508
end)
spawn(function()
    while wait() do
        if _G.DisabledDame then
            game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
        else
            game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = true
        end
    end
end)
local vu509 = Instance.new("BlurEffect")
vu509.Size = 100
vu509.Enabled = false
vu509.Parent = game.Lighting
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Fix Lag Screen",
    ["Default"] = false
})
Toggle:OnChanged(function(p510)
	-- upvalues: (ref) vu509
    vu509.Enabled = p510
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "White Screen",
    ["Default"] = false
})
Toggle:OnChanged(function(p511)
    _G.WhiteScreen = p511
    game:GetService("RunService"):Set3dRenderingEnabled(not _G.WhiteScreen)
end)
spawn(function()
    while wait() do
        if _G.WhiteScreen then
            local v512, v513, v514 = pairs(game.Workspace._WorldOrigin:GetChildren())
            while true do
                local v515
                v514, v515 = v512(v513, v514)
                if v514 == nil then
                    break
                end
                if v515.Name == "CurvedRing" or (v515.Name == "SlashHit" or (v515.Name == "DamageCounter" or (v515.Name == "SwordSlash" or (v515.Name == "SlashTail" or v515.Name == "Sounds")))) then
                    v515:Destroy()
                end
            end
        end
    end
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Hide Mobs",
    ["Description"] = "",
    ["Default"] = false
})
Toggle:OnChanged(function(p516)
    _G.hadesinvis = p516
end)
spawn(function()
    while wait() do
        if _G.hadesinvis then
            pcall(function()
                local v517, v518, v519 = pairs(game:GetService("Workspace").Enemies:GetDescendants())
                while true do
                    local v520
                    v519, v520 = v517(v518, v519)
                    if v519 == nil then
                        break
                    end
                    if v520.ClassName == "MeshPart" then
                        v520.Transparency = 1
                    end
                end
                local v521, v522, v523 = pairs(game:GetService("Workspace").Enemies:GetDescendants())
                while true do
                    local v524
                    v523, v524 = v521(v522, v523)
                    if v523 == nil then
                        break
                    end
                    if v524.Name == "Head" then
                        v524.Transparency = 1
                    end
                end
                local v525, v526, v527 = pairs(game:GetService("Workspace").Enemies:GetDescendants())
                while true do
                    local v528
                    v527, v528 = v525(v526, v527)
                    if v527 == nil then
                        break
                    end
                    if v528.ClassName == "Accessory" then
                        v528.Handle.Transparency = 1
                    end
                end
                local v529, v530, v531 = pairs(game:GetService("Workspace").Enemies:GetDescendants())
                while true do
                    local v532
                    v531, v532 = v529(v530, v531)
                    if v531 == nil then
                        break
                    end
                    if v532.ClassName == "Decal" then
                        v532.Transparency = 1
                    end
                end
            end)
        end
    end
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Fps Boost",
    ["Default"] = false
})
Toggle:OnChanged(function(p533)
    if p533 then
        cleanlag()
    end
end)
function cleanlag()
    spawn(function()
        local v534, v535, v536 = pairs(workspace:GetDescendants())
        while true do
            local v537
            v536, v537 = v534(v535, v536)
            if v536 == nil then
                break
            end
            if v537.ClassName == "Part" or (v537.ClassName == "SpawnLocation" or (v537.ClassName == "WedgePart" or v537.ClassName == "Terrain")) then
                v537.Material = "Plastic"
            end
        end
        local v538, v539, v540 = pairs(game:GetDescendants())
        while true do
            local v541
            v540, v541 = v538(v539, v540)
            if v540 == nil then
                break
            end
            if v541:IsA("Texture") then
                v541.Texture = ""
            elseif v541:IsA("BasePart") then
                v541.Material = "Plastic"
            end
        end
        local v542, v543, v544 = pairs(Players.LocalPlayer.PlayerScripts:GetDescendants())
        while true do
            local v545
            v544, v545 = v542(v543, v544)
            if v544 == nil then
                break
            end
            if table.find({
                "RecordMode",
                "Fireflies",
                "Wind",
                "WindShake",
                "WindLines",
                "WaterBlur",
                "WaterEffect",
                "wave",
                "WaterColorCorrection",
                "WaterCFrame",
                "MirageFog",
                "MobileButtonTransparency",
                "WeatherStuff",
                "AnimateEntrance",
                "Particle",
                "AccessoryInvisible"
            }, v545.Name) then
                v545:Destroy()
            end
        end
    end)
end
v281.St:AddSection("Setting Farm Mastery")
v281.St:AddSlider("Slider", {
    ["Title"] = "Select % Health Mob",
    ["Min"] = 10,
    ["Max"] = 100,
    ["Default"] = 20,
    ["Rounding"] = 5,
    ["Callback"] = function(p546)
        Kill_At = p546
    end
})
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Skill Z",
    ["Default"] = true
})
Toggle:OnChanged(function(p547)
    _G.SkillZ = p547
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Skill X",
    ["Default"] = true
})
Toggle:OnChanged(function(p548)
    _G.SkillX = p548
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Skill C",
    ["Default"] = true
})
Toggle:OnChanged(function(p549)
    _G.SkillC = p549
end)
Toggle = v281.St:AddToggle("Toggle", {
    ["Title"] = "Skill V",
    ["Default"] = true
})
Toggle:OnChanged(function(p550)
    _G.SkillV = p550
end)
if World1 or World2 then
    v281.M:AddSection("World")
end
if World1 then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Second Sea",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p551)
        _G.SecondSea = p551
        StopTween(_G.SecondSea)
    end)
    spawn(function()
        while wait() do
            if _G.SecondSea then
                pcall(function()
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 700 and World1 then
                        if game:GetService("Workspace").Map.Ice.Door.CanCollide == false and game:GetService("Workspace").Map.Ice.Door.Transparency == 1 then
                            local v552 = CFrame.new(4849.29883, 5.65138149, 719.611877)
                            repeat
                                topos(v552)
                                wait()
                            until (v552.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.SecondSea == false
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                            wait(0.5)
                            EquipWeapon("Key")
                            repeat
                                topos(CFrame.new(1347.7124, 37.3751602, - 1325.6488))
                                wait()
                            until (Vector3.new(1347.7124, 37.3751602, - 1325.6488) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.SecondSea == false
                            wait(0.5)
							-- goto l3
                        end
                        if game:GetService("Workspace").Map.Ice.Door.CanCollide ~= false or game:GetService("Workspace").Map.Ice.Door.Transparency ~= 1 then
							-- goto l3
                        end
                        if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral") then
                            local v553, v554, v555 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v556
                                v555, v556 = v553(v554, v555)
                                if v555 == nil then
                                    break
                                end
                                if v556.Name == "Ice Admiral" then
                                    if not v556.Humanoid.Health > 0 then
										-- ::l34::
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                    elseif v556:FindFirstChild("Humanoid") and (v556:FindFirstChild("HumanoidRootPart") and v556.Humanoid.Health > 0) then
                                        OldCFrameSecond = v556.HumanoidRootPart.CFrame
                                        task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        v556.HumanoidRootPart.CanCollide = false
                                        v556.Humanoid.WalkSpeed = 0
                                        v556.Head.CanCollide = false
                                        v556.HumanoidRootPart.CFrame = OldCFrameSecond
                                        TP2(v556.HumanoidRootPart.CFrame * Pos)
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                        if _G.SecondSea and (v556.Parent and v556.Humanoid.Health > 0) then
											-- goto l34
                                        end
                                    end
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral").HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
                        end
                    end
					-- ::l3::
                end)
            end
        end
    end)
end
if World2 then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Third Sea",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p557)
        _G.ThirdSea = p557
        StopTween(_G.ThirdSea)
    end)
    spawn(function()
        while wait() do
            if _G.ThirdSea then
                pcall(function()
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 and World2 then
                        _G.Level = false
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "General") == 0 then
                            topos(CFrame.new(- 1926.3221435547, 12.819851875305, 1738.3092041016))
                            if (CFrame.new(- 1926.3221435547, 12.819851875305, 1738.3092041016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                wait(1.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                            end
                            wait(1.8)
                            if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                                local v558, v559, v560 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                while true do
                                    local v561
                                    v560, v561 = v558(v559, v560)
                                    if v560 == nil then
                                        break
                                    end
                                    if v561.Name == "rip_indra" then
                                        OldCFrameThird = v561.HumanoidRootPart.CFrame
                                        repeat
                                            task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            TP2(v561.HumanoidRootPart.CFrame * Pos)
                                            v561.HumanoidRootPart.CFrame = OldCFrameThird
                                            v561.HumanoidRootPart.CanCollide = false
                                            v561.Humanoid.WalkSpeed = 0
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                        until _G.ThirdSea == false or (v561.Humanoid.Health <= 0 or not v561.Parent)
                                    end
                                end
                            elseif not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") and (CFrame.new(- 26880.93359375, 22.848554611206, 473.18951416016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                topos(CFrame.new(- 26880.93359375, 22.848554611206, 473.18951416016))
                            end
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Factory",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p562)
        _G.Factory = p562
        StopTween(_G.Factory)
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.Factory then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Core") then
                        local v563, v564, v565 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v566
                            v565, v566 = v563(v564, v565)
                            if v565 == nil then
                                break
                            end
                            if v566.Name == "Core" and v566.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(CFrame.new(448.46756, 199.356781, - 441.389252))
                                until v566.Humanoid.Health <= 0 or _G.Factory == false
                            end
                        end
                    else
                        topos(CFrame.new(448.46756, 199.356781, - 441.389252))
                    end
                end
            end)
        end
    end)
end
v281.M:AddSection("Fighting Style")
Toggle = v281.M:AddToggle("Toggle", {
    ["Title"] = "Auto Superhuman",
    ["Default"] = false
})
Toggle:OnChanged(function(p567)
    _G.Superhuman = p567
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.Superhuman then
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 150000 then
                    UnEquipWeapon("Combat")
                    wait(0.1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                end
                if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
                    _G.SelectWeapon = "Superhuman"
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or (game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or (game.Players.LocalPlayer.Character:FindFirstChild("Electro") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or (game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw"))))))) then
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 299 then
                        _G.SelectWeapon = "Black Leg"
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 299 then
                        _G.SelectWeapon = "Electro"
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value <= 299 then
                        _G.SelectWeapon = "Fishman Karate"
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 299 then
                        _G.SelectWeapon = "Dragon Claw"
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 300000) then
                        UnEquipWeapon("Black Leg")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and (game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 300000) then
                        UnEquipWeapon("Black Leg")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 750000) then
                        UnEquipWeapon("Electro")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and (game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 750000) then
                        UnEquipWeapon("Electro")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300 and game:GetService("Players").Localplayer.Data.Fragments.Value >= 1500) then
                        UnEquipWeapon("Fishman Karate")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and (game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300 and game:GetService("Players").Localplayer.Data.Fragments.Value >= 1500) then
                        UnEquipWeapon("Fishman Karate")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 3000000) then
                        UnEquipWeapon("Dragon Claw")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and (game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 3000000) then
                        UnEquipWeapon("Dragon Claw")
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                    end
                end
            end
        end
    end)
end)
Toggle = v281.M:AddToggle("Toggle", {
    ["Title"] = "Auto DeathStep",
    ["Default"] = false
})
Toggle:OnChanged(function(p568)
    _G.DeathStep = p568
end)
spawn(function()
    while wait() do
        wait()
        if _G.DeathStep then
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Death Step") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Death Step"))) then
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 450 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                    _G.SelectWeapon = "Death Step"
                end
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 450 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                    _G.SelectWeapon = "Death Step"
                end
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 449 then
                    _G.SelectWeapon = "Black Leg"
                end
            else
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
            end
        end
    end
end)
Toggle = v281.M:AddToggle("Toggle", {
    ["Title"] = "Auto Sharkman Karate",
    ["Default"] = false
})
Toggle:OnChanged(function(p569)
    _G.Sharkman = p569
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.Sharkman then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key") then
                        topos(CFrame.new(- 2604.6958, 239.432526, - 10315.1982, 0.0425701365, 0, - 0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                    elseif not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value < 400 then
                        Ms = "Tide Keeper"
                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                            local v570, v571, v572 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v573
                                v572, v573 = v570(v571, v572)
                                if v572 == nil then
                                    break
                                end
                                if v573.Name == Ms then
                                    OldCFrameShark = v573.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        v573.Head.CanCollide = false
                                        v573.Humanoid.WalkSpeed = 0
                                        v573.HumanoidRootPart.CanCollide = false
                                        v573.HumanoidRootPart.CFrame = OldCFrameShark
                                        TP2(v573.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not v573.Parent or (v573.Humanoid.Health <= 0 or _G.Sharkman == false) or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key"))
                                end
                            end
                        else
                            topos(CFrame.new(- 3570.18652, 123.328949, - 11555.9072, 0.465199202, - 1.3857326e-8, 0.885206044, 4.0332897e-9, 1, 1.35347511e-8, - 0.885206044, - 2.72606271e-9, 0.465199202))
                            wait(3)
                        end
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                end
            end
        end
    end)
end)
Toggle = v281.M:AddToggle("Toggle", {
    ["Title"] = "Auto Electric Claw",
    ["Default"] = false
})
Toggle:OnChanged(function(p574)
    _G.ElectricClaw = p574
    StopTween(_G.ElectricClaw)
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.ElectricClaw then
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electric Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electric Claw"))) then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        _G.SelectWeapon = "Electric Claw"
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        _G.SelectWeapon = "Electric Claw"
                    end
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 399 then
                        _G.SelectWeapon = "Electro"
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                end
            end
            if _G.ElectricClaw and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro")) and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400) then
                if _G.Level ~= false then
                    if _G.Level == true then
                        _G.Level = false
                        wait(1)
                        repeat
                            task.wait()
                            topos(CFrame.new(- 10371.4717, 330.764496, - 10131.4199))
                        until not _G.ElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(- 10371.4717, 330.764496, - 10131.4199).Position).Magnitude <= 10
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
                        wait(2)
                        repeat
                            task.wait()
                            topos(CFrame.new(- 12550.532226563, 336.22631835938, - 7510.4233398438))
                        until not _G.ElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(- 12550.532226563, 336.22631835938, - 7510.4233398438).Position).Magnitude <= 10
                        wait(1)
                        repeat
                            task.wait()
                            topos(CFrame.new(- 10371.4717, 330.764496, - 10131.4199))
                        until not _G.ElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(- 10371.4717, 330.764496, - 10131.4199).Position).Magnitude <= 10
                        wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        _G.SelectWeapon = "Electric Claw"
                        wait(0.1)
                        _G.Level = true
                    end
                else
                    repeat
                        task.wait()
                        topos(CFrame.new(- 10371.4717, 330.764496, - 10131.4199))
                    until not _G.ElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(- 10371.4717, 330.764496, - 10131.4199).Position).Magnitude <= 10
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
                    wait(2)
                    repeat
                        task.wait()
                        topos(CFrame.new(- 12550.532226563, 336.22631835938, - 7510.4233398438))
                    until not _G.ElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(- 12550.532226563, 336.22631835938, - 7510.4233398438).Position).Magnitude <= 10
                    wait(1)
                    repeat
                        task.wait()
                        topos(CFrame.new(- 10371.4717, 330.764496, - 10131.4199))
                    until not _G.ElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(- 10371.4717, 330.764496, - 10131.4199).Position).Magnitude <= 10
                    wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                end
            end
        end
    end)
end)
Toggle = v281.M:AddToggle("Toggle", {
    ["Title"] = "Auto Dragon Talon",
    ["Default"] = false
})
Toggle:OnChanged(function(p575)
    _G.DragonTalon = p575
end)
spawn(function()
    while wait() do
        if _G.DragonTalon then
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Talon"))) then
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 400 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                    _G.SelectWeapon = "Dragon Talon"
                end
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 400 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                    _G.SelectWeapon = "Dragon Talon"
                end
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 399 then
                    _G.SelectWeapon = "Dragon Claw"
                end
            else
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            end
        end
    end
end)
Toggle = v281.M:AddToggle("Toggle", {
    ["Title"] = "Auto GodHuman",
    ["Default"] = false
})
Toggle:OnChanged(function(p576)
    _G.God_Human = p576
end)
spawn(function()
    while task.wait() do
        if _G.God_Human then
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Death Step") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Death Step") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sharkman Karate") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or (game.Players.LocalPlayer.Character:FindFirstChild("Electro") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") or (game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Talon") or (game.Players.LocalPlayer.Character:FindFirstChild("Godhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Godhuman"))))))))))))))))))) then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 and (game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") and game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") and game.Players.LocalPlayer.Character:FindFirstChild("Superhuman").Level.Value >= 400) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 and (game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step") and game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Death Step") and game.Players.LocalPlayer.Character:FindFirstChild("Death Step").Level.Value >= 400) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 and (game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate").Level.Value >= 400) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 and (game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw").Level.Value >= 400) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 and (game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Talon") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Talon").Level.Value >= 400) and not string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true), "Bring") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                end
            end)
        end
    end
end)
v281.M:AddSection("Materials")
if World2 then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Radioactive Material",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p577)
        Radioactive = p577
        StopTween(Radioactive)
    end)
    local vu578 = CFrame.new(- 507.7895202636719, 72.99479675292969, - 126.45632934570312)
    spawn(function()
		-- upvalues: (ref) vu578
        while wait() do
            if Radioactive and World2 then
                pcall(function()
					-- upvalues: (ref) vu578
                    if game:GetService("Workspace").Enemies:FindFirstChild("Factory Staff") then
                        local v579, v580, v581 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v582
                            v581, v582 = v579(v580, v581)
                            if v581 == nil then
                                break
                            end
                            if v582.Name == "Factory Staff" and (v582:FindFirstChild("Humanoid") and (v582:FindFirstChild("HumanoidRootPart") and v582.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v582.HumanoidRootPart.CanCollide = false
                                    v582.Humanoid.WalkSpeed = 0
                                    v582.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v582.HumanoidRootPart.CFrame
                                    TP2(v582.HumanoidRootPart.CFrame * Pos)
                                until not Radioactive or (not v582.Parent or v582.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu578)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Factory Staff") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Factory Staff").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Ectoplasm",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p583)
        _G.Ectoplasm = p583
        StopTween(_G.Ectoplasm)
    end)
    spawn(function()
        while wait() do
            if _G.Ectoplasm and World2 then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer"))) then
                        local v584, v585, v586 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v587
                            v586, v587 = v584(v585, v586)
                            if v586 == nil then
                                break
                            end
                            local _ = v587.Name == "Ship Officer" or v587.Name == "Ship Steward"
                            if v587:FindFirstChild("Humanoid") and (v587:FindFirstChild("HumanoidRootPart") and v587.Humanoid.Health > 0) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v587.HumanoidRootPart.CanCollide = false
                                    v587.Humanoid.WalkSpeed = 0
                                    TP2(v587.HumanoidRootPart.CFrame * Pos)
                                    StartMagnet = true
                                    _G.PosMon = v587.HumanoidRootPart.CFrame
                                until not _G.Ectoplasm or (not v587.Parent or v587.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        StartMagnet = false
                        topos(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Mystic Droplet",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p588)
        _G.Makori_gay = p588
        StopTween(_G.Makori_gay)
    end)
    local vu589 = CFrame.new(- 3352.9013671875, 285.01556396484375, - 10534.841796875)
    spawn(function()
		-- upvalues: (ref) vu589
        while wait() do
            if _G.Makori_gay and World2 then
                pcall(function()
					-- upvalues: (ref) vu589
                    if game:GetService("Workspace").Enemies:FindFirstChild("Water Fighter") then
                        local v590, v591, v592 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v593
                            v592, v593 = v590(v591, v592)
                            if v592 == nil then
                                break
                            end
                            if v593.Name == "Water Fighter" and (v593:FindFirstChild("Humanoid") and (v593:FindFirstChild("HumanoidRootPart") and v593.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v593.HumanoidRootPart.CanCollide = false
                                    v593.Humanoid.WalkSpeed = 0
                                    v593.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v593.HumanoidRootPart.CFrame
                                    TP2(v593.HumanoidRootPart.CFrame * Pos)
                                until not _G.Makori_gay or (not v593.Parent or v593.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu589)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Water Fighter") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Water Fighter").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if World1 or World2 then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Magma Ore",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p594)
        _G.Umm = p594
        StopTween(_G.Umm)
    end)
    local vu595 = CFrame.new(- 5850.2802734375, 77.28675079345703, 8848.6748046875)
    spawn(function()
		-- upvalues: (ref) vu595
        while wait() do
            if _G.Umm and World1 then
                pcall(function()
					-- upvalues: (ref) vu595
                    if game:GetService("Workspace").Enemies:FindFirstChild("Military Spy") then
                        local v596, v597, v598 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v599
                            v598, v599 = v596(v597, v598)
                            if v598 == nil then
                                break
                            end
                            if v599.Name == "Military Spy" and (v599:FindFirstChild("Humanoid") and (v599:FindFirstChild("HumanoidRootPart") and v599.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v599.HumanoidRootPart.CanCollide = false
                                    v599.Humanoid.WalkSpeed = 0
                                    v599.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v599.HumanoidRootPart.CFrame
                                    TP2(v599.HumanoidRootPart.CFrame * Pos)
                                until not _G.Umm or (not v599.Parent or v599.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu595)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Military Spy") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Military Spy").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    local vu600 = CFrame.new(- 5234.60595703125, 51.953372955322266, - 4732.27880859375)
    spawn(function()
		-- upvalues: (ref) vu600
        while wait() do
            if _G.Umm and World2 then
                pcall(function()
					-- upvalues: (ref) vu600
                    if game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate") then
                        local v601, v602, v603 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v604
                            v603, v604 = v601(v602, v603)
                            if v603 == nil then
                                break
                            end
                            if v604.Name == "Lava Pirate" and (v604:FindFirstChild("Humanoid") and (v604:FindFirstChild("HumanoidRootPart") and v604.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v604.HumanoidRootPart.CanCollide = false
                                    v604.Humanoid.WalkSpeed = 0
                                    v604.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v604.HumanoidRootPart.CFrame
                                    TP2(v604.HumanoidRootPart.CFrame * Pos)
                                until not _G.Umm or (not v604.Parent or v604.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu600)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Lava Pirate") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if World1 then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Angel Wings",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p605)
        _G.Wing = p605
        StopTween(_G.Wing)
    end)
    local vu606 = CFrame.new(- 7827.15625, 5606.912109375, - 1705.5833740234375)
    spawn(function()
		-- upvalues: (ref) vu606
        while wait() do
            if _G.Wing and World1 then
                pcall(function()
					-- upvalues: (ref) vu606
                    if game:GetService("Workspace").Enemies:FindFirstChild("Royal Soldier") then
                        local v607, v608, v609 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v610
                            v609, v610 = v607(v608, v609)
                            if v609 == nil then
                                break
                            end
                            if v610.Name == "Royal Soldier" and (v610:FindFirstChild("Humanoid") and (v610:FindFirstChild("HumanoidRootPart") and v610.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v610.HumanoidRootPart.CanCollide = false
                                    v610.Humanoid.WalkSpeed = 0
                                    v610.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v610.HumanoidRootPart.CFrame
                                    TP2(v610.HumanoidRootPart.CFrame * Pos)
                                until not _G.Wing or (not v610.Parent or v610.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu606)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Royal Soldier") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Royal Soldier").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if World1 or (World2 or World3) then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Leather",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p611)
        _G.Leather = p611
        StopTween(_G.Leather)
    end)
    local vu612 = CFrame.new(- 1211.8792724609375, 4.787090301513672, 3916.83056640625)
    spawn(function()
		-- upvalues: (ref) vu612
        while wait() do
            if _G.Leather and World1 then
                pcall(function()
					-- upvalues: (ref) vu612
                    if game:GetService("Workspace").Enemies:FindFirstChild("Pirate") then
                        local v613, v614, v615 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v616
                            v615, v616 = v613(v614, v615)
                            if v615 == nil then
                                break
                            end
                            if v616.Name == "Pirate" and (v616:FindFirstChild("Humanoid") and (v616:FindFirstChild("HumanoidRootPart") and v616.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v616.HumanoidRootPart.CanCollide = false
                                    v616.Humanoid.WalkSpeed = 0
                                    v616.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v616.HumanoidRootPart.CFrame
                                    TP2(v616.HumanoidRootPart.CFrame * Pos)
                                until not _G.Leather or (not v616.Parent or v616.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu612)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Pirate") then
                            topos(game:GetService("ReplicatedStorage").Pirate.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    local vu617 = CFrame.new(- 2010.5059814453125, 73.00115966796875, - 3326.620849609375)
    spawn(function()
		-- upvalues: (ref) vu617
        while wait() do
            if _G.Leather and World2 then
                pcall(function()
					-- upvalues: (ref) vu617
                    if game:GetService("Workspace").Enemies:FindFirstChild("Marine Captain") then
                        local v618, v619, v620 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v621
                            v620, v621 = v618(v619, v620)
                            if v620 == nil then
                                break
                            end
                            if v621.Name == "Marine Captain" and (v621:FindFirstChild("Humanoid") and (v621:FindFirstChild("HumanoidRootPart") and v621.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v621.HumanoidRootPart.CanCollide = false
                                    v621.Humanoid.WalkSpeed = 0
                                    v621.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v621.HumanoidRootPart.CFrame
                                    TP2(v621.HumanoidRootPart.CFrame * Pos)
                                until not _G.Leather or (not v621.Parent or v621.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu617)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Marine Captain") then
                            topos(game:GetService("ReplicatedStorage").MarineCaptain.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    local vu622 = CFrame.new(- 11975.78515625, 331.7734069824219, - 10620.0302734375)
    spawn(function()
		-- upvalues: (ref) vu622
        while wait() do
            if _G.Leather and World3 then
                pcall(function()
					-- upvalues: (ref) vu622
                    if game:GetService("Workspace").Enemies:FindFirstChild("Jungle Pirate") then
                        local v623, v624, v625 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v626
                            v625, v626 = v623(v624, v625)
                            if v625 == nil then
                                break
                            end
                            if v626.Name == "Jungle Pirate" and (v626:FindFirstChild("Humanoid") and (v626:FindFirstChild("HumanoidRootPart") and v626.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v626.HumanoidRootPart.CanCollide = false
                                    v626.Humanoid.WalkSpeed = 0
                                    v626.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v626.HumanoidRootPart.CFrame
                                    TP2(v626.HumanoidRootPart.CFrame * Pos)
                                until not _G.Leather or (not v626.Parent or v626.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu622)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Jungle Pirate") then
                            topos(game:GetService("ReplicatedStorage").JunglePirate.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if World1 or (World2 or World3) then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Scrap Metal",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p627)
        Scrap = p627
        StopTween(Scrap)
    end)
    local vu628 = CFrame.new(- 1132.4202880859375, 14.844913482666016, 4293.30517578125)
    spawn(function()
		-- upvalues: (ref) vu628
        while wait() do
            if Scrap and World1 then
                pcall(function()
					-- upvalues: (ref) vu628
                    if game:GetService("Workspace").Enemies:FindFirstChild("Brute") then
                        local v629, v630, v631 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v632
                            v631, v632 = v629(v630, v631)
                            if v631 == nil then
                                break
                            end
                            if v632.Name == "Brute" and (v632:FindFirstChild("Humanoid") and (v632:FindFirstChild("HumanoidRootPart") and v632.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v632.HumanoidRootPart.CanCollide = false
                                    v632.Humanoid.WalkSpeed = 0
                                    v632.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v632.HumanoidRootPart.CFrame
                                    TP2(v632.HumanoidRootPart.CFrame * Pos)
                                until not Scrap or (not v632.Parent or v632.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu628)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Brute") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Brute").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    local vu633 = CFrame.new(- 972.307373046875, 73.04473876953125, 1419.2901611328125)
    spawn(function()
		-- upvalues: (ref) vu633
        while wait() do
            if Scrap and World2 then
                pcall(function()
					-- upvalues: (ref) vu633
                    if game:GetService("Workspace").Enemies:FindFirstChild("Mercenary") then
                        local v634, v635, v636 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v637
                            v636, v637 = v634(v635, v636)
                            if v636 == nil then
                                break
                            end
                            if v637.Name == "Mercenary" and (v637:FindFirstChild("Humanoid") and (v637:FindFirstChild("HumanoidRootPart") and v637.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v637.HumanoidRootPart.CanCollide = false
                                    v637.Humanoid.WalkSpeed = 0
                                    v637.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v637.HumanoidRootPart.CFrame
                                    TP2(v637.HumanoidRootPart.CFrame * Pos)
                                until not Scrap or (not v637.Parent or v637.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu633)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Mercenary") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Mercenary").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    local vu638 = CFrame.new(- 289.6311950683594, 43.8282470703125, 5583.66357421875)
    spawn(function()
		-- upvalues: (ref) vu638
        while wait() do
            if Scrap and World3 then
                pcall(function()
					-- upvalues: (ref) vu638
                    if game:GetService("Workspace").Enemies:FindFirstChild("Pirate Millionaire") then
                        local v639, v640, v641 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v642
                            v641, v642 = v639(v640, v641)
                            if v641 == nil then
                                break
                            end
                            if v642.Name == "Pirate Millionaire" and (v642:FindFirstChild("Humanoid") and (v642:FindFirstChild("HumanoidRootPart") and v642.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v642.HumanoidRootPart.CanCollide = false
                                    v642.Humanoid.WalkSpeed = 0
                                    v642.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v642.HumanoidRootPart.CFrame
                                    TP2(v642.HumanoidRootPart.CFrame * Pos)
                                until not Scrap or (not v642.Parent or v642.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu638)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Pirate Millionaire") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Pirate Millionaire").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if World3 then
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Conjured Cocoa",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p643)
        Cocoafarm = p643
        StopTween(Cocoafarm)
    end)
    local vu644 = CFrame.new(744.7930908203125, 24.76934242248535, - 12637.7255859375)
    spawn(function()
		-- upvalues: (ref) vu644
        while wait() do
            if Cocoafarm and World3 then
                pcall(function()
					-- upvalues: (ref) vu644
                    if game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler") then
                        local v645, v646, v647 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v648
                            v647, v648 = v645(v646, v647)
                            if v647 == nil then
                                break
                            end
                            if v648.Name == "Chocolate Bar Battler" and (v648:FindFirstChild("Humanoid") and (v648:FindFirstChild("HumanoidRootPart") and v648.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v648.HumanoidRootPart.CanCollide = false
                                    v648.Humanoid.WalkSpeed = 0
                                    v648.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v648.HumanoidRootPart.CFrame
                                    TP2(v648.HumanoidRootPart.CFrame * Pos)
                                until not Cocoafarm or (not v648.Parent or v648.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu644)
                        topos(CFrame.new(744.7930908203125, 24.76934242248535, - 12637.7255859375))
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Chocolate Bar Battler") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Chocolate Bar Battler").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Dragon Scale",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p649)
        Dragon_Scale = p649
        StopTween(Dragon_Scale)
    end)
    local vu650 = CFrame.new(6752, 565, 315)
    spawn(function()
		-- upvalues: (ref) vu650
        while wait() do
            if Dragon_Scale and World3 then
                pcall(function()
					-- upvalues: (ref) vu650
                    if game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") then
                        local v651, v652, v653 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v654
                            v653, v654 = v651(v652, v653)
                            if v653 == nil then
                                break
                            end
                            if v654.Name == "Dragon Crew Archer" and (v654:FindFirstChild("Humanoid") and (v654:FindFirstChild("HumanoidRootPart") and v654.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v654.HumanoidRootPart.CanCollide = false
                                    v654.Humanoid.WalkSpeed = 0
                                    v654.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v654.HumanoidRootPart.CFrame
                                    TP2(v654.HumanoidRootPart.CFrame * Pos)
                                until not Dragon_Scale or (not v654.Parent or v654.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu650)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Dragon Crew Archer") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Dragon Crew Archer").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Gunpowder",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p655)
        Gunpowder = p655
        StopTween(Gunpowder)
    end)
    local vu656 = CFrame.new(- 379.6134338378906, 73.84449768066406, 5928.5263671875)
    spawn(function()
		-- upvalues: (ref) vu656
        while wait() do
            if Gunpowder and World3 then
                pcall(function()
					-- upvalues: (ref) vu656
                    if game:GetService("Workspace").Enemies:FindFirstChild("Pistol Billionaire") then
                        local v657, v658, v659 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v660
                            v659, v660 = v657(v658, v659)
                            if v659 == nil then
                                break
                            end
                            if v660.Name == "Pistol Billionaire" and (v660:FindFirstChild("Humanoid") and (v660:FindFirstChild("HumanoidRootPart") and v660.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v660.HumanoidRootPart.CanCollide = false
                                    v660.Humanoid.WalkSpeed = 0
                                    v660.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v660.HumanoidRootPart.CFrame
                                    TP2(v660.HumanoidRootPart.CFrame * Pos)
                                until not Gunpowder or (not v660.Parent or v660.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu656)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Pistol Billionaire") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Pistol Billionaire").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Fish Tail World 3",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p661)
        Fish = p661
        StopTween(Fish)
    end)
    local vu662 = CFrame.new(- 10961.0126953125, 331.7977600097656, - 8914.29296875)
    spawn(function()
		-- upvalues: (ref) vu662
        while wait() do
            if Fish and World3 then
                pcall(function()
					-- upvalues: (ref) vu662
                    if game:GetService("Workspace").Enemies:FindFirstChild("Fishman Captain") then
                        local v663, v664, v665 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v666
                            v665, v666 = v663(v664, v665)
                            if v665 == nil then
                                break
                            end
                            if v666.Name == "Fishman Captain" and (v666:FindFirstChild("Humanoid") and (v666:FindFirstChild("HumanoidRootPart") and v666.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v666.HumanoidRootPart.CanCollide = false
                                    v666.Humanoid.WalkSpeed = 0
                                    v666.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v666.HumanoidRootPart.CFrame
                                    TP2(v666.HumanoidRootPart.CFrame * Pos)
                                until not Fish or (not v666.Parent or v666.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu662)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Fishman Captain") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Fishman Captain").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Farm Mini Tusk",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p667)
        MiniHee = p667
        StopTween(MiniHee)
    end)
    local vu668 = CFrame.new(- 13516.0458984375, 469.8182373046875, - 6899.16064453125)
    spawn(function()
		-- upvalues: (ref) vu668
        while wait() do
            if MiniHee and World3 then
                pcall(function()
					-- upvalues: (ref) vu668
                    if game:GetService("Workspace").Enemies:FindFirstChild("Mythological Pirate") then
                        local v669, v670, v671 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v672
                            v671, v672 = v669(v670, v671)
                            if v671 == nil then
                                break
                            end
                            if v672.Name == "Mythological Pirate" and (v672:FindFirstChild("Humanoid") and (v672:FindFirstChild("HumanoidRootPart") and v672.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v672.HumanoidRootPart.CanCollide = false
                                    v672.Humanoid.WalkSpeed = 0
                                    v672.Head.CanCollide = false
                                    StartMagnet = true
                                    _G.PosMon = v672.HumanoidRootPart.CFrame
                                    TP2(v672.HumanoidRootPart.CFrame * Pos)
                                until not MiniHee or (not v672.Parent or v672.Humanoid.Health <= 0)
                                StartMagnet = false
                            end
                        end
                    else
                        topos(vu668)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Mythological Pirate") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Mythological Pirate").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if World3 then
    v281.M:AddSection("Advance Dungeon")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Phoenix Raid",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p673)
        _G.AdvanceDungeon = p673
        StopTween(_G.AdvanceDungeon)
    end)
    spawn(function()
        while wait() do
            if _G.AdvanceDungeon then
                pcall(function()
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Phoenix") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                            if game.Players.LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value >= 400 then
                                topos(CFrame.new(- 2812.76708984375, 254.803466796875, - 12595.560546875))
                                if (CFrame.new(- 2812.76708984375, 254.803466796875, - 12595.560546875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                    wait(1.5)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist", "Check")
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist", "Heal")
                                end
                            end
                        elseif game.Players.LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) and game.Players.LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value >= 400 then
                            topos(CFrame.new(- 2812.76708984375, 254.803466796875, - 12595.560546875))
                            if (CFrame.new(- 2812.76708984375, 254.803466796875, - 12595.560546875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                wait(1.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist", "Check")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist", "Heal")
                            end
                        end
                    end
                end)
            end
        end
    end)
end
if World1 then
    v281.M:AddParagraph({
        ["Title"] = "Sea 1",
        ["Content"] = "World 1"
    })
    v281.M:AddSection("Greybeard")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Greybeard",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p674)
        _G.Greybeard = p674
        StopTween(_G.Greybeard)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Greybeard Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p675)
        _G.Greybeardhop = p675
    end)
    local vu676 = CFrame.new(- 5023.38330078125, 28.65203285217285, 4332.3818359375)
    spawn(function()
		-- upvalues: (ref) vu676
        while wait() do
            if _G.Greybeard and World1 then
                pcall(function()
					-- upvalues: (ref) vu676
                    if game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                        local v677, v678, v679 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v680
                            v679, v680 = v677(v678, v679)
                            if v679 == nil then
                                break
                            end
                            if v680.Name == "Greybeard" and (v680:FindFirstChild("Humanoid") and (v680:FindFirstChild("HumanoidRootPart") and v680.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v680.HumanoidRootPart.CanCollide = false
                                    v680.Humanoid.WalkSpeed = 0
                                    TP2(v680.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.Greybeard or (not v680.Parent or v680.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu676)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.Greybeardhop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
    v281.M:AddSection("Saber")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Saber",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p681)
        _G.Saber = p681
        StopTween(_G.Saber)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Saber Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p682)
        _G.SaberHop = p682
    end)
    spawn(function()
        while task.wait() do
            if _G.Saber and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                pcall(function()
                    if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency ~= 0 then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert") then
                            local v683, v684, v685 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v686
                                v685, v686 = v683(v684, v685)
                                if v685 == nil then
                                    break
                                end
                                if v686:FindFirstChild("Humanoid") and (v686:FindFirstChild("HumanoidRootPart") and (v686.Humanoid.Health > 0 and v686.Name == "Saber Expert")) then
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        TP2(v686.HumanoidRootPart.CFrame * Pos)
                                        v686.HumanoidRootPart.Transparency = 1
                                        v686.Humanoid.JumpPower = 0
                                        v686.Humanoid.WalkSpeed = 0
                                        v686.HumanoidRootPart.CanCollide = false
                                        FarmPos = v686.HumanoidRootPart.CFrame
                                        MonFarm = v686.Name
                                    until v686.Humanoid.Health <= 0 or not _G.Saber
                                    if v686.Humanoid.Health <= 0 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
                                    end
                                end
                            end
                        end
                    elseif game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency ~= 0 then
                        if game:GetService("Workspace").Map.Desert.Burn.Part.Transparency ~= 0 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") == 0 then
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= nil then
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 0 then
                                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                                            wait(0.5)
                                            EquipWeapon("Relic")
                                            wait(0.5)
                                            topos(CFrame.new(- 1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-9, 0.481375456, 2.53851997e-8, 1, - 5.79995607e-8, - 0.481375456, 6.30572643e-8, 0.876514494))
                                        end
                                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                                        topos(CFrame.new(- 2967.59521, 4.91089821, 5328.70703, 0.342208564, - 0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, - 0.939287126, 0.0184739735, 0.342634559))
                                        local v687, v688, v689 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                        while true do
                                            local v690
                                            v689, v690 = v687(v688, v689)
                                            if v689 == nil then
                                                break
                                            end
                                            if v690.Name == "Mob Leader" then
                                                if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") and (v690:FindFirstChild("Humanoid") and (v690:FindFirstChild("HumanoidRootPart") and v690.Humanoid.Health > 0)) then
                                                    repeat
                                                        task.wait()
                                                        EquipWeapon(_G.SelectWeapon)
                                                        v690.HumanoidRootPart.CanCollide = false
                                                        v690.Humanoid.WalkSpeed = 0
                                                        TP2(v690.HumanoidRootPart.CFrame * Pos)
                                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                    until v690.Humanoid.Health <= 0 or not _G.Saber
                                                end
                                                if game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                                                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader").HumanoidRootPart.CFrame * Farm_Mode)
                                                end
                                            end
                                        end
                                    end
                                else
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                                end
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
                                wait(0.5)
                                EquipWeapon("Cup")
                                wait(0.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", game:GetService("Players").LocalPlayer.Character.Cup)
                                wait(0)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
                            end
                        elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                            EquipWeapon("Torch")
                            topos(CFrame.new(1114.61475, 5.04679728, 4350.22803, - 0.648466587, - 1.28799094e-9, 0.761243105, - 5.70652914e-10, 1, 1.20584542e-9, - 0.761243105, 3.47544882e-10, - 0.648466587))
                        else
                            topos(CFrame.new(- 1610.00757, 11.5049858, 164.001587, 0.984807551, - 0.167722285, - 0.0449818149, 0.17364943, 0.951244235, 0.254912198, 0.0000342372805, - 0.258850515, 0.965917408))
                        end
                    elseif (CFrame.new(- 1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-9, - 0.928667724, 3.97099491e-8, 1, 1.91679348e-8, 0.928667724, - 4.39869794e-8, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 100 then
                        topos(CFrame.new(- 1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-9, - 0.928667724, 3.97099491e-8, 1, 1.91679348e-8, 0.928667724, - 4.39869794e-8, 0.37091279))
                    else
                        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame
                        wait(1)
                    end
                end)
            end
        end
    end)
    v281.M:AddSection("Pole")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Pole v1",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p691)
        _G.pole = p691
        StopTween(_G.pole)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Pole v1 Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p692)
        _G.polehop = p692
    end)
    local vu693 = CFrame.new(- 7748.0185546875, 5606.80615234375, - 2305.898681640625)
    spawn(function()
		-- upvalues: (ref) vu693
        while wait() do
            if _G.pole and World1 then
                pcall(function()
					-- upvalues: (ref) vu693
                    if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
                        local v694, v695, v696 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v697
                            v696, v697 = v694(v695, v696)
                            if v696 == nil then
                                break
                            end
                            if v697.Name == "Thunder God" and (v697:FindFirstChild("Humanoid") and (v697:FindFirstChild("HumanoidRootPart") and v697.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v697.HumanoidRootPart.CanCollide = false
                                    v697.Humanoid.WalkSpeed = 0
                                    TP2(v697.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.pole or (not v697.Parent or v697.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu693)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.polehop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
end
if World2 then
    v281.M:AddParagraph({
        ["Title"] = "Sea 2",
        ["Content"] = "World 2"
    })
    v281.M:AddSection("Legendary Sword")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Legendary Sword",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p698)
        _G.BuyLegendarySword = p698
    end)
    spawn(function()
        while wait() do
            if _G.BuyLegendarySword then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "LegendarySwordDealer",
                        "1"
                    }))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "LegendarySwordDealer",
                        "2"
                    }))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "LegendarySwordDealer",
                        "3"
                    }))
                    if _G.BuyLegendarySword_Hop and (_G.BuyLegendarySword and World2) then
                        wait(10)
                        Hop()
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Legendary Sword Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p699)
        _G.BuyLegendarySword_Hop = p699
    end)
    v281.M:AddSection("Enchancement Colour")
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ColorsDealer", "1")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Enchancement Colour",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p700)
        _G.BuyEnchancementColour = p700
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Enchancement Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p701)
        _G.BuyEnchancementColour_Hop = p701
    end)
    spawn(function()
        while wait() do
            if _G.BuyEnchancementColour then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "ColorsDealer",
                    "2"
                }))
                if _G.BuyEnchancementColour_Hop and (_G.BuyEnchancementColour and not World1) then
                    wait(10)
                    Hop()
                end
            end
        end
    end)
    v281.M:AddSection("Bartlio")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Bartlio",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p702)
        _G.Bartilo = p702
    end)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.Bartilo then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value < 800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 0 then
                        if game:GetService("Players").LocalPlayer.Data.Level.Value < 800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 1 then
                            if game:GetService("Players").LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
                                repeat
                                    topos(CFrame.new(- 1850.49329, 13.1789551, 1750.89685))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1850.49329, 13.1789551, 1750.89685)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1858.87305, 19.3777466, 1712.01807))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1858.87305, 19.3777466, 1712.01807)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1803.94324, 16.5789185, 1750.89685))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1803.94324, 16.5789185, 1750.89685)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1858.55835, 16.8604317, 1724.79541))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1858.55835, 16.8604317, 1724.79541)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1869.54224, 15.987854, 1681.00659))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1869.54224, 15.987854, 1681.00659)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1800.0979, 16.4978027, 1684.52368))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1800.0979, 16.4978027, 1684.52368)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1819.26343, 14.795166, 1717.90625))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1819.26343, 14.795166, 1717.90625)).Magnitude <= 10
                                wait(1)
                                repeat
                                    topos(CFrame.new(- 1813.51843, 14.8604736, 1724.79541))
                                    wait()
                                until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 1813.51843, 14.8604736, 1724.79541)).Magnitude <= 10
                            end
                        elseif game:GetService("Workspace").Enemies:FindFirstChild("Jeremy") then
                            Ms = "Jeremy"
                            local v703, v704, v705 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v706
                                v705, v706 = v703(v704, v705)
                                if v705 == nil then
                                    break
                                end
                                if v706.Name == Ms then
                                    OldCFrameBartlio = v706.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait()
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                        EquipWeapon(_G.SelectWeapon)
                                        v706.HumanoidRootPart.Transparency = 1
                                        v706.HumanoidRootPart.CanCollide = false
                                        v706.HumanoidRootPart.CFrame = OldCFrameBartlio
                                        TP2(v706.HumanoidRootPart.CFrame * Pos)
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not v706.Parent or (v706.Humanoid.Health <= 0 or _G.Bartilo == false)
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                            repeat
                                topos(CFrame.new(- 456.28952, 73.0200958, 299.895966))
                                wait()
                            until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 456.28952, 73.0200958, 299.895966)).Magnitude <= 10
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo")
                            wait(1)
                            repeat
                                topos(CFrame.new(2099.88159, 448.931, 648.997375))
                                wait()
                            until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10
                            wait(2)
                        else
                            repeat
                                topos(CFrame.new(2099.88159, 448.931, 648.997375))
                                wait()
                            until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                            Ms = "Swan Pirate"
                            local v707, v708, v709 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local vu710
                                v709, vu710 = v707(v708, v709)
                                if v709 == nil then
                                    break
                                end
                                if vu710.Name == Ms then
                                    pcall(function()
										-- upvalues: (ref) vu710
                                        repeat
                                            task.wait()
                                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                            EquipWeapon(_G.SelectWeapon)
                                            vu710.HumanoidRootPart.Transparency = 1
                                            vu710.HumanoidRootPart.CanCollide = false
                                            TP2(vu710.HumanoidRootPart.CFrame * Pos)
                                            _G.PosMon = vu710.HumanoidRootPart.CFrame
                                            StartMagnet = true
                                        until not vu710.Parent or (vu710.Humanoid.Health <= 0 or _G.Bartilo == false) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        StartMagnet = false
                                    end)
                                end
                            end
                        else
                            repeat
                                topos(CFrame.new(932.624451, 156.106079, 1180.27466, - 0.973085582, 4.55137119e-8, - 0.230443969, 2.67024713e-8, 1, 8.47491108e-8, 0.230443969, 7.63147128e-8, - 0.973085582))
                                wait()
                            until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(932.624451, 156.106079, 1180.27466, - 0.973085582, 4.55137119e-8, - 0.230443969, 2.67024713e-8, 1, 8.47491108e-8, 0.230443969, 7.63147128e-8, - 0.973085582)).Magnitude <= 10
                        end
                    else
                        repeat
                            topos(CFrame.new(- 456.28952, 73.0200958, 299.895966))
                            wait()
                        until not _G.Bartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 456.28952, 73.0200958, 299.895966)).Magnitude <= 10
                        wait(1.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
                    end
                end
            end
        end)
    end)
    v281.M:AddSection("Swan Glasses")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Swan Glasses",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p711)
        _G.FarmSwanGlasses = p711
        StopTween(_G.FarmSwanGlasses)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.FarmSwanGlasses then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan") then
                        local v712, v713, v714 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local vu715
                            v714, vu715 = v712(v713, v714)
                            if v714 == nil then
                                break
                            end
                            if vu715.Name == "Don Swan" and (vu715.Humanoid.Health > 0 and (vu715:IsA("Model") and (vu715:FindFirstChild("Humanoid") and vu715:FindFirstChild("HumanoidRootPart")))) then
                                repeat
                                    task.wait()
                                    pcall(function()
										-- upvalues: (ref) vu715
                                        EquipWeapon(_G.SelectWeapon)
                                        vu715.HumanoidRootPart.CanCollide = false
                                        TP2(vu715.HumanoidRootPart.CFrame * Pos)
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    end)
                                until _G.FarmSwanGlasses == false or vu715.Humanoid.Health <= 0
                            end
                        end
                    else
                        repeat
                            task.wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.537666320801, 905.48291015625))
                        until (CFrame.new(2284.912109375, 15.537666320801, 905.48291015625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 or _G.FarmSwanGlasses == false
                    end
                end
            end
        end)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Swan Glasses Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p716)
        _G.FarmSwanGlasses_Hop = p716
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Evo Race (V2)",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p717)
        _G.EvoRace = p717
        StopTween(_G.EvoRace)
    end)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.EvoRace and not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 0 then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 1 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
                            end
                        else
                            pcall(function()
                                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 1") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 1") then
                                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 2") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 2") then
                                        if not (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 3")) then
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Zombie") then
                                                local v718, v719, v720 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                                while true do
                                                    local v721
                                                    v720, v721 = v718(v719, v720)
                                                    if v720 == nil then
                                                        break
                                                    end
                                                    if v721.Name == "Zombie" then
                                                        repeat
                                                            task.wait()
                                                            EquipWeapon(_G.SelectWeapon)
                                                            TP2(v721.HumanoidRootPart.CFrame * Pos)
                                                            v721.HumanoidRootPart.CanCollide = false
                                                            _G.PosMon = v721.HumanoidRootPart.CFrame
                                                            StartMagnet = true
                                                        until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or (not v721.Parent or (v721.Humanoid.Health <= 0 or _G.EvoRace == false))
                                                        StartMagnet = false
                                                    end
                                                end
                                            else
                                                StartMagnet = false
                                                topos(CFrame.new(- 5685.9233398438, 48.480125427246, - 853.23724365234))
                                            end
                                        end
                                    else
                                        topos(game:GetService("Workspace").Flower2.CFrame)
                                    end
                                else
                                    topos(game:GetService("Workspace").Flower1.CFrame)
                                end
                            end)
                        end
                    else
                        topos(CFrame.new(- 2779.83521, 72.9661407, - 3574.02002, - 0.730484903, 6.39014104e-8, - 0.68292886, 3.59963224e-8, 1, 5.50667032e-8, 0.68292886, 1.56424669e-8, - 0.730484903))
                        if (Vector3.new(- 2779.83521, 72.9661407, - 3574.02002) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.3)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
                        end
                    end
                end
            end
        end)
    end)
    v281.M:AddSection("Dark Fragment")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Darkbeard Boss (Summon And Kill)",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p722)
        _G.AutoDarkbeard = p722
        StopTween(_G.AutoDarkbeard)
    end)
    spawn(function()
        while wait() do
            if _G.AutoDarkbeard then
                local _ = game.Player.LocalPlayer
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") then
                    EquipWeapon("Fist of Darkness")
                    topos(CFrame.new(3777.58618, 14.8764334, - 3498.81909, 0.13158533, 1.16175372e-8, - 0.991304874, - 9.53944035e-10, 1, 1.15928129e-8, 0.991304874, - 5.79794768e-10, 0.13158533))
                    local v723, v724, v725 = pairs(game.Workspace.Enemies:GetChildren())
                    while true do
                        local v726
                        v725, v726 = v723(v724, v725)
                        if v725 == nil then
                            break
                        end
                        if v726.Name == "Darkbeard" then
                            repeat
                                wait(0.1)
                                EquipWeapon(_G.SelectWeapon)
                                v726.HumanoidRootPart.CanCollide = false
                                v726.Humanoid.WalkSpeed = 0
                                TP2(v726.HumanoidRootPart.CFrame * Pos)
                            until not v726.Name == "Darkbeard" and not v726.Parent
                        end
                    end
                end
            end
        end
    end)
    v281.M:AddSection("Rengoku")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Rengoku",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p727)
        _G.Rengoku = p727
        StopTween(_G.Rengoku)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.Rengoku then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key") then
                        EquipWeapon("Hidden Key")
                        topos(CFrame.new(6571.1201171875, 299.23028564453, - 6967.841796875))
                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Snow Lurker") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior") then
                        local v728, v729, v730 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v731
                            v730, v731 = v728(v729, v730)
                            if v730 == nil then
                                break
                            end
                            if (v731.Name == "Snow Lurker" or v731.Name == "Arctic Warrior") and v731.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v731.HumanoidRootPart.CanCollide = false
                                    _G.PosMon = v731.HumanoidRootPart.CFrame
                                    TP2(v731.HumanoidRootPart.CFrame * Pos)
                                    StartMagnet = true
                                until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or (_G.Rengoku == false or (not v731.Parent or v731.Humanoid.Health <= 0))
                                StartMagnet = false
                            end
                        end
                    else
                        StartMagnet = false
                        topos(CFrame.new(5439.716796875, 84.420944213867, - 6715.1635742188))
                    end
                end
            end
        end)
    end)
    v281.M:AddSection("Trident")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Dragon Trident",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p732)
        _G.Dragon_Trident = p732
        StopTween(_G.Dragon_Trident)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Dragon Trident Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p733)
        _G.Dragon_Trident_Hop = p733
    end)
    local vu734 = CFrame.new(- 3914.830322265625, 123.29389190673828, - 11516.8642578125)
    spawn(function()
		-- upvalues: (ref) vu734
        while wait() do
            if _G.Dragon_Trident and World2 then
                pcall(function()
					-- upvalues: (ref) vu734
                    if game:GetService("Workspace").Enemies:FindFirstChild("Tide Keeper") then
                        local v735, v736, v737 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v738
                            v737, v738 = v735(v736, v737)
                            if v737 == nil then
                                break
                            end
                            if v738.Name == "Tide Keeper" and (v738:FindFirstChild("Humanoid") and (v738:FindFirstChild("HumanoidRootPart") and v738.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v738.HumanoidRootPart.CanCollide = false
                                    v738.Humanoid.WalkSpeed = 0
                                    TP2(v738.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.Dragon_Trident or (not v738.Parent or v738.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu734)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.Dragon_Trident_Hop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
end
if World3 then
    v281.M:AddParagraph({
        ["Title"] = "Sea 3",
        ["Content"] = "World 3"
    })
    v281.M:AddSection("Rip Indra")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Rip_Indra True",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p739)
        _G.DarkDagger = p739
        StopTween(_G.DarkDagger)
    end)
    local vu740 = CFrame.new(- 5344.822265625, 423.98541259766, - 2725.0930175781)
    spawn(function()
		-- upvalues: (ref) vu740
        pcall(function()
			-- upvalues: (ref) vu740
            while wait() do
                if _G.DarkDagger then
                    if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                        local v741, v742, v743 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local vu744
                            v743, vu744 = v741(v742, v743)
                            if v743 == nil then
                                break
                            end
                            if vu744.Name == ("rip_indra True Form" or vu744.Name == "rip_indra") and (vu744.Humanoid.Health > 0 and (vu744:IsA("Model") and (vu744:FindFirstChild("Humanoid") and vu744:FindFirstChild("HumanoidRootPart")))) then
                                repeat
                                    task.wait()
                                    pcall(function()
										-- upvalues: (ref) vu744
                                        EquipWeapon(_G.SelectWeapon)
                                        vu744.HumanoidRootPart.CanCollide = false
                                        TP2(vu744.HumanoidRootPart.CFrame * Pos)
                                    end)
                                until _G.DarkDagger == false or vu744.Humanoid.Health <= 0
                            end
                        end
                    else
                        topos(vu740)
                    end
                end
            end
        end)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Rip_Indra True Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p745)
        _G.DarkDagger_Hop = p745
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.DarkDagger_Hop and (_G.DarkDagger and World3) and not (game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
                    Hop()
                end
            end
        end)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Press Haki Button",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p746)
        Open_Color_Haki = p746
        StopTween(Open_Color_Haki)
    end)
    spawn(function()
        while wait(0.3) do
            pcall(function()
                if Open_Color_Haki then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Winter Sky")
                    wait(0.5)
                    repeat
                        topos(CFrame.new(- 5420.16602, 1084.9657, - 2666.8208))
                        wait()
                    until _G.StopTween == true or (Open_Color_Haki == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 5420.16602, 1084.9657, - 2666.8208)).Magnitude <= 10)
                    wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Pure Red")
                    wait(0.5)
                    repeat
                        topos(CFrame.new(- 5414.41357, 309.865753, - 2212.45776))
                        wait()
                    until _G.StopTween == true or (Open_Color_Haki == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 5414.41357, 309.865753, - 2212.45776)).Magnitude <= 10)
                    wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Snow White")
                    wait(0.5)
                    repeat
                        topos(CFrame.new(- 4971.47559, 331.565765, - 3720.02954))
                        wait()
                    until _G.StopTween == true or (Open_Color_Haki == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 4971.47559, 331.565765, - 3720.02954)).Magnitude <= 10)
                    wait(0.5)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 600))
                    wait(3)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 600))
                end
            end)
        end
    end)
    function EquipAllWeapon()
        pcall(function()
            local v747, v748, v749 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
            while true do
                local v750
                v749, v750 = v747(v748, v749)
                if v749 == nil then
                    break
                end
                if v750:IsA("Tool") and (v750.Name ~= "Summon Sea Beast" and (v750.Name ~= "Water Body" and v750.Name ~= "Awakening")) then
                    local v751 = game.Players.LocalPlayer.Backpack:FindFirstChild(v750.Name)
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v751)
                    wait(1)
                end
            end
        end)
    end
    v281.M:AddSection("Yama")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Yama",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p752)
        _G.Yama = p752
        StopTween(_G.Yama)
    end)
    spawn(function()
        while wait() do
            if _G.Yama and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
                wait(0.1)
                fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") and _G.Yama then
                    break
                end
            end
        end
    end)
    v281.M:AddSection("Musketeer")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Musketeer Hat",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p753)
        _G.MusketeerHat = p753
        StopTween(_G.MusketeerHat)
    end)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.MusketeerHat then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value < 1800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits ~= false then
                        if game:GetService("Players").LocalPlayer.Data.Level.Value < 1800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss ~= false then
                            if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
                                topos(CFrame.new(- 12512.138671875, 340.39279174805, - 9872.8203125))
                            end
                        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                                local v754, v755, v756 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                while true do
                                    local vu757
                                    v756, vu757 = v754(v755, v756)
                                    if v756 == nil then
                                        break
                                    end
                                    if vu757.Name == "Captain Elephant" then
                                        OldCFrameElephant = vu757.HumanoidRootPart.CFrame
                                        repeat
                                            task.wait()
                                            pcall(function()
												-- upvalues: (ref) vu757
                                                EquipWeapon(_G.SelectWeapon)
                                                vu757.HumanoidRootPart.CanCollide = false
                                                TP2(vu757.HumanoidRootPart.CFrame * Pos)
                                                vu757.HumanoidRootPart.CanCollide = false
                                                vu757.HumanoidRootPart.CFrame = OldCFrameElephant
                                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                            end)
                                        until _G.MusketeerHat == false or (vu757.Humanoid.Health <= 0 or not vu757.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    end
                                end
                            else
                                topos(CFrame.new(- 13374.889648438, 421.27752685547, - 8225.208984375))
                            end
                        else
                            topos(CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125))
                            if (CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                wait(1.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
                            end
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
                            local v758, v759, v760 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local vu761
                                v760, vu761 = v758(v759, v760)
                                if v760 == nil then
                                    break
                                end
                                if vu761.Name == "Forest Pirate" then
                                    repeat
                                        task.wait()
                                        pcall(function()
											-- upvalues: (ref) vu761
                                            EquipWeapon(_G.SelectWeapon)
                                            TP2(vu761.HumanoidRootPart.CFrame * Pos)
                                            vu761.HumanoidRootPart.CanCollide = false
                                            _G.PosMon = vu761.HumanoidRootPart.CFrame
                                            StartMagnet = true
                                        end)
                                    until _G.MusketeerHat == false or (not vu761.Parent or vu761.Humanoid.Health <= 0) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    StartMagnet = false
                                end
                            end
                        else
                            StartMagnet = false
                            topos(CFrame.new(- 13206.452148438, 425.89199829102, - 7964.5537109375))
                        end
                    else
                        topos(CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125))
                        if (Vector3.new(- 12443.8671875, 332.40396118164, - 7675.4892578125) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
                        end
                    end
                end
            end
        end)
    end)
    v281.M:AddSection("Twin Hook")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Twin Hook",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p762)
        _G.TwinHook = p762
        StopTween(_G.TwinHook)
    end)
    ToggleHop = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Twin Hook Hop",
        ["Default"] = false
    })
    ToggleHop:OnChanged(function(p763)
        _G.TwinHook_Hop = p763
    end)
    local vu764 = CFrame.new(- 13348.0654296875, 405.8904113769531, - 8570.62890625)
    spawn(function()
		-- upvalues: (ref) vu764
        while wait() do
            if _G.TwinHook and World3 then
                pcall(function()
					-- upvalues: (ref) vu764
                    if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                        local v765, v766, v767 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v768
                            v767, v768 = v765(v766, v767)
                            if v767 == nil then
                                break
                            end
                            if v768.Name == "Captain Elephant" and (v768:FindFirstChild("Humanoid") and (v768:FindFirstChild("HumanoidRootPart") and v768.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v768.HumanoidRootPart.CanCollide = false
                                    v768.Humanoid.WalkSpeed = 0
                                    TP2(v768.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.TwinHook or (not v768.Parent or v768.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu764)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Captain Elephant") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Captain Elephant").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.TwinHook_Hop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
    v281.M:AddSection("Haki")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Rainbow Haki",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p769)
        _G.Rainbow_Haki = p769
        StopTween(_G.Rainbow_Haki)
    end)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.Rainbow_Haki then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= true or not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= true or not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
                                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Kilo Admiral") then
                                        local v770, v771, v772 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                        while true do
                                            local v773
                                            v772, v773 = v770(v771, v772)
                                            if v772 == nil then
                                                break
                                            end
                                            if v773.Name == "Kilo Admiral" then
                                                OldCFrameRainbow = v773.HumanoidRootPart.CFrame
                                                repeat
                                                    task.wait()
                                                    EquipWeapon(_G.SelectWeapon)
                                                    TP2(v773.HumanoidRootPart.CFrame * Pos)
                                                    v773.HumanoidRootPart.CanCollide = false
                                                    v773.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                until _G.Rainbow_Haki == false or (v773.Humanoid.Health <= 0 or not v773.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                            end
                                        end
                                    else
                                        topos(CFrame.new(2877.61743, 423.558685, - 7207.31006, - 0.989591599, 0, - 0.143904909, 0, 1.00000012, 0, 0.143904924, 0, - 0.989591479))
                                    end
                                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                                        local v774, v775, v776 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                        while true do
                                            local v777
                                            v776, v777 = v774(v775, v776)
                                            if v776 == nil then
                                                break
                                            end
                                            if v777.Name == "Captain Elephant" then
                                                OldCFrameRainbow = v777.HumanoidRootPart.CFrame
                                                repeat
                                                    task.wait()
                                                    EquipWeapon(_G.SelectWeapon)
                                                    TP2(v777.HumanoidRootPart.CFrame * Pos)
                                                    v777.HumanoidRootPart.CanCollide = false
                                                    v777.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                until _G.Rainbow_Haki == false or (v777.Humanoid.Health <= 0 or not v777.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                            end
                                        end
                                    else
                                        topos(CFrame.new(- 13485.0283, 331.709259, - 8012.4873, 0.714521289, 7.98849911e-8, 0.69961375, - 1.02065748e-7, 1, - 9.94383065e-9, - 0.69961375, - 6.43015241e-8, 0.714521289))
                                    end
                                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                                        local v778, v779, v780 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                        while true do
                                            local v781
                                            v780, v781 = v778(v779, v780)
                                            if v780 == nil then
                                                break
                                            end
                                            if v781.Name == "Beautiful Pirate" then
                                                OldCFrameRainbow = v781.HumanoidRootPart.CFrame
                                                repeat
                                                    task.wait()
                                                    EquipWeapon(_G.SelectWeapon)
                                                    TP2(v781.HumanoidRootPart.CFrame * Pos)
                                                    v781.HumanoidRootPart.CanCollide = false
                                                    v781.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                until _G.Rainbow_Haki == false or (v781.Humanoid.Health <= 0 or not v781.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                            end
                                        end
                                    else
                                        topos(CFrame.new(5312.3598632813, 20.141201019287, - 10.158538818359))
                                    end
                                else
                                    topos(CFrame.new(- 11892.0703125, 930.57672119141, - 8760.1591796875))
                                    if (Vector3.new(- 11892.0703125, 930.57672119141, - 8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                        wait(1.5)
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                                    end
                                end
                            elseif game:GetService("Workspace").Enemies:FindFirstChild("Island Empress") then
                                local v782, v783, v784 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                while true do
                                    local v785
                                    v784, v785 = v782(v783, v784)
                                    if v784 == nil then
                                        break
                                    end
                                    if v785.Name == "Island Empress" then
                                        OldCFrameRainbow = v785.HumanoidRootPart.CFrame
                                        repeat
                                            task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            TP2(v785.HumanoidRootPart.CFrame * Pos)
                                            v785.HumanoidRootPart.CanCollide = false
                                            v785.HumanoidRootPart.CFrame = OldCFrameRainbow
                                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                        until _G.Rainbow_Haki == false or (v785.Humanoid.Health <= 0 or not v785.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    end
                                end
                            else
                                topos(CFrame.new(5713.98877, 601.922974, 202.751251, - 0.101080291, 0, - 0.994878292, 0, 1, 0, 0.994878292, 0, - 0.101080291))
                            end
                        elseif game:GetService("Workspace").Enemies:FindFirstChild("Stone") then
                            local v786, v787, v788 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v789
                                v788, v789 = v786(v787, v788)
                                if v788 == nil then
                                    break
                                end
                                if v789.Name == "Stone" then
                                    OldCFrameRainbow = v789.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        TP2(v789.HumanoidRootPart.CFrame * Pos)
                                        v789.HumanoidRootPart.CanCollide = false
                                        v789.HumanoidRootPart.CFrame = OldCFrameRainbow
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until _G.Rainbow_Haki == false or (v789.Humanoid.Health <= 0 or not v789.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            topos(CFrame.new(- 1086.11621, 38.8425903, 6768.71436, 0.0231462717, - 0.592676699, 0.805107772, 0.0000203251839, 0.805323839, 0.592835128, - 0.999732077, - 0.0137055516, 0.0186523199))
                        end
                    else
                        topos(CFrame.new(- 11892.0703125, 930.57672119141, - 8760.1591796875))
                        if (Vector3.new(- 11892.0703125, 930.57672119141, - 8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                        end
                    end
                end
            end
        end)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Observation Haki v2",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p790)
        _G.Observationv2 = p790
        StopTween(_G.Observationv2)
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.Observationv2 then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") ~= 3 then
                        _G.MusketeerHat = true
                    else
                        _G.MusketeerHat = false
                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana") and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple")) then
                            repeat
                                topos(CFrame.new(- 12444.78515625, 332.40396118164, - 7673.1806640625))
                                wait()
                            until not _G.Observationv2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 12444.78515625, 332.40396118164, - 7673.1806640625)).Magnitude <= 10
                            wait(0.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
                        elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
                            repeat
                                topos(CFrame.new(- 10920.125, 624.20275878906, - 10266.995117188))
                                wait()
                            until not _G.Observationv2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 10920.125, 624.20275878906, - 10266.995117188)).Magnitude <= 10
                            wait(0.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Start")
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
                        else
                            local v791, v792, v793 = pairs(game:GetService("Workspace"):GetDescendants())
                            while true do
                                local v794
                                v793, v794 = v791(v792, v793)
                                if v793 == nil then
                                    break
                                end
                                if v794.Name == "Apple" or (v794.Name == "Banana" or v794.Name == "Pineapple") then
                                    v794.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
                                    wait()
                                    firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v794.Handle, 0)
                                    wait()
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    v281.M:AddSection("Carvander")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Cavander",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p795)
        _G.Carvender = p795
        StopTween(_G.Carvender)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Cavander Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p796)
        _G.Carvenderhop = p796
    end)
    local vu797 = CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875)
    spawn(function()
		-- upvalues: (ref) vu797
        while wait() do
            if _G.Carvender and World3 then
                pcall(function()
					-- upvalues: (ref) vu797
                    if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                        local v798, v799, v800 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v801
                            v800, v801 = v798(v799, v800)
                            if v800 == nil then
                                break
                            end
                            if v801.Name == "Beautiful Pirate" and (v801:FindFirstChild("Humanoid") and (v801:FindFirstChild("HumanoidRootPart") and v801.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v801.HumanoidRootPart.CanCollide = false
                                    v801.Humanoid.WalkSpeed = 0
                                    TP2(v801.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.Carvender or (not v801.Parent or v801.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu797)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.Cavanderhop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
    v281.M:AddSection("Tushita")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Tushita",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p802)
        _G.tushita = p802
        StopTween(_G.tushita)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Tushita Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p803)
        _G.tushitahop = p803
    end)
    local vu804 = CFrame.new(- 10238.875976563, 389.7912902832, - 9549.7939453125)
    spawn(function()
		-- upvalues: (ref) vu804
        while wait() do
            if _G.tushita and World3 then
                pcall(function()
					-- upvalues: (ref) vu804
                    if game:GetService("Workspace").Enemies:FindFirstChild("Longma") then
                        local v805, v806, v807 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v808
                            v807, v808 = v805(v806, v807)
                            if v807 == nil then
                                break
                            end
                            if v808.Name == "Longma" and (v808:FindFirstChild("Humanoid") and (v808:FindFirstChild("HumanoidRootPart") and v808.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v808.HumanoidRootPart.CanCollide = false
                                    v808.Humanoid.WalkSpeed = 0
                                    TP2(v808.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.tushita or (not v808.Parent or v808.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu804)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Longma") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.tushitahop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Holy Torch",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p809)
        _G.HolyTorch = p809
        StopTween(_G.HolyTorch)
    end)
    spawn(function()
        while wait(0.5) do
            pcall(function()
                if _G.HolyTorch then
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch") then
                        repeat
                            wait(0.2)
                            EquipWeapon("Holy Torch")
                            topos(CFrame.new(5713, 47, 254))
                        until (Vector3.new(- 10752.4434, 415.261749, - 9367.43848) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                        wait(2)
                        repeat
                            wait(0.2)
                            EquipWeapon("Holy Torch")
                            topos(CFrame.new(- 11671.6289, 333.78125, - 9474.31934, 0.300932229, 0, - 0.953645527, 0, 1, 0, 0.953645527, 0, 0.300932229))
                        until (Vector3.new(- 11671.6289, 333.78125, - 9474.31934) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                        wait(2)
                        repeat
                            wait(0.2)
                            EquipWeapon("Holy Torch")
                            topos(CFrame.new(- 12133.1406, 521.507446, - 10654.292, 0.80428642, 0, - 0.594241858, 0, 1, 0, 0.594241858, 0, 0.80428642))
                        until (Vector3.new(- 12133.1406, 521.507446, - 10654.292) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                        wait(2)
                        repeat
                            wait(0.2)
                            EquipWeapon("Holy Torch")
                            topos(CFrame.new(- 13336.127, 484.521179, - 6985.31689, 0.853732228, 0, - 0.520712316, 0, 1, 0, 0.520712316, 0, 0.853732228))
                        until (Vector3.new(- 13336.127, 484.521179, - 6985.31689) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                        wait(2)
                        EquipWeapon("Holy Torch")
                        repeat
                            wait(0.2)
                            topos(CFrame.new(- 13487.623, 336.436188, - 7924.53857, - 0.982848108, 0, 0.184417039, 0, 1, 0, - 0.184417039, 0, - 0.982848108))
                        until (Vector3.new(- 13487.623, 336.436188, - 7924.53857) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                        wait(2)
                        Com()
                        wait(20)
                    elseif not (game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch")) then
                        if (Vector3.new(5153.18799, 172.82933, 909.815918) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5000 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.58203125, 25.419387817382812, - 125.94227600097656))
                        end
                        topos(CFrame.new(5153.18799, 172.82933, 909.815918))
                        wait(3)
                    end
                end
            end)
        end
    end)
    v281.M:AddSection("Hallow Scythe")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Hallow Scythe",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p810)
        _G.FarmBossHallow = p810
        StopTween(_G.FarmBossHallow)
    end)
    ToggleHop = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Hallow Scythe Hop",
        ["Default"] = false
    })
    ToggleHop:OnChanged(function(p811)
        _G.FarmBossHallowHop = p811
    end)
    spawn(function()
        while wait() do
            if _G.FarmBossHallow then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        local v812, v813, v814 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v815
                            v814, v815 = v812(v813, v814)
                            if v814 == nil then
                                break
                            end
                            if string.find(v815.Name, "Soul Reaper") then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    TP2(v815.HumanoidRootPart.CFrame * Pos)
                                    v815.HumanoidRootPart.Transparency = 1
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until v815.Humanoid.Health <= 0 or _G.FarmBossHallow == false
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                        repeat
                            topos(CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125))
                            wait()
                        until (CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
                        EquipWeapon("Hallow Essence")
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif _G.FarmBossHallowHop then
                        Hop()
                    end
                end)
            end
        end
    end)
end
if World2 or World3 then
    v281.M:AddSection("Soul Guitar")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Soul Guitar ( Test )",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p816)
        _G.Guitar = p816
        StopTween(_G.Guitar)
    end)
    task.spawn(function()
        repeat
            task.wait()
        until _G.Guitar
        while task.wait() do
            pcall(function()
                if _G.Guitar and World3 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check") == nil then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
						-- goto l3
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp == false then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") then
                            local v817, v818, v819 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                            while true do
                                local v820
                                v819, v820 = v817(v818, v819)
                                if v819 == nil then
                                    break
                                end
                                if v820.Name == "Living Zombie" and (v820:FindFirstChild("HumanoidRootPart") and (v820:FindFirstChild("Humanoid") and v820:FindFirstChild("Humanoid").Health > 0)) then
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        v820.HumanoidRootPart.CanCollide = false
                                        v820.Head.CanCollide = false
                                        TP2(v820.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                        _G.PosMon = v820.HumanoidRootPart.CFrame
                                        StartMagnet = true
                                    until not _G.Guitar or (v820.Humanoid.Health <= 0 or not v820.Parent) or game:GetService("Workspace").Map["Haunted Castle"].SwampWater.Color ~= Color3.fromRGB(117, 0, 0)
                                end
                            end
                        else
                            StartMagnet = false
                            topos(CFrame.new(- 10170.7275390625, 138.6524658203125, 5934.26513671875))
                        end
						-- goto l3
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones == false then
                        GetFirePlacard("7", "Left")
                        GetFirePlacard("6", "Left")
                        GetFirePlacard("5", "Left")
                        GetFirePlacard("4", "Right")
                        GetFirePlacard("3", "Left")
                        GetFirePlacard("2", "Right")
                        GetFirePlacard("1", "Right")
						-- goto l3
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Ghost == false then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
						-- goto l3
                    end
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies ~= false then
						-- ::l42::
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == false then
                            topos(CFrame.new(- 9628.02734375, 6.13064432144165, 6157.47802734375))
                            repeat
                                task.wait()
                            until not _G.Guitar or GetDistance(CFrame.new(- 9628.02734375, 6.13064432144165, 6157.47802734375)) <= 10
                            for v823 = 10, 10 do
                                if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v823)].BrickColor ~= "Storm blue" then
                                    local v822 = v823
                                    while true do
                                        task.wait()
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v823)].ClickDetector)
                                        local v823
                                        if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v823)].BrickColor == "Storm blue" then
                                            v823 = v822
                                            break
                                        end
                                        if not _G.Guitar then
                                            v823 = v822
                                            break
                                        end
                                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == true then
                                            v823 = v822
                                            break
                                        end
                                    end
                                end
                            end
                            for v826 = 8, 8 do
                                if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v826)].BrickColor ~= game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].Pipes["Part" .. tostring(v826)]["Part" .. tostring(v826)].BrickColor then
                                    local v825 = v826
                                    while true do
                                        task.wait()
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v826)].ClickDetector)
                                        local v826
                                        if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v826)].BrickColor == game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].Pipes["Part" .. tostring(v826)]["Part" .. tostring(v826)].BrickColor then
                                            v826 = v825
                                            break
                                        end
                                        if not _G.Guitar then
                                            v826 = v825
                                            break
                                        end
                                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == true then
                                            v826 = v825
                                            break
                                        end
                                    end
                                end
                            end
                            for v829 = 6, 6 do
                                if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v829)].BrickColor ~= game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].Pipes["Part" .. tostring(v829)]["Part" .. tostring(v829)].BrickColor then
                                    local v828 = v829
                                    while true do
                                        task.wait()
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v829)].ClickDetector)
                                        local v829
                                        if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v829)].BrickColor == game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].Pipes["Part" .. tostring(v829)]["Part" .. tostring(v829)].BrickColor then
                                            v829 = v828
                                            break
                                        end
                                        if not _G.Guitar then
                                            v829 = v828
                                            break
                                        end
                                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == true then
                                            v829 = v828
                                            break
                                        end
                                    end
                                end
                            end
                            for v832 = 3, 4 do
                                if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v832)].BrickColor ~= game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].Pipes["Part" .. tostring(v832)]["Part" .. tostring(v832)].BrickColor then
                                    local v831 = v832
                                    while true do
                                        task.wait(5)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v832)].ClickDetector)
                                        local v832
                                        if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model["Part" .. tostring(v832)].BrickColor == game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].Pipes["Part" .. tostring(v832)]["Part" .. tostring(v832)].BrickColor then
                                            v832 = v831
                                            break
                                        end
                                        if not _G.Guitar then
                                            v832 = v831
                                            break
                                        end
                                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == true then
                                            v832 = v831
                                            break
                                        end
                                    end
                                end
                            end
                            if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1.BrickColor ~= game:GetService("Workspace").Map["Haunted Castle"].IslandModel["gamma_Cube.275"].BrickColor then
                                repeat
                                    task.wait()
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1.ClickDetector)
                                until game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1.BrickColor == game:GetService("Workspace").Map["Haunted Castle"].IslandModel["gamma_Cube.275"].BrickColor or not _G.Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == true
                            end
                        end
                    else
                        repeat
                            wait()
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"))
                        until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment2.Line.Position.Y == - 1000 or not _G.Guitar
                        repeat
                            wait()
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"))
                        until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment5.Line.Position.Y == - 1000 or not _G.Guitar
                        repeat
                            wait()
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"))
                        until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment6.Line.Position.Y == - 1000 or not _G.Guitar
                        repeat
                            wait()
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"))
                        until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment8.Line.Position.Y == - 1000 or not _G.Guitar
                        repeat
                            wait()
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"))
                        until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment9.Line.Position.Y == - 1000 or not _G.Guitar
                        if getTrophies(1)[1] then
                            repeat
                                wait()
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"))
                            until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1.Line.Rotation.Z == getTrophies(1)[2] or (game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1.Line.Rotation.Z == getTrophies(1)[3] or not _G.Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == true)
                        end
                        if getTrophies(2)[1] then
                            repeat
                                wait()
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"))
                            until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment3.Line.Rotation.Z == getTrophies(2)[2] or (game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment3.Line.Rotation.Z == getTrophies(1)[3] or not _G.Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == true)
                        end
                        if getTrophies(3)[1] then
                            repeat
                                wait()
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"))
                            until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment4.Line.Rotation.Z == getTrophies(3)[2] or (game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment4.Line.Rotation.Z == getTrophies(1)[3] or not _G.Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == true)
                        end
                        if getTrophies(4)[1] then
                            repeat
                                wait()
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"))
                            until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment7.Line.Rotation.Z == getTrophies(4)[2] or (game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment7.Line.Rotation.Z == getTrophies(1)[3] or not _G.Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == true)
                        end
                        if not getTrophies(5)[1] then
							-- goto l3
                        end
                        wait()
                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"))
                        if game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment10.Line.Rotation.Z ~= getTrophies(5)[2] and (game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment10.Line.Rotation.Z ~= getTrophies(1)[3] and _G.Guitar and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies ~= true) then
							-- goto l42
                        end
                    end
                end
				-- ::l3::
            end)
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Soul Guitar Full",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p833)
        Auto_Quest_Soul_Guitar = p833
        if p833 == false then
            topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            StopTween(Auto_Quest_Soul_Guitar)
        end
    end)
    LPH_NO_VIRTUALIZE(function()
		-- upvalues: (ref) vu1
        vu1.spawn(function()
            while wait() do
                if setscriptable then
                    setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                end
                if sethiddenproperty then
                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                end
            end
        end)
    end)()
    function InMyNetWork(p834)
        if isnetworkowner then
            return isnetworkowner(p834)
        else
            return (p834.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200
        end
    end
    spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            pcall(function()
                if StartMagnet then
                    local v835, v836, v837 = pairs(game.Workspace.Enemies:GetChildren())
                    while true do
                        local v838
                        v837, v838 = v835(v836, v837)
                        if v837 == nil then
                            break
                        end
                        if not string.find(v838.Name, "Boss") and ((v838.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 and InMyNetWork(v838.HumanoidRootPart)) then
                            v838.HumanoidRootPart.CFrame = PosMon
                            v838.Humanoid.JumpPower = 0
                            v838.Humanoid.WalkSpeed = 0
                            v838.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v838.HumanoidRootPart.CanCollide = false
                            v838.Head.CanCollide = false
                            v838.Humanoid:ChangeState(14)
                            v838.Humanoid:ChangeState(11)
                        end
                    end
                end
            end)
        end)
    end)
    LPH_JIT_MAX(function()
		-- upvalues: (ref) vu1
        vu1.spawn(function()
            while wait() do
                if StartSoulGuitarMagnt then
                    pcall(function()
                        local v839, v840, v841 = pairs(game.Workspace.Enemies:GetChildren())
                        while true do
                            local v842
                            v841, v842 = v839(v840, v841)
                            if v841 == nil then
                                break
                            end
                            if v842.Name == "Living Zombie" then
                                v842.HumanoidRootPart.CFrame = CFrame.new(- 10138.3974609375, 138.6524658203125, 5902.89208984375)
                                v842.Head.CanCollide = false
                                v842.Humanoid.Sit = false
                                v842.HumanoidRootPart.CanCollide = false
                                v842.Humanoid.JumpPower = 0
                                v842.Humanoid.WalkSpeed = 0
                                if v842.Humanoid:FindFirstChild("Animator") then
                                    v842.Humanoid:FindFirstChild("Animator"):Destroy()
                                end
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        end
                    end)
                end
            end
        end)
    end)()
    vu1.spawn(function()
        while wait() do
            pcall(function()
                if GetWeaponInventory("Soul Guitar") == false and Auto_Quest_Soul_Guitar then
                    if GetMaterial("Bones") < 500 or (GetMaterial("Ectoplasm") < 250 or GetMaterial("Dark Fragment") < 1) then
                        if GetMaterial("Ectoplasm") > 250 then
                            if GetMaterial("Bones") <= 500 then
                                if World3 then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy"))) then
                                        local v843, v844, v845 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                        while true do
                                            local v846
                                            v845, v846 = v843(v844, v845)
                                            if v845 == nil then
                                                break
                                            end
                                            if (v846.Name == "Reborn Skeleton" or (v846.Name == "Living Zombie" or (v846.Name == "Demonic Soul" or v846.Name == "Posessed Mummy"))) and (v846:FindFirstChild("Humanoid") and (v846:FindFirstChild("HumanoidRootPart") and v846.Humanoid.Health > 0)) then
                                                repeat
                                                    wait()
                                                    StartMagnet = true
                                                    EquipWeapon(_G.SelectWeapon)
                                                    PosMon = v846.HumanoidRootPart.CFrame
                                                    v846.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                    v846.HumanoidRootPart.Transparency = 1
                                                    v846.Humanoid.JumpPower = 0
                                                    v846.Humanoid.WalkSpeed = 0
                                                    v846.HumanoidRootPart.CanCollide = false
                                                    v846.Humanoid:ChangeState(11)
                                                    TP2(v846.HumanoidRootPart.CFrame * Pos)
                                                until not Auto_Quest_Soul_Guitar or (v846.Humanoid.Health <= 0 or (not v846.Parent or v846.Humanoid.Health <= 0))
                                                StartMagnet = false
                                            end
                                        end
                                    else
                                        topos(CFrame.new(- 9504.8564453125, 172.14292907714844, 6057.259765625))
                                    end
                                else
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                end
                            end
                        elseif World2 then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior")))) then
                                local v847, v848, v849 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                while true do
                                    local v850
                                    v849, v850 = v847(v848, v849)
                                    if v849 == nil then
                                        break
                                    end
                                    if (v850.Name == "Ship Deckhand" or (v850.Name == "Ship Engineer" or (v850.Name == "Ship Steward" or (v850.Name == "Ship Officer" or v850.Name == "Arctic Warrior")))) and (v850:FindFirstChild("Humanoid") and (v850:FindFirstChild("HumanoidRootPart") and v850.Humanoid.Health > 0)) then
                                        repeat
                                            wait()
                                            StartMagnet = true
                                            EquipWeapon(_G.SelectWeapon)
                                            PosMon = v850.HumanoidRootPart.CFrame
                                            v850.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            v850.HumanoidRootPart.Transparency = 1
                                            v850.Humanoid.JumpPower = 0
                                            v850.Humanoid.WalkSpeed = 0
                                            v850.HumanoidRootPart.CanCollide = false
                                            v850.Humanoid:ChangeState(11)
                                            TP2(v850.HumanoidRootPart.CFrame * Pos)
                                        until not Auto_Quest_Soul_Guitar or (not v850.Parent or v850.Humanoid.Health <= 0)
                                        StartMagnet = false
                                    end
                                end
                            else
                                StartMagnet = false
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                        end
                    elseif (CFrame.new(- 9681.458984375, 6.139880657196045, 6341.3720703125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                        topos(CFrame.new(- 9681.458984375, 6.139880657196045, 6341.3720703125))
                    elseif game:GetService("Workspace").Map["Haunted Castle"].Candle1.Transparency ~= 0 then
                        if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2), "Error") then
                            print("Go to Grave")
                            topos(CFrame.new(- 8653.2060546875, 140.98487854003906, 6160.033203125))
                        elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2), "Nothing") then
                            print("Wait Next Night")
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
                        end
                    else
                        local v851 = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
                        local v852 = v851:InvokeServer("GuitarPuzzleProgress", "Check")
                        if not v852 then
                            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent", 2) ~= true then
                                if Auto_Quest_Soul_Guitar_Hop then
                                    ServerFunc:NormalTeleport()
                                end
                            else
                                v851:InvokeServer("gravestoneEvent", 2, true)
                            end
                        end
                        if v852 then
                            local v853 = v852.Swamp
                            local v854 = v852.Gravestones
                            local v855 = v852.Ghost
                            local v856 = v852.Trophies
                            local v857 = v852.Pipes
                            local _ = v852.CraftedOnce
                            if v853 and (v854 and (v855 and (v856 and v857))) then
                                Auto_Quest_Soul_Guitar = false
                            end
                            if not v853 then
                                repeat
                                    wait()
                                    topos(CFrame.new(- 10141.462890625, 138.6524658203125, 5935.06298828125) * CFrame.new(0, 30, 0))
                                until game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(- 10141.462890625, 138.6524658203125, 5935.06298828125)) <= 100
                                local v858, v859, v860 = pairs(game.Workspace.Enemies:GetChildren())
                                while true do
                                    local v861
                                    v860, v861 = v858(v859, v860)
                                    if v860 == nil then
                                        break
                                    end
                                    if v861.Name == "Living Zombie" and (v861:FindFirstChild("Humanoid") and v861:FindFirstChild("HumanoidRootPart")) and game.Players.LocalPlayer:DistanceFromCharacter(v861.HumanoidRootPart.Position) <= 2000 then
                                        repeat
                                            wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            v861.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            v861.HumanoidRootPart.Transparency = 1
                                            v861.HumanoidRootPart.CFrame = CFrame.new(- 10138.3974609375, 138.6524658203125, 5902.89208984375)
                                            StartSoulGuitarMagnt = true
                                            v861.Humanoid.JumpPower = 0
                                            v861.Humanoid.WalkSpeed = 0
                                            v861.HumanoidRootPart.CanCollide = false
                                            v861.Humanoid:ChangeState(11)
                                            TP2(v861.HumanoidRootPart.CFrame * CFrame.new(0, 30, 15))
                                        until not v861.Parent or (v861.Humanoid.Health <= 0 or not (v861:FindFirstChild("HumanoidRootPart") and (v861:FindFirstChild("Humanoid") and Auto_Quest_Soul_Guitar)))
                                        StartSoulGuitarMagnt = false
                                    end
                                end
                            end
                            wait(1)
                            if v853 and not v854 then
                                v851:InvokeServer("GuitarPuzzleProgress", "Gravestones")
                            end
                            wait(1)
                            if v853 and (v854 and not v855) then
                                v851:InvokeServer("GuitarPuzzleProgress", "Ghost")
                            end
                            wait(1)
                            if v853 and (v854 and (v855 and not v856)) then
                                v851:InvokeServer("GuitarPuzzleProgress", "Trophies")
                            end
                            wait(1)
                            if v853 and (v854 and (v855 and (v856 and not v857))) then
                                v851:InvokeServer("GuitarPuzzleProgress", "Pipes")
                            end
                        end
                    end
                end
            end)
        end
    end)
end
if World3 then
    v281.M:AddSection("Buddy Sword")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Buddy Sword",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p862)
        _G.BudySword = p862
        StopTween(_G.BudySword)
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Buddy Sword Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p863)
        _G.BudySwordHop = p863
    end)
    local vu864 = CFrame.new(- 731.2034301757812, 381.5658874511719, - 11198.4951171875)
    spawn(function()
		-- upvalues: (ref) vu864
        while wait() do
            if _G.BudySword and World3 then
                pcall(function()
					-- upvalues: (ref) vu864
                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                        local v865, v866, v867 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v868
                            v867, v868 = v865(v866, v867)
                            if v867 == nil then
                                break
                            end
                            if v868.Name == "Cake Queen" and (v868:FindFirstChild("Humanoid") and (v868:FindFirstChild("HumanoidRootPart") and v868.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v868.HumanoidRootPart.CanCollide = false
                                    v868.Humanoid.WalkSpeed = 0
                                    TP2(v868.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.BudySword or (not v868.Parent or v868.Humanoid.Health <= 0)
                            end
                        end
                    else
                        topos(vu864)
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif _G.BudySwordHop then
                            Hop()
                        end
                    end
                end)
            end
        end
    end)
    v281.M:AddSection("Dual Curse Katana")
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Finish Tushita Quest",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p869)
        Tushita_Quest = p869
        if p869 == false then
            topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            StopTween(Tushita_Quest)
        end
    end)
    spawn(function()
		-- upvalues: (ref) vu1
        while vu1.wait() do
            pcall(function()
				-- upvalues: (ref) vu1
				-- block 169
                if not Tushita_Quest then
					-- ::l3::
                    return
                end
                if tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
                    wait(0.7)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
                    wait(0.3)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
                    warn("\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\128\224\184\155\224\184\180\224\184\148\224\185\128\224\184\155\224\184\180\224\184\148\224\184\155\224\184\163\224\184\176\224\184\149\224\184\185...")
					-- goto l3
                end
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == nil then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
					-- goto l3
                end
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished ~= false then
					-- goto l3
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == - 3 then
                    repeat
                        wait()
                        topos(CFrame.new(- 4602.5107421875, 16.446542739868164, - 2880.998046875))
                    until (CFrame.new(- 4602.5107421875, 16.446542739868164, - 2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not Tushita_Quest or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1
                    if (CFrame.new(- 4602.5107421875, 16.446542739868164, - 2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        wait(0.7)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                    end
                    wait(1)
                    repeat
                        wait()
                        topos(CFrame.new(3914, 8, - 2582))
                    until (CFrame.new(4001.185302734375, 10.089399337768555, - 2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not Tushita_Quest or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1
                    if (CFrame.new(3914, 8, - 2582).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        wait(0.7)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                    end
                    wait(1)
                    repeat
                        wait()
                        topos(CFrame.new(- 9530.763671875, 7.245208740234375, - 8375.5087890625))
                    until (CFrame.new(- 9530.763671875, 7.245208740234375, - 8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not Tushita_Quest or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1
                    if (CFrame.new(- 9530.763671875, 7.245208740234375, - 8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        wait(0.7)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                    end
                    vu1.wait(1)
					-- goto l3
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == - 4 then
                    if game:GetService("Workspace").Enemies:FindFirstChildOfClass("Model") then
                        local v870, v871, v872 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v873
                            v872, v873 = v870(v871, v872)
                            if v872 == nil then
                                break
                            end
                            if (v873:FindFirstChild("HumanoidRootPart").Position - CFrame.new(- 5463.74560546875, 313.7947082519531, - 2844.50390625).Position).Magnitude > 1000 then
								-- ::l54::
                                topos(CFrame.new(- 5084.20849609375, 314.5412902832031, - 2975.078125))
                            elseif v873:FindFirstChild("HumanoidRootPart") and (v873:FindFirstChild("Humanoid") and v873:FindFirstChild("Humanoid").Health > 0) then
                                vu1.wait()
                                EquipWeapon(_G.SelectWeapon)
                                v873.HumanoidRootPart.CanCollide = false
                                v873.Head.CanCollide = false
                                TP2(v873.HumanoidRootPart.CFrame * Pos)
                                PosTHQuest = v873.HumanoidRootPart.CFrame
                                MagnetTHQuest = true
                                NameTH = v873.Name
                                if Tushita_Quest and (v873.Humanoid.Health > 0 and v873.Parent) and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) ~= 2 then
									-- goto l54
                                end
                            end
                        end
                    else
                        topos(CFrame.new(- 5084.20849609375, 314.5412902832031, - 2975.078125))
                    end
					-- goto l3
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) ~= - 5 then
					-- goto l3
                end
                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                    local v874, v875, v876 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v877
                        v876, v877 = v874(v875, v876)
                        if v876 == nil then
                            break
                        end
                        if v877.Name == "Cake Queen" and (v877:FindFirstChild("Humanoid") and (v877:FindFirstChild("HumanoidRootPart") and v877.Humanoid.Health > 0)) then
                            repeat
                                vu1.wait()
                                EquipWeapon(_G.SelectWeapon)
                                v877.HumanoidRootPart.CanCollide = false
                                v877.Head.CanCollide = false
                                TP2(v877.HumanoidRootPart.CFrame * Pos)
                            until not Tushita_Quest or (not v877.Parent or v877.Humanoid.Health <= 0) or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 3
                        end
                    end
					-- goto l3
                end
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen") and game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").Humanoid.Health > 0 then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
					-- goto l3
                end
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.HeavenlyDimension.Spawn.Position).Magnitude > 1000 then
					-- goto l3
                end
                local v878, v879, v880 = pairs(game:GetService("Workspace").Map.HeavenlyDimension.Exit:GetChildren())
                while true do
                    local v881
                    v880, v881 = v878(v879, v880)
                    if v880 == nil then
                        break
                    end
                    Ex = v880
                end
                if Ex == 2 then
                    repeat
                        vu1.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame
                    until not Tushita_Quest or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 3
                end
				-- goto l107
				-- ::l119::
                vu1.wait()
                topos(CFrame.new(- 22529.6171875, 5275.77392578125, 3873.5712890625))
                local v882, v883, v884 = pairs(game:GetService("Workspace").Map.HeavenlyDimension:GetDescendants())
                while true do
                    local v885
                    v884, v885 = v882(v883, v884)
                    if v884 == nil then
                        break
                    end
                    if v885:IsA("ProximityPrompt") then
                        fireproximityprompt(v885)
                    end
                end
                if (CFrame.new(- 22529.6171875, 5275.77392578125, 3873.5712890625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 5 then
					-- goto l119
                end
                wait(2)
                _G.DoneT1 = true
                if Tushita_Quest and not _G.DoneT1 then
					-- ::l107::
                    vu1.wait()
					-- goto l119
                end
				-- goto l122
				-- ::l132::
                vu1.wait()
                topos(CFrame.new(- 22637.291015625, 5281.365234375, 3749.28857421875))
                local v886, v887, v888 = pairs(game:GetService("Workspace").Map.HeavenlyDimension:GetDescendants())
                while true do
                    local v889
                    v888, v889 = v886(v887, v888)
                    if v888 == nil then
                        break
                    end
                    if v889:IsA("ProximityPrompt") then
                        fireproximityprompt(v889)
                    end
                end
                if (CFrame.new(- 22637.291015625, 5281.365234375, 3749.28857421875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 5 then
					-- goto l132
                end
                wait(2)
                _G.DoneT2 = true
                if not _G.DoneT2 and Tushita_Quest ~= false then
					-- ::l122::
                    vu1.wait()
					-- goto l132
                end
				-- goto l135
				-- ::l145::
                vu1.wait()
                topos(CFrame.new(- 22791.14453125, 5277.16552734375, 3764.570068359375))
                local v890, v891, v892 = pairs(game:GetService("Workspace").Map.HeavenlyDimension:GetDescendants())
                while true do
                    local v893
                    v892, v893 = v890(v891, v892)
                    if v892 == nil then
                        break
                    end
                    if v893:IsA("ProximityPrompt") then
                        fireproximityprompt(v893)
                    end
                end
                if (CFrame.new(- 22791.14453125, 5277.16552734375, 3764.570068359375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 5 then
					-- goto l145
                end
                wait(2)
                _G.DoneT3 = true
                if _G.DoneT3 or Tushita_Quest == false then
                    local v894, v895, v896 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v897
                        v896, v897 = v894(v895, v896)
                        if v896 == nil then
                            break
                        end
                        if (v897:FindFirstChild("HumanoidRootPart").Position - CFrame.new(- 22695.7012, 5270.93652, 3814.42847, 0.11794927, 3.32185834e-8, 0.99301964, - 8.73070718e-8, 1, - 2.30819008e-8, - 0.99301964, - 8.3975138e-8, 0.11794927).Position).Magnitude > 300 then
                            MagnetTHQuest = false
                        elseif v897:FindFirstChild("HumanoidRootPart") and (v897:FindFirstChild("Humanoid") and v897:FindFirstChild("Humanoid").Health > 0) then
                            repeat
                                vu1.wait()
                                EquipWeapon(_G.SelectWeapon)
                                v897.HumanoidRootPart.CanCollide = false
                                v897.Head.CanCollide = false
                                TP2(v897.HumanoidRootPart.CFrame * Pos)
                                PosTHQuest = v897.HumanoidRootPart.CFrame
                                MagnetTHQuest = true
                                NameTH = v897.Name
                            until not Tushita_Quest or (v897.Humanoid.Health <= 0 or not v897.Parent)
                        end
                    end
					-- goto l3
                end
				-- ::l135::
                wait()
				-- goto l145
            end)
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Finish Yama Quest",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p898)
        Yama_Quest = p898
        if p898 == false then
            topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            StopTween(Yama_Quest)
        end
    end)
    PosMsList = {
        ["Pirate Millionaire"] = CFrame.new(- 426, 176, 5558),
        ["Pistol Billionaire"] = CFrame.new(- 83, 127, 6097),
        ["Dragon Crew Warrior"] = CFrame.new(6320, 52, - 1282),
        ["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
        ["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),
        ["Giant Islander"] = CFrame.new(4902, 670, 39),
        ["Marine Commodore"] = CFrame.new(2401, 123, - 7589),
        ["Marine Rear Admiral"] = CFrame.new(3588, 229, - 7085),
        ["Fishman Raider"] = CFrame.new(- 10941, 332, - 8760),
        ["Fishman Captain"] = CFrame.new(- 11035, 332, - 9087),
        ["Forest Pirate"] = CFrame.new(- 13446, 413, - 7760),
        ["Mythological Pirate"] = CFrame.new(- 13510, 584, - 6987),
        ["Jungle Pirate"] = CFrame.new(- 11778, 426, - 10592),
        ["Musketeer Pirate"] = CFrame.new(- 13282, 496, - 9565),
        ["Reborn Skeleton"] = CFrame.new(- 8764, 142, 5963),
        ["Living Zombie"] = CFrame.new(- 10227, 421, 6161),
        ["Demonic Soul"] = CFrame.new(- 9579, 6, 6194),
        ["Posessed Mummy"] = CFrame.new(- 9579, 6, 6194),
        ["Peanut Scout"] = CFrame.new(- 1993, 187, - 10103),
        ["Peanut President"] = CFrame.new(- 2215, 159, - 10474),
        ["Ice Cream Chef"] = CFrame.new(- 877, 118, - 11032),
        ["Ice Cream Commander"] = CFrame.new(- 877, 118, - 11032),
        ["Cookie Crafter"] = CFrame.new(- 2021, 38, - 12028),
        ["Cake Guard"] = CFrame.new(- 2024, 38, - 12026),
        ["Baking Staff"] = CFrame.new(- 1932, 38, - 12848),
        ["Head Baker"] = CFrame.new(- 1932, 38, - 12848),
        ["Cocoa Warrior"] = CFrame.new(95, 73, - 12309),
        ["Chocolate Bar Battler"] = CFrame.new(647, 42, - 12401),
        ["Sweet Thief"] = CFrame.new(116, 36, - 12478),
        ["Candy Rebel"] = CFrame.new(47, 61, - 12889),
        ["Ghost"] = CFrame.new(5251, 5, 1111)
    }
    vu1.spawn(function()
		-- upvalues: (ref) vu1
        while vu1.wait() do
            pcall(function()
				-- upvalues: (ref) vu1
				-- block 171
                if not Yama_Quest then
					-- ::l3::
                    return
                end
                if tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
					-- goto l3
                end
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == nil then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
					-- goto l3
                end
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished ~= false then
					-- goto l3
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == - 3 then
                    while true do
                        if true then
                            vu1.wait()
                            if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
                                local v899, v900, v901 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                                while true do
                                    local vu902
                                    v901, vu902 = v899(v900, v901)
                                    if v901 == nil then
                                        break
                                    end
                                    if vu902.Name == "Forest Pirate" then
                                        PosMon = vu902.HumanoidRootPart.CFrame
                                        spawn(function()
											-- upvalues: (ref) vu902
                                            BringMobs(PosMon, vu902.Name)
                                        end)
                                        topos(game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate").HumanoidRootPart.CFrame)
                                    end
                                end
                            else
                                topos(CFrame.new(- 13223.521484375, 428.1938171386719, - 7766.06787109375))
                            end
                        end
                        if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 1 or not Yama_Quest then
							-- goto l3
                        end
                    end
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == - 4 then
					-- goto l30
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= - 5 or (not game:GetService("Workspace").Map:FindFirstChild("HellDimension") or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.HellDimension.Spawn.Position).Magnitude > 1000) then
					-- goto l3
                end
                local v903, v904, v905 = pairs(game:GetService("Workspace").Map.HellDimension.Exit:GetChildren())
                while true do
                    local v906
                    v905, v906 = v903(v904, v905)
                    if v905 == nil then
                        break
                    end
                    if tonumber(v905) == 2 then
                        repeat
                            vu1.wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Exit.CFrame
                        until not Yama_Quest or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3
                    end
                end
                if not game.Players.LocalPlayer.Character:FindFirstChild(_G.SelectWeapon) then
                    wait()
                    EquipWeapon(_G.SelectWeapon)
                end
                if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 then
					-- ::l105::
                    local v907, v908, v909 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local vu910
                        v909, vu910 = v907(v908, v909)
                        if v909 == nil then
                            break
                        end
                        if (vu910:FindFirstChild("HumanoidRootPart").Position - game:GetService("Workspace").Map.HellDimension.Spawn.Position).Magnitude > 300 then
							-- ::l154::
                            MagnetYamaQuest = false
                        elseif vu910:FindFirstChild("HumanoidRootPart") and (vu910:FindFirstChild("Humanoid") and vu910:FindFirstChild("Humanoid").Health > 0) then
                            vu1.wait()
                            EquipWeapon(_G.SelectWeapon)
                            vu910.HumanoidRootPart.CanCollide = false
                            vu910.Head.CanCollide = false
                            TP2(vu910.HumanoidRootPart.CFrame * Pos)
                            PosMon = vu910.HumanoidRootPart.CFrame
                            spawn(function()
								-- upvalues: (ref) vu910
                                BringMobs(PosMon, vu910.Name)
                            end)
                            if Yama_Quest and (vu910.Humanoid.Health > 0 and vu910.Parent) and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
								-- goto l154
                            end
                        end
                    end
					-- goto l3
                end
				-- goto l104
				-- ::l30::
                local v911, v912, v913 = pairs(game:GetService("Players").LocalPlayer.QuestHaze:GetChildren())
				-- goto l32
				-- ::l3::
				-- ::l35::
                if string.find(v914, v916.Name) and v916.Value > 0 then
					-- goto l2
                end
				-- ::l34::
                local v914, v915 = v917(v918, v914)
                if v914 ~= nil then
					-- goto l3
                end
				-- ::l32::
                local v916
                v913, v916 = v911(v912, v913)
                if v913 == nil then
					-- goto l3
                end
                local v917, v918
                v917, v918, v914 = pairs(PosMsList)
				-- goto l34
				-- ::l2::
				-- ::l31::
				-- ::l39::
                if game:GetService("Workspace").Enemies:FindFirstChild(v914) then
					-- goto l41
                end
                local v919 = v914
				-- goto l42
				-- ::l41::
                local v920, v921, v922 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                while true do
                    local vu923
                    v922, vu923 = v920(v921, v922)
                    if v922 == nil then
                        break
                    end
                    if vu923:FindFirstChild("HumanoidRootPart") and (vu923:FindFirstChild("Humanoid") and (vu923:FindFirstChild("Humanoid").Health > 0 and vu923:FindFirstChild("HazeESP"))) then
                        repeat
                            vu1.wait()
                            StartMagnet = true
                            EquipWeapon(_G.SelectWeapon)
                            vu923.HumanoidRootPart.CanCollide = false
                            vu923.Head.CanCollide = false
                            TP2(vu923.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            PosMon = vu923.HumanoidRootPart.CFrame
                            spawn(function()
								-- upvalues: (ref) vu923
                                BringMobs(PosMon, vu923.Name)
                            end)
                        until not Yama_Quest or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 2
                    end
                end
				-- goto l34
				-- ::l42::
                if true then
                    wait()
                    if game:GetService("Workspace").Enemies:FindFirstChild(v914) then
                        local v924, v925, v926 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local vu927
                            v926, vu927 = v924(v925, v926)
                            if v926 == nil then
                                break
                            end
                            if vu927:FindFirstChild("HumanoidRootPart") and (vu927:FindFirstChild("Humanoid") and (vu927:FindFirstChild("Humanoid").Health > 0 and vu927:FindFirstChild("HazeESP"))) then
                                repeat
                                    vu1.wait()
                                    StartMagnet = true
                                    EquipWeapon(_G.SelectWeapon)
                                    vu927.HumanoidRootPart.CanCollide = false
                                    vu927.Head.CanCollide = false
                                    TP2(vu927.HumanoidRootPart.CFrame * Pos)
                                    PosMon = vu927.HumanoidRootPart.CFrame
                                    spawn(function()
										-- upvalues: (ref) vu927
                                        BringMobs(PosMon, vu927.Name)
                                    end)
                                    local v928 = vu927
                                until not (vu927.FindFirstChild(v928, "HazeESP") and Yama_Quest) or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 2
                            end
                        end
                    else
                        topos(v915)
                    end
                end
                if Yama_Quest then
					-- goto l42
                end
                v914 = v919
				-- goto l34
				-- ::l114::
                vu1.wait()
                topos(game:GetService("Workspace").Map.HellDimension.Torch1.Particles.CFrame)
                local v929, v930, v931 = pairs(game:GetService("Workspace").Map.HellDimension:GetDescendants())
                while true do
                    local v932
                    v931, v932 = v929(v930, v931)
                    if v931 == nil then
                        break
                    end
                    if v932:IsA("ProximityPrompt") then
                        fireproximityprompt(v932)
                    end
                end
                if (game:GetService("Workspace").Map.HellDimension.Torch1.Particles.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 5 then
					-- goto l114
                end
                wait(2)
                _G.T1Yama = true
                if Yama_Quest and not _G.T1Yama and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
					-- ::l104::
                    vu1.wait()
					-- goto l114
                end
				-- goto l117
				-- ::l129::
                vu1.wait()
                topos(game:GetService("Workspace").Map.HellDimension.Torch2.Particles.CFrame)
                local v933, v934, v935 = pairs(game:GetService("Workspace").Map.HellDimension:GetDescendants())
                while true do
                    local v936
                    v935, v936 = v933(v934, v935)
                    if v935 == nil then
                        break
                    end
                    if v936:IsA("ProximityPrompt") then
                        fireproximityprompt(v936)
                    end
                end
                if (game:GetService("Workspace").Map.HellDimension.Torch2.Particles.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 5 then
					-- goto l129
                end
                wait(2)
                _G.T2Yama = true
                if not _G.T2Yama and Yama_Quest ~= false and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
					-- ::l117::
                    vu1.wait()
					-- goto l129
                end
				-- goto l132
				-- ::l144::
                vu1.wait()
                topos(game:GetService("Workspace").Map.HellDimension.Torch3.Particles.CFrame)
                local v937, v938, v939 = pairs(game:GetService("Workspace").Map.HellDimension:GetDescendants())
                while true do
                    local v940
                    v939, v940 = v937(v938, v939)
                    if v939 == nil then
                        break
                    end
                    if v940:IsA("ProximityPrompt") then
                        fireproximityprompt(v940)
                    end
                end
                if (game:GetService("Workspace").Map.HellDimension.Torch3.Particles.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 5 then
					-- goto l144
                end
                wait(2)
                _G.T3Yama = true
                if _G.T3Yama or Yama_Quest == false or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 then
					-- goto l105
                end
				-- ::l132::
                wait()
				-- goto l144
            end)
        end
    end)
    spawn(function()
		-- upvalues: (ref) vu1
        while vu1.wait() do
            pcall(function()
				-- upvalues: (ref) vu1
                if Yama_Quest and (tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == - 5 and (not game:GetService("Workspace").Map:FindFirstChild("HellDimension") or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.HellDimension.Spawn.Position).Magnitude > 1000)) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        local v941, v942, v943 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v944
                            v943, v944 = v941(v942, v943)
                            if v943 == nil then
                                break
                            end
                            if string.find(v944.Name, "Soul Reaper") then
                                repeat
                                    vu1.wait()
                                    TP2(v944.HumanoidRootPart.CFrame)
                                until v944.Humanoid.Health <= 0 or not (Yama_Quest and v944.Parent) or (tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 or game:GetService("Workspace").Map:FindFirstChild("HellDimension") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.HellDimension.Spawn.Position).Magnitude <= 1000)
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                        repeat
                            topos(CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125))
                            vu1.wait()
                        until (CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
                        EquipWeapon("Hallow Essence")
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") and game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").Humanoid.Health > 0 then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") >= 50 or (game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") or (game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") or game:GetService("Workspace").Map:FindFirstChild("HellDimension"))) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace").Enemies:FindFirstChild("Domenic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy"))) then
                        local v945, v946, v947 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v948
                            v947, v948 = v945(v946, v947)
                            if v947 == nil then
                                break
                            end
                            if (v948.Name == "Reborn Skeleton" or (v948.Name == "Living Zombie" or (v948.Name == "Demonic Soul" or v948.Name == "Posessed Mummy"))) and (v948:FindFirstChild("HumanoidRootPart") and (v948:FindFirstChild("Humanoid") and v948:FindFirstChild("Humanoid").Health > 0)) then
                                repeat
                                    vu1.wait()
                                    BonesBring = true
                                    EquipWeapon(_G.SelectWeapon)
                                    v948.HumanoidRootPart.CanCollide = false
                                    v948.Head.CanCollide = false
                                    TP2(v948.HumanoidRootPart.CFrame * Pos)
                                    PosMonBone = v948.HumanoidRootPart.CFrame
                                until not Yama_Quest or (v948.Humanoid.Health <= 0 or not v948.Parent)
                            end
                        end
                    else
                        MagnetWaitY = false
                        topos(CFrame.new(- 9515.2255859375, 164.0062255859375, 5785.38330078125))
                    end
                end
            end)
        end
    end)
    Toggle = v281.M:AddToggle("Toggle", {
        ["Title"] = "Auto Get Cursed Dual Katana",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p949)
        Get_Cursed = p949
        if p949 == false then
            topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            StopTween(Get_Cursed)
        end
    end)
    vu1.spawn(function()
		-- upvalues: (ref) vu1
        while vu1.wait() do
            pcall(function()
				-- upvalues: (ref) vu1
				-- block 36
                if not Get_Cursed then
					-- ::l3::
                    return
                end
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Boss")
                if not game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss") then
                    topos(CFrame.new(- 12318.193359375, 601.9518432617188, - 6538.662109375))
                    vu1.wait(0.5)
                    topos(game:GetService("Workspace").Map.Turtle.Cursed.BossDoor.CFrame)
					-- goto l3
                end
                local v950, v951, v952 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				-- ::l7::
                local v953
                v952, v953 = v950(v951, v952)
                if v952 == nil then
					-- goto l3
                end
                if v953.Name ~= "Cursed Skeleton Boss" or (not v953:FindFirstChild("Humanoid") or (not v953:FindFirstChild("HumanoidRootPart") or v953.Humanoid.Health <= 0)) then
					-- goto l7
                end
				-- ::l16::
                if true then
                    vu1.wait()
                    if game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
                        EquipWeapon("Yama")
                    elseif game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
                        EquipWeapon("Tushita")
                    else
                        warn("Yama or Tushita Only!!!")
                        wait(5)
                    end
                end
                v953.HumanoidRootPart.CanCollide = false
                v953.Humanoid.WalkSpeed = 0
                TP2(v953.HumanoidRootPart.CFrame * Pos)
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                if Get_Cursed and (v953.Parent and v953.Humanoid.Health > 0) then
					-- goto l16
                else
					-- goto l3
                end
				-- ::l3::
				-- goto l7
            end)
        end
    end)
end
task.spawn(function()
    while true do
        wait()
        if setscriptable then
            setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
        end
        if sethiddenproperty then
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
        end
    end
end)
function InMyNetWork(p954)
    if isnetworkowner then
        return isnetworkowner(p954)
    else
        return (p954.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= _G.BringMode
    end
end
if World1 or World2 then
    v281.V4:AddSection("Go To The Third Sea")
end
if World3 then
    v281.V4:AddSection("Mirage")
    local vu955 = v281.V4:AddParagraph({
        ["Title"] = "Check Mirage",
        ["Desc"] = ""
    })
    task.spawn(function()
		-- upvalues: (ref) vu955
        while task.wait() do
            pcall(function()
				-- upvalues: (ref) vu955
                if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                    vu955:SetDesc("Check Mirage : Spawn!")
                else
                    vu955:SetDesc("Check Mirage : Not Spawn")
                end
            end)
        end
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Teleport Mirage Island",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p956)
        _G.MysticIsland = p956
        StopTween(_G.MysticIsland)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                local v957 = _G.MysticIsland and game:GetService("Workspace").Map:FindFirstChild("MysticIsland")
                if v957 then
                    local v958 = v957.WorldPivot.Position
                    topos(CFrame.new(v958.X, 500, v958.Z))
                end
            end
        end)
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Teleport Advanced Fruit Dealer",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p959)
        _G.Miragenpc = p959
        StopTween(_G.Miragenpc)
    end)
    spawn(function()
        while wait() do
            if _G.Miragenpc then
                local v960 = game.ReplicatedStorage.NPCs:FindFirstChild("Advanced Fruit Dealer")
                if v960 and v960:IsA("Model") then
                    local v961 = v960.PrimaryPart
                    if v961 then
                        v961 = v960.PrimaryPart.Position
                    end
                    if v961 then
                        topos(CFrame.new(v961))
                    end
                end
            end
        end
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Auto Lock Moon",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p962)
        _G.LockCamToMoon = p962
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.LockCamToMoon then
                    wait(0.1)
                    local v963 = game.Lighting:GetMoonDirection()
                    local v964 = game.Workspace.CurrentCamera.CFrame.p + v963 * 100
                    game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, v964)
                end
            end)
        end
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Tween Gear",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p965)
        _G.TweenMGear = p965
        StopTween(_G.TweenMGear)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.TweenMGear and game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                    local v966, v967, v968 = pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren())
                    while true do
                        local v969
                        v968, v969 = v966(v967, v968)
                        if v968 == nil then
                            break
                        end
                        if v969:IsA("MeshPart") and v969.Material == Enum.Material.Neon then
                            topos(v969.CFrame)
                        end
                    end
                end
            end
        end)
    end)
    v281.V4:AddSection("Race V4")
    v281.V4:AddButton({
        ["Title"] = "Teleport To Top Of GreatTree",
        ["Callback"] = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "RaceV4Progress",
                "Teleport"
            }))
            wait(0.1)
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286, 14897, 103)
            TP1(CFrame.new(28609.5801, 14896.5098, 105.869637, - 0.00754010677, 3.26780936e-9, - 0.999971569, 6.88313628e-9, 1, 3.21600124e-9, 0.999971569, - 6.85869184e-9, - 0.00754010677))
            wait(2)
            local v970 = game.Players.LocalPlayer
            local v971 = CFrame.new(28609.5801, 14896.5098, 105.869637).Position
            if v970.Character and (v970.Character:FindFirstChild("HumanoidRootPart") and (v970.Character.HumanoidRootPart.Position - v971).Magnitude < 3) then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "RaceV4Progress",
                    "TeleportBack"
                }))
            end
        end
    })
    v281.V4:AddButton({
        ["Title"] = "Teleport To Temple Of Time",
        ["Callback"] = function()
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286, 14897, 103)
        end
    })
    v281.V4:AddButton({
        ["Title"] = "Teleport To Lever Pull",
        ["Callback"] = function()
            TP2(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734))
        end
    })
    v281.V4:AddButton({
        ["Title"] = "Teleport To Acient One (Must Be in Temple Of Time!)",
        ["Callback"] = function()
            TP2(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375))
        end
    })
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Auto Buy Gear",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p972)
        _G.BuyGear = p972
    end)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.BuyGear then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack({
                        "UpgradeRace",
                        "Buy"
                    }))
                end
            end
        end)
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Disabled Inf Stairs",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p973)
        game.Players.LocalPlayer.Character.InfiniteStairs.Disabled = p973
    end)
    v281.V4:AddButton({
        ["Title"] = "Teleport Trial Door",
        ["Callback"] = function()
            local v974 = Game:GetService("Players").LocalPlayer
            local v975 = v974.Character.HumanoidRootPart
            v975.CFrame = CFrame.new(28286, 14897, 103)
            wait(0.1)
            v975.CFrame = CFrame.new(28286, 14897, 103)
            wait(0.1)
            v975.CFrame = CFrame.new(28286, 14897, 103)
            wait(0.1)
            v975.CFrame = CFrame.new(28286, 14897, 103)
            if v974.Data.Race.Value ~= "Fishman" then
                if v974.Data.Race.Value ~= "Human" then
                    if v974.Data.Race.Value ~= "Cyborg" then
                        if v974.Data.Race.Value ~= "Skypiea" then
                            if v974.Data.Race.Value ~= "Ghoul" then
                                if v974.Data.Race.Value == "Mink" then
                                    v975.CFrame = CFrame.new(28286, 14897, 103)
                                    wait(0.6)
                                    topos(CFrame.new(29020.66015625, 14889.4267578125, - 379.2682800292969))
                                end
                            else
                                v975.CFrame = CFrame.new(28286, 14897, 103)
                                wait(0.6)
                                topos(CFrame.new(28672.720703125, 14889.1279296875, 454.5961608886719))
                            end
                        else
                            v975.CFrame = CFrame.new(28286, 14897, 103)
                            wait(0.6)
                            topos(CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188))
                        end
                    else
                        v975.CFrame = CFrame.new(28286, 14897, 103)
                        wait(0.6)
                        topos(CFrame.new(28492.4140625, 14894.4267578125, - 422.1100158691406))
                    end
                else
                    v975.CFrame = CFrame.new(28286, 14897, 103)
                    wait(0.6)
                    topos(CFrame.new(29237.294921875, 14889.4267578125, - 206.94955444335938))
                end
            else
                v975.CFrame = CFrame.new(28286, 14897, 103)
                wait(0.6)
                topos(CFrame.new(28224.056640625, 14889.4267578125, - 210.5872039794922))
            end
        end
    })
    v281.V4:AddButton({
        ["Title"] = "Teleport To Clock",
        ["Callback"] = function()
            TP2(CFrame.new(29551.9941, 15069.002, - 85.5179291))
        end
    })
    Toggle = v281.V4:AddToggle("Auto Choose Gears", {
        ["Title"] = "Auto Choose Gears",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p976)
        _G.ChooseGears = p976
    end)
    function DetectGearUp()
        local v977 = next
        local v978, v979 = workspace.Map["Temple of Time"].InnerClock:GetChildren()
        while true do
            local v980
            v979, v980 = v977(v978, v979)
            if v979 == nil then
                break
            end
            if v980:IsA("MeshPart") and (v980:FindFirstChild("Highlight") and v980.Highlight.FillTransparency == 1) then
                return v980.Name
            end
        end
    end
    spawn(function()
        while task.wait() do
            pcall(function()
                if _G.ChooseGears then
                    local v981 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check")
                    if v981 and v981.HadPoint then
                        if DetectGearUp() then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TempleClock", "SpendPoint", DetectGearUp(), "Omega")
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TempleClock", "SpendPoint", DetectGearUp(), "Alpha")
                        else
                            getsenv(game:GetService("Players").LocalPlayer.PlayerGui.TempleGui.LocalScript):EaseIn()
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.TempleGui.Enabled then
                        getsenv(game:GetService("Players").LocalPlayer.PlayerGui.TempleGui.LocalScript):EaseOut()
                    end
                end
            end)
        end
    end)
    Toggle = v281.V4:AddToggle("Auto Trial", {
        ["Title"] = "Auto Trial",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p982)
        _G.QuestRace = p982
        StopTween(_G.QuestRace)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.QuestRace then
                    if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Human" then
                        if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Skypiea" then
                            if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Fishman" then
                                if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Cyborg" then
                                    if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Ghoul" then
                                        if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                                            local v983, v984, v985 = pairs(game:GetService("Workspace"):GetDescendants())
                                            while true do
                                                local v986
                                                v985, v986 = v983(v984, v985)
                                                if v985 == nil then
                                                    break
                                                end
                                                if v986.Name == "StartPoint" then
                                                    topos(v986.CFrame * CFrame.new(0, 10, 0))
                                                end
                                            end
                                        end
                                    else
                                        local v987, v988, v989 = pairs(game.Workspace.Enemies:GetDescendants())
                                        while true do
                                            local vu990
                                            v989, vu990 = v987(v988, v989)
                                            if v989 == nil then
                                                break
                                            end
                                            if vu990:FindFirstChild("Humanoid") and (vu990:FindFirstChild("HumanoidRootPart") and vu990.Humanoid.Health > 0) then
                                                pcall(function()
													-- upvalues: (ref) vu990
                                                    repeat
                                                        wait(0.1)
                                                        vu990.Humanoid.Health = 0
                                                        vu990.HumanoidRootPart.CanCollide = false
                                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                    until not _G.QuestRace or (not vu990.Parent or vu990.Humanoid.Health <= 0)
                                                end)
                                            end
                                        end
                                    end
                                else
                                    topos(CFrame.new(28654, 14898.7832, - 30, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                                end
                            else
                                local v991, v992, v993 = pairs(game:GetService("Workspace").SeaBeasts.SeaBeast1:GetDescendants())
                                while true do
                                    local v994
                                    v993, v994 = v991(v992, v993)
                                    if v993 == nil then
                                        break
                                    end
                                    if v994.Name == "HumanoidRootPart" then
                                        topos(v994.CFrame * CFrame.new(PosX, PosY, PosZ))
                                        local v995, v996, v997 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                                        while true do
                                            local v998
                                            v997, v998 = v995(v996, v997)
                                            if v997 == nil then
                                                break
                                            end
                                            if v998:IsA("Tool") and v998.ToolTip == "Melee" then
                                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v998)
                                            end
                                        end
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        local v999, v1000, v1001 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                                        while true do
                                            local v1002
                                            v1001, v1002 = v999(v1000, v1001)
                                            if v1001 == nil then
                                                break
                                            end
                                            if v1002:IsA("Tool") and v1002.ToolTip == "Blox Fruit" then
                                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1002)
                                            end
                                        end
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.5)
                                        local v1003, v1004, v1005 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                                        while true do
                                            local v1006
                                            v1005, v1006 = v1003(v1004, v1005)
                                            if v1005 == nil then
                                                break
                                            end
                                            if v1006:IsA("Tool") and v1006.ToolTip == "Sword" then
                                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1006)
                                            end
                                        end
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.5)
                                        local v1007, v1008, v1009 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                                        while true do
                                            local v1010
                                            v1009, v1010 = v1007(v1008, v1009)
                                            if v1009 == nil then
                                                break
                                            end
                                            if v1010:IsA("Tool") and v1010.ToolTip == "Gun" then
                                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1010)
                                            end
                                        end
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    end
                                end
                            end
                        else
                            local v1011 = next
                            local v1012, v1013 = workspace:GetDescendants()
                            while true do
                                local v1014
                                v1013, v1014 = v1011(v1012, v1013)
                                if v1013 == nil then
                                    break
                                end
                                if v1014.Name == "FinishPart" then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v1014.CFrame
                                end
                            end
                        end
                    else
                        local v1015, v1016, v1017 = pairs(game.Workspace.Enemies:GetDescendants())
                        while true do
                            local vu1018
                            v1017, vu1018 = v1015(v1016, v1017)
                            if v1017 == nil then
                                break
                            end
                            if vu1018:FindFirstChild("Humanoid") and (vu1018:FindFirstChild("HumanoidRootPart") and vu1018.Humanoid.Health > 0) then
                                pcall(function()
									-- upvalues: (ref) vu1018
                                    repeat
                                        wait(0.1)
                                        vu1018.Humanoid.Health = 0
                                        vu1018.HumanoidRootPart.CanCollide = false
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.QuestRace or (not vu1018.Parent or vu1018.Humanoid.Health <= 0)
                                end)
                            end
                        end
                    end
                end
            end
        end)
    end)
    Toggle = v281.V4:AddToggle("Auto Farm & active V4", {
        ["Title"] = "Auto Farm & active V4",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1019)
        _G.Bone = p1019
        _G.Train = p1019
        _G.BuyGear = p1019
        _G.ActiveV4 = p1019
        StopTween(_G.Bone)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.Train and game.Players.LocalPlayer.Character.RaceTransformed.Value == true then
                    _G.Bone = false
                    topos(CFrame.new(- 9507.03125, 713.654968, 6186.39453))
                end
            end
        end)
    end)
    v281.V4:AddButton({
        ["Title"] = "Buy Ancient One Quest",
        ["Callback"] = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
        end
    })
    v281.V4:AddSection("Kill Player Trial")
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Kill Player After Trial",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1020)
        _G.KillAfterTrials = p1020
        _G.AimNearest = p1020
        _G.NoSt = p1020
        _G.Ken = p1020
        StopTween(_G.KillAfterTrials)
    end)
    spawn(function()
        while wait() do
            pcall(function()
				-- block 35
                if not _G.KillAfterTrials then
					-- ::l3::
                    return
                end
                local v1021, v1022, v1023 = pairs(game.Workspace.Characters:GetChildren())
				-- ::l4::
                local v1024
                v1023, v1024 = v1021(v1022, v1023)
                if v1023 == nil then
					-- goto l3
                end
                if v1024.Name == game.Players.LocalPlayer.Name or (not v1024:FindFirstChild("Humanoid") or (not v1024:FindFirstChild("HumanoidRootPart") or (v1024.Humanoid.Health <= 0 or (not v1024.Parent or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1024.HumanoidRootPart.Position).Magnitude > 230)))) then
					-- goto l4
                end
				-- ::l17::
                task.wait()
                EquipWeapon(_G.SelectWeapon)
                TP2(v1024.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2))
                local v1025, v1026, v1027 = ipairs({
                    "Z",
                    "X",
                    "C",
                    "V",
                    "F"
                })
                while true do
                    local v1028
                    v1027, v1028 = v1025(v1026, v1027)
                    if v1027 == nil then
                        break
                    end
                    if _G["SkillTrial" .. v1028] then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, v1028, false, game)
                        wait(0.1)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, v1028, false, game)
                    end
                end
                v1024.HumanoidRootPart.CanCollide = false
                v1024.Head.CanCollide = false
                v1024.Humanoid.WalkSpeed = 0
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                if _G.KillAfterTrials and (v1024.Humanoid.Health > 0 and (v1024.Parent and (v1024:FindFirstChild("HumanoidRootPart") and v1024:FindFirstChild("Humanoid")))) then
					-- goto l17
                else
					-- goto l3
                end
				-- ::l3::
				-- ::l2::
				-- goto l4
            end)
        end
    end)
    v281.V4:AddSection("Setting Kill Player Trial")
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Use Skill Z Kill Player",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1029)
        _G.SkillTrialZ = p1029
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Use Skill X Kill Player",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1030)
        _G.SkillTrialX = p1030
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Use Skill C Kill Player",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1031)
        _G.SkillTrialC = p1031
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Use Skill V Kill Player",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1032)
        _G.SkillTrialV = p1032
    end)
    Toggle = v281.V4:AddToggle("Toggle", {
        ["Title"] = "Use Skill F Kill Player",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1033)
        _G.SkillTrialF = p1033
    end)
end
if World1 or World2 then
    v281.E:AddSection("Go To The Third Sea")
end
if World3 then
    v281.E:AddButton({
        ["Title"] = "Remove Fog",
        ["Callback"] = function()
            game:GetService("Lighting").LightingLayers:Destroy()
            game:GetService("Lighting").Sky:Destroy()
        end
    })
    Dropdown = v281.E:AddDropdown("Dropdown", {
        ["Title"] = "Select Boat",
        ["Values"] = {
            "Guardian",
            "PirateGrandBrigade",
            "MarineGrandBrigade",
            "PirateBrigade",
            "MarineBrigade",
            "PirateSloop",
            "MarineSloop",
            "BeastHunter"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("PirateGrandBrigade")
    Dropdown:OnChanged(function(p1034)
        _G.SelectedBoat = p1034
    end)
    Dropdown = v281.E:AddDropdown("Dropdown", {
        ["Title"] = "Select Zone",
        ["Values"] = {
            "Zone 1",
            "Zone 2",
            "Zone 3",
            "Zone 4",
            "Zone 5",
            "Zone 6",
            "Tiki Outpost",
            "Hydra Island"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("Zone 5")
    Dropdown:OnChanged(function(p1035)
        _G.SelectedZone = p1035
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.SelectedZone ~= "Zone 1" then
                    if _G.SelectedZone ~= "Zone 2" then
                        if _G.SelectedZone ~= "Zone 3" then
                            if _G.SelectedZone ~= "Zone 4" then
                                if _G.SelectedZone ~= "Zone 5" then
                                    if _G.SelectedZone ~= "Zone 6" then
                                        if _G.SelectedZone ~= "Tiki Outpost" then
                                            if _G.SelectedZone == "Hydra Island" then
                                                CFrameSelectedZone = CFrame.new(5185, 0, 1670)
                                            end
                                        else
                                            CFrameSelectedZone = CFrame.new(- 16195, 0, 441)
                                        end
                                    else
                                        CFrameSelectedZone = CFrame.new(- 44541.7617, 30.0003204, - 1244.8584, - 0.0844199061, - 0.00553312758, 0.9964149, - 0.0654025897, 0.997858942, 2.02319411e-10, - 0.99428153, - 0.0651681125, - 0.0846010372)
                                    end
                                else
                                    CFrameSelectedZone = CFrame.new(- 38887.5547, 30.0004578, - 2162.99023, - 0.188895494, - 0.00704088295, 0.981971979, - 0.0372481011, 0.999306023, - 1.39882339e-9, - 0.981290519, - 0.0365765914, - 0.189026669)
                                end
                            else
                                CFrameSelectedZone = CFrame.new(- 34054.6875, 30.2187767, - 2560.12012, 0.0935864747, - 0.00122954219, 0.995610416, 0.0624034069, 0.998040259, - 0.00463332096, - 0.993653536, 0.062563099, 0.0934797972)
                            end
                        else
                            CFrameSelectedZone = CFrame.new(- 31171.957, 30.0001011, - 2256.93774, 0.37637493, 0.0150483791, 0.926345229, - 0.0399504974, 0.999201655, 2.70896673e-11, - 0.925605655, - 0.0370079502, 0.376675636)
                        end
                    else
                        CFrameSelectedZone = CFrame.new(- 26779.5215, 30.0005474, - 822.858032, 0.307457417, 0.019647358, 0.951358974, - 0.0637726262, 0.997964442, - 4.15334017e-10, - 0.949422479, - 0.0606706589, 0.308084518)
                    end
                else
                    CFrameSelectedZone = CFrame.new(- 21998.375, 30.0006084, - 682.309143, 0.120013528, 0.00690158736, 0.99274826, - 0.0574118942, 0.998350561, - 2.36509201e-10, - 0.991110802, - 0.0569955558, 0.120211802)
                end
            end
        end)
    end)
    Dropdown = v281.E:AddDropdown("Dropdown", {
        ["Title"] = "Speed Tween Boat",
        ["Values"] = {
            "180",
            "200",
            "250",
            "300",
            "325",
            "350"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("300")
    Dropdown:OnChanged(function(p1036)
        getgenv().SpeedBoat = p1036
    end)
    v281.E:AddSlider("Slider", {
        ["Title"] = "PosY Boat",
        ["Default"] = 40,
        ["Min"] = 40,
        ["Max"] = 250,
        ["Rounding"] = 5,
        ["Callback"] = function(p1037)
            getgenv().PosYBoat = p1037
        end
    })
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Start Sea Event",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1038)
        _G.SailBoat = p1038
    end)
    function CheckBoat()
        local v1039, v1040, v1041 = pairs(game:GetService("Workspace").Boats:GetChildren())
        while true do
            local v1042
            v1041, v1042 = v1039(v1040, v1041)
            if v1041 == nil then
                break
            end
            if v1042.Name == _G.SelectedBoat then
                local v1043, v1044, v1045 = pairs(v1042:GetChildren())
                while true do
                    local v1046
                    v1045, v1046 = v1043(v1044, v1045)
                    if v1045 == nil then
                        break
                    end
                    if v1046.Name == "MyBoatEsp" then
                        return v1042
                    end
                end
            end
        end
        return false
    end
    function CheckEnemiesBoat()
        return (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") or (game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") or game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade"))) and true or false
    end
    function CheckShark()
        local v1047, v1048, v1049 = pairs(game:GetService("Workspace").Enemies:GetChildren())
        while true do
            local v1050
            v1049, v1050 = v1047(v1048, v1049)
            if v1049 == nil then
                break
            end
            if v1050.Name == "Shark" and (v1050:FindFirstChild("Humanoid") and (v1050:FindFirstChild("HumanoidRootPart") and v1050.Humanoid.Health > 0)) and (game:GetService("Workspace").Enemies:FindFirstChild("Shark") and (v1050.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200) then
                return true
            end
        end
        return false
    end
    function CheckPiranha()
        local v1051, v1052, v1053 = pairs(game:GetService("Workspace").Enemies:GetChildren())
        while true do
            local v1054
            v1053, v1054 = v1051(v1052, v1053)
            if v1053 == nil then
                break
            end
            if v1054.Name == "Piranha" and (v1054:FindFirstChild("Humanoid") and (v1054:FindFirstChild("HumanoidRootPart") and v1054.Humanoid.Health > 0)) and (game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and (v1054.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200) then
                return true
            end
        end
        return false
    end
    function AddEsp(p1055, p1056)
        local v1057 = Instance.new("BillboardGui")
        local v1058 = Instance.new("TextLabel")
        v1057.Parent = p1056
        v1057.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        v1057.Active = true
        v1057.Name = p1055
        v1057.AlwaysOnTop = true
        v1057.LightInfluence = 1
        v1057.Size = UDim2.new(0, 200, 0, 50)
        v1057.StudsOffset = Vector3.new(0, 2.5, 0)
        v1058.Parent = v1057
        v1058.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        v1058.BackgroundTransparency = 1
        v1058.Size = UDim2.new(1, 0, 1, 0)
        v1058.Font = Enum.Font.GothamBold
        v1058.TextColor3 = Color3.fromRGB(255, 255, 255)
        v1058.TextSize = 15
        v1058.Text = "Your Ship"
    end
    spawn(function()
        while wait() do
            pcall(function()
                if _G.SailBoat then
                    if CheckBoat() then
                        local v1059, v1060, v1061 = pairs(game:GetService("Workspace").Boats:GetChildren())
                        while true do
                            local v1062
                            v1061, v1062 = v1059(v1060, v1061)
                            if v1061 == nil then
                                break
                            end
                            if v1062.Name == _G.SelectedBoat and v1062:FindFirstChild("MyBoatEsp") then
                                if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit then
                                    repeat
                                        wait()
                                        stopboat = TPB(CFrameSelectedZone, v1062.VehicleSeat)
                                    until CheckShark() and FarmShark or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.Terrorshark or CheckPiranha() and _G.farmpiranya or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.Fish_Crew_Member or (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") and _G.bjirFishBoat or (game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") and _G.RelzPirateBrigade or (game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade") and _G.KillGhostShip or CheckSeaBeast() and _G.SeaBest or not (game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit and _G.SailBoat))))))
                                    if stopboat then
                                        stopboat:Stop()
                                    end
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                                    wait(0.1)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                                elseif CheckShark() and FarmShark or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.Terrorshark or CheckPiranha() and _G.farmpiranya or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.Fish_Crew_Member or (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") and _G.bjirFishBoat or (game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") and _G.RelzPirateBrigade or (game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade") and _G.KillGhostShip or CheckSeaBeast() and _G.SeaBest))))) then
                                    if stoppos then
                                        stoppos:Stop()
                                    end
                                else
                                    stoppos = topos(v1062.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                                end
                            end
                        end
                    else
                        local v1063 = CFrame.new(- 16927.451171875, 9.0863618850708, 433.8642883300781)
                        if (v1063.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                            stoppos = topos(v1063)
                        else
                            TP1(CFrame.new(- 16224, 9, 439))
                        end
                        if (CFrame.new(- 16927.451171875, 9.0863618850708, 433.8642883300781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            if stoppos then
                                stoppos:Stop()
                            end
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
                            local v1064, v1065, v1066 = pairs(game:GetService("Workspace").Boats:GetChildren())
                            while true do
                                local v1067
                                v1066, v1067 = v1064(v1065, v1066)
                                if v1066 == nil then
                                    break
                                end
                                if v1067.Name == _G.SelectedBoat and (v1067.VehicleSeat.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                                    AddEsp("MyBoatEsp", v1067)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if _G.SailBoat and (CheckShark() and FarmShark or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.Terrorshark or CheckPiranha() and _G.farmpiranya or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.Fish_Crew_Member or (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") and _G.bjirFishBoat or (game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") and _G.RelzPirateBrigade or (game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade") and _G.KillGhostShip or CheckSeaBeast() and _G.SeaBest)))))) and game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                end
            end
        end)
    end)
    spawn(function()
        while wait() do
            pcall(function()
				-- block 207
                if not _G.SailBoat then
					-- ::l3::
                    return
                end
                if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.Fish_Crew_Member then
                    local v1068, v1069, v1070 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v1071
                        v1070, v1071 = v1068(v1069, v1070)
                        if v1070 == nil then
                            break
                        end
                        if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and (v1071.Name == "Fish Crew Member" and (v1071:FindFirstChild("Humanoid") and (v1071:FindFirstChild("HumanoidRootPart") and v1071.Humanoid.Health > 0))) then
                            repeat
                                task.wait()
                                EquipWeapon(_G.SelectWeapon)
                                TP2(v1071.HumanoidRootPart.CFrame * Pos)
                                _G.SeaSkill = false
                            until not _G.Fish_Crew_Member or (not v1071.Parent or v1071.Humanoid.Health <= 0)
                            StartMagnet = false
                        end
                    end
					-- goto l3
                end
                if not (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") and _G.bjirFishBoat) then
					-- goto l31
                end
                local v1072, v1073, v1074 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				-- goto l34
				-- ::l31::
                if not (game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade") and _G.KillGhostShip) then
					-- goto l56
                end
                local v1075, v1076, v1077 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				-- ::l59::
				-- ::l91::
				-- ::l60::
				-- ::l87::
                if true then
                    task.wait()
                    local v1078 = v1080.Engine.CFrame
                    if (v1078.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
                        _G.SeaSkill = false
                    else
                        _G.SeaSkill = true
                    end
                end
                TP2(v1078)
                Skillaimbot = true
                AimSkill = v1080.Engine.CFrame * CFrame.new(0, - 15, 0)
                AimBotSkillPosition = AimSkill.Position
                if v1080.Parent and v1080.Health.Value >= 0 and (game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") and (v1080:FindFirstChild("Engine") and _G.RelzPirateBrigade)) then
					-- goto l87
                end
                Skillaimbot = false
                _G.SeaSkill = false
				-- ::l84::
                local v1079, v1080 = v1081(v1082, v1079)
                if v1079 == nil then
					-- goto l3
                end
                if game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") then
					-- goto l59
                else
					-- goto l65
                end
				-- ::l65::
				-- ::l94::
				-- ::l39::
				-- ::l30::
				-- ::l35::
				-- ::l115::
				-- ::l33::
				-- ::l3::
				-- goto l84
				-- ::l56::
                if not (game:GetService("Workspace").Enemies:FindFirstChild("PirateBrigade") and _G.RelzPirateBrigade) then
					-- goto l81
                end
                local v1081, v1082
                v1081, v1082, v1079 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				-- goto l84
				-- ::l81::
                if not (CheckSeaBeast() and _G.SeaBest) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.Terrorshark then
                        local v1083, v1084, v1085 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v1086
                            v1085, v1086 = v1083(v1084, v1085)
                            if v1085 == nil then
                                break
                            end
                            if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and (v1086.Name == "Terrorshark" and (v1086:FindFirstChild("Humanoid") and (v1086:FindFirstChild("HumanoidRootPart") and v1086.Humanoid.Health > 0))) then
                                repeat
                                    task.wait(0.15)
                                    EquipWeapon(_G.SelectWeapon)
                                    _G.SeaSkill = false
                                    TP2(v1086.HumanoidRootPart.CFrame * CFrame.new(0, 60, 0))
                                until not _G.Terrorshark or (not v1086.Parent or v1086.Humanoid.Health <= 0)
                            end
                        end
                    elseif CheckPiranha() and _G.farmpiranya then
                        local v1087, v1088, v1089 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v1090
                            v1089, v1090 = v1087(v1088, v1089)
                            if v1089 == nil then
                                break
                            end
                            if game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and (v1090.Name == "Piranha" and (v1090:FindFirstChild("Humanoid") and (v1090:FindFirstChild("HumanoidRootPart") and v1090.Humanoid.Health > 0))) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    TP2(v1090.HumanoidRootPart.CFrame * Pos)
                                    _G.SeaSkill = false
                                until not _G.farmpiranya or (not v1090.Parent or v1090.Humanoid.Health <= 0)
                            end
                        end
                    elseif CheckShark() and FarmShark then
                        local v1091, v1092, v1093 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v1094
                            v1093, v1094 = v1091(v1092, v1093)
                            if v1093 == nil then
                                break
                            end
                            if game:GetService("Workspace").Enemies:FindFirstChild("Shark") and (v1094.Name == "Shark" and (v1094:FindFirstChild("Humanoid") and (v1094:FindFirstChild("HumanoidRootPart") and v1094.Humanoid.Health > 0))) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    TP2(v1094.HumanoidRootPart.CFrame * Pos)
                                    _G.SeaSkill = false
                                until not FarmShark or (not v1094.Parent or v1094.Humanoid.Health <= 0)
                            end
                        end
                    else
                        Skillaimbot = false
                        _G.SeaSkill = false
                    end
					-- goto l3
                end
                if not game:GetService("Workspace"):FindFirstChild("SeaBeasts") then
					-- goto l3
                end
                local v1095, v1096, v1097 = pairs(game:GetService("Workspace").SeaBeasts:GetChildren())
				-- goto l111
				-- ::l34::
                local v1098
                v1074, v1098 = v1072(v1073, v1074)
                if v1074 == nil then
					-- goto l3
                end
                if game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") then
					-- goto l105
                else
					-- goto l34
                end
				-- ::l105::
				-- ::l64::
				-- ::l40::
				-- ::l37::
                if true then
                    task.wait()
                    local v1099 = v1098.Engine.CFrame
                    if (v1099.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
                        _G.SeaSkill = false
                    else
                        _G.SeaSkill = true
                    end
                end
                TP2(v1099)
                Skillaimbot = true
                AimSkill = v1098.Engine.CFrame * CFrame.new(0, - 15, 0)
                AimBotSkillPosition = AimSkill.Position
                if v1098.Parent and v1098.Health >= 0 and (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") and (v1098:FindFirstChild("Engine") and _G.bjirFishBoat)) then
					-- goto l110
                else
					-- goto l6
                end
				-- ::l110::
				-- goto l37
				-- ::l6::
				-- ::l41::
				-- ::l44::
                Skillaimbot = false
                _G.SeaSkill = false
				-- goto l34
				-- ::l2::
				-- goto l59
				-- ::l8::
				-- goto l112
				-- ::l58::
				-- goto l106
				-- ::l62::
                if true then
                    task.wait()
                    local v1100 = v1101.Engine.CFrame
                    if (v1100.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
                        _G.SeaSkill = false
                    else
                        _G.SeaSkill = true
                    end
                end
                TP2(v1100)
                Skillaimbot = true
                AimSkill = v1101.Engine.CFrame * CFrame.new(0, - 15, 0)
                AimBotSkillPosition = AimSkill.Position
                if v1101.Parent and v1101.Health.Value >= 0 and (game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade") and (v1101:FindFirstChild("Engine") and _G.KillGhostShip)) then
					-- goto l62
                end
                Skillaimbot = false
                _G.SeaSkill = false
				-- ::l59::
                local v1101
                v1077, v1101 = v1075(v1076, v1077)
                if v1077 == nil then
					-- goto l3
                end
                if game:GetService("Workspace").Enemies:FindFirstChild("PirateGrandBrigade") then
					-- goto l8
                else
					-- goto l58
                end
				-- ::l66::
				-- goto l108
				-- ::l69::
				-- goto l2
				-- ::l83::
				-- goto l114
				-- ::l106::
				-- goto l69
				-- ::l108::
				-- goto l62
				-- ::l112::
				-- goto l66
				-- ::l122::
                Skillaimbot = false
                _G.SeaSkill = false
				-- ::l111::
                while true do
                    local v1102
                    v1097, v1102 = v1095(v1096, v1097)
                    if v1097 == nil then
						-- goto l3
                    end
                    if CheckSeaBeast() then
                        break
                    end
                    Skillaimbot = false
                    _G.SeaSkill = false
                end
				-- ::l114::
                if true then
                    wait()
                    CFrameSeaBeast = v1102.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0)
                    if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude > 200 then
                        _G.SeaSkill = false
                    else
                        _G.SeaSkill = true
                    end
                end
                Skillaimbot = true
                AimBotSkillPosition = v1102.HumanoidRootPart.CFrame.Position
                TP2(CFrameSeaBeast * Pos)
                if _G.SeaBest and (CheckSeaBeast() ~= false and (v1102:FindFirstChild("Humanoid") and (v1102:FindFirstChild("HumanoidRootPart") and (v1102.Humanoid.Health >= 0 and v1102.Parent)))) then
					-- goto l83
                else
					-- goto l122
                end
            end)
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill Shark",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1103)
        FarmShark = p1103
        StopTween(FarmShark)
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill Piranha",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1104)
        _G.farmpiranya = p1104
        StopTween(_G.farmpiranya)
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Fish Crew",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1105)
        _G.Fish_Crew_Member = p1105
        StopTween(_G.Fish_Crew_Member)
    end)
    function UpDownPos(p1106)
        fastpos(p1106 * CFrame.new(0, 40, 0))
        wait(2)
        fastpos(p1106 * CFrame.new(0, 300, 0))
        wait(3)
    end
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill Ghost Ship",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1107)
        _G.bjirFishBoat = p1107
        StopTween(_G.bjirFishBoat)
        if not _G.bjirFishBoat then
            _G.SeaSkill = false
            Skillaimbot = false
            StopTween(_G.bjirFishBoat)
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill Pirate Grand Brigade",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1108)
        _G.KillGhostShip = p1108
        StopTween(_G.KillGhostShip)
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill Terror Shark",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1109)
        _G.Terrorshark = p1109
        StopTween(_G.Terrorshark)
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill Sea Beast",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1110)
        _G.SeaBest = p1110
        StopTween(_G.SeaBest)
        if not _G.SeaBest then
            _G.SeaSkill = false
            Skillaimbot = false
        end
    end)
    function CheckSeaBeast()
        if game:GetService("Workspace"):FindFirstChild("SeaBeasts") then
            local v1111, v1112, v1113 = pairs(game:GetService("Workspace").SeaBeasts:GetChildren())
            while true do
                local v1114
                v1113, v1114 = v1111(v1112, v1113)
                if v1113 == nil then
                    break
                end
                if v1114:FindFirstChild("Humanoid") or (v1114:FindFirstChild("HumanoidRootPart") or v1114.Humanoid.Health < 0) then
                    return true
                end
            end
        end
        return false
    end
    v281.E:AddSection("Setting Sea Event")
    Dropdown = v281.E:AddDropdown("Dropdown", {
        ["Title"] = "Select Brightness",
        ["Values"] = {
            "100",
            "150",
            "200",
            "250",
            "300",
            "325",
            "350"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("100")
    Dropdown:OnChanged(function(p1115)
        BrightValue = p1115
    end)
    v281.E:AddButton({
        ["Title"] = "Set Brightness",
        ["Callback"] = function()
            game:GetService("Lighting").Brightness = BrightValue
        end
    })
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Enable Speed Boat",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1116)
        _G.IncreaseBoatSpeed = p1116
    end)
    spawn(function()
        while wait() do
            pcall(function()
                local v1117, v1118, v1119 = pairs(game.Workspace.Boats:GetDescendants())
                local v1120 = {}
                while true do
                    local v1121
                    v1119, v1121 = v1117(v1118, v1119)
                    if v1119 == nil then
                        break
                    end
                    if v1121:IsA("VehicleSeat") then
                        table.insert(v1120, v1121)
                    end
                end
                if _G.IncreaseBoatSpeed then
                    local v1122, v1123, v1124 = pairs(v1120)
                    while true do
                        local v1125
                        v1124, v1125 = v1122(v1123, v1124)
                        if v1124 == nil then
                            break
                        end
                        v1125.MaxSpeed = 350
                    end
                else
                    local v1126, v1127, v1128 = pairs(v1120)
                    while true do
                        local v1129
                        v1128, v1129 = v1126(v1127, v1128)
                        if v1128 == nil then
                            break
                        end
                        v1129.MaxSpeed = 150
                    end
                end
            end)
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Enable Fly Boat",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1130)
		-- upvalues: (ref) vu180, (ref) vu163
        if p1130 then
            _G.NoClipRock = true
            vu180(speaker, true)
        else
            _G.NoClipRock = false
            vu163(speaker)
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "NoClip Rock",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1131)
        _G.NoClipRock = p1131
    end)
    spawn(function()
        while wait() do
            pcall(function()
                local v1132, v1133, v1134 = pairs(game:GetService("Workspace").Boats:GetChildren())
                while true do
                    local v1135
                    v1134, v1135 = v1132(v1133, v1134)
                    if v1134 == nil then
                        break
                    end
                    local v1136, v1137, v1138 = pairs(game:GetService("Workspace").Boats[v1135.Name]:GetDescendants())
                    while true do
                        local v1139
                        v1138, v1139 = v1136(v1137, v1138)
                        if v1138 == nil then
                            break
                        end
                        if v1139:IsA("BasePart") then
                            if _G.NoClipRock or _G.SailBoat then
                                v1139.CanCollide = false
                            else
                                v1139.CanCollide = true
                            end
                        end
                    end
                end
            end)
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Press W Auto",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1140)
        _G.r71PressW = p1140
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.r71PressW and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
                end
            end)
        end
    end)
    DoneSkillGun = false
    DoneSkillSword = false
    DoneSkillFruit = false
    DoneSkillMelee = false
    spawn(function()
        while wait() do
            pcall(function()
                if _G.SeaSkill then
                    if _G.UseSeaFruitSkill and DoneSkillFruit == false then
                        local v1141, v1142, v1143 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                        while true do
                            local v1144
                            v1143, v1144 = v1141(v1142, v1143)
                            if v1143 == nil then
                                break
                            end
                            if v1144:IsA("Tool") and v1144.ToolTip == "Blox Fruit" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1144)
                            end
                        end
                        if _G.SkillFruitZ then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                            wait(_G.SeaHoldSKillZ)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                        end
                        if _G.SkillFruitX then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                            wait(_G.SeaHoldSKillX)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                        end
                        if _G.SkillFruitC then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                            wait(_G.SeaHoldSKillC)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                        end
                        if _G.SkillFruitV then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                            wait(_G.SeaHoldSKillV)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                        end
                        if _G.SkillFruitF then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                            wait(_G.SeaHoldSKillF)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                        end
                        DoneSkillFruit = true
                    end
                    if _G.UseSeaMeleeSkill and DoneSkillMelee == false then
                        local v1145, v1146, v1147 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                        while true do
                            local v1148
                            v1147, v1148 = v1145(v1146, v1147)
                            if v1147 == nil then
                                break
                            end
                            if v1148:IsA("Tool") and v1148.ToolTip == "Melee" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1148)
                            end
                        end
                        if _G.SkillMeleeZ then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                            wait(0)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                        end
                        if _G.SkillMeleeX then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                            wait(0)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                        end
                        if _G.SkillMeleeC then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                            wait(0)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                        end
                        if _G.SkillMeleeV then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                            wait(0)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                        end
                        DoneSkillMelee = true
                    end
                    if _G.UseSeaSwordSkill and DoneSkillSword == false then
                        local v1149, v1150, v1151 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                        while true do
                            local v1152
                            v1151, v1152 = v1149(v1150, v1151)
                            if v1151 == nil then
                                break
                            end
                            if v1152:IsA("Tool") and v1152.ToolTip == "Sword" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1152)
                            end
                        end
                        if _G.SkillSwordZ then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                            wait(0)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                        end
                        if _G.SkillSwordX then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                            wait(0)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                        end
                        DoneSkillSword = true
                    end
                    if _G.UseSeaGunSkill and DoneSkillGun == false then
                        local v1153, v1154, v1155 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                        while true do
                            local v1156
                            v1155, v1156 = v1153(v1154, v1155)
                            if v1155 == nil then
                                break
                            end
                            if v1156:IsA("Tool") and v1156.ToolTip == "Gun" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1156)
                            end
                        end
                        if _G.SkillGunZ then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                            wait(0.1)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                        end
                        if _G.SkillGunX then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                            wait(0.1)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                        end
                        DoneSkillGun = true
                    end
                    DoneSkillGun = false
                    DoneSkillSword = false
                    DoneSkillFruit = false
                    DoneSkillMelee = false
                end
            end)
        end
    end)
    v281.E:AddSection("Kitsune Event")
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Teleporter Kitsune",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1157)
        _G.FKitsune = p1157
        StopTween(_G.FKitsune)
    end)
    spawn(function()
        while wait() do
            local v1158 = _G.FKitsune and game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland")
            if v1158 then
                topos(v1158.ShrineActive.NeonShrinePart.CFrame * CFrame.new(0, 0, 10))
            end
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Collect Azure Ember",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1159)
        _G.CltAze = p1159
    end)
    spawn(function()
        while wait() do
            if _G.CltAze then
                pcall(function()
                    if game:GetService("Workspace"):FindFirstChild("AttachedAzureEmber") then
                        fastpos(game:GetService("Workspace"):WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
                    end
                end)
            end
        end
    end)
    v281.E:AddSlider("Slider", {
        ["Title"] = "Set Azure Ember",
        ["Default"] = 20,
        ["Min"] = 5,
        ["Max"] = 25,
        ["Rounding"] = 5,
        ["Callback"] = function(p1160)
            _G.SetToTradeAureEmber = p1160
        end
    })
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Trade Azure Ember",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1161)
        _G.TradeAureEmber = p1161
    end)
    function GetCountMaterials(p1162)
        local v1163 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
        local v1164, v1165, v1166 = pairs(v1163)
        while true do
            local v1167
            v1166, v1167 = v1164(v1165, v1166)
            if v1166 == nil then
                break
            end
            if v1167.Name == p1162 then
                return v1167.Count
            end
        end
    end
    spawn(function()
        while wait() do
            if _G.TradeAureEmber then
                pcall(function()
                    if GetCountMaterials("Azure Ember") >= _G.SetToTradeAureEmber then
                        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KitsuneStatuePray")
                    end
                end)
            end
        end
    end)
    v281.E:AddSection("Leviathan")
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Teleport To Spy",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1168)
        _G.TpSpy = p1168
        if _G.TpSpy then
            task.spawn(function()
                while _G.TpSpy do
                    task.wait()
                    topos(CFrame.new(- 16471, 528, 539))
                end
            end)
        end
    end)
    v281.E:AddButton({
        ["Title"] = "Buy Chip Leviathan",
        ["Callback"] = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
        end
    })
    v281.E:AddButton({
        ["Title"] = "Shoot Heart Leviathan",
        ["Callback"] = function()
            local v1169 = {
                "FireHarpoon",
                0.4219459368535087,
                0.30521099719905354,
                workspace.Boats:FindFirstChild("Beast Hunter").Harpoon,
                1728199048.263916
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1169))
        end
    })
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Find Leviathan (Need 5 People)",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1170)
        _G.FindLeviathan = p1170
        StopTween(_G.FindLeviathan)
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.FindLeviathan then
                    local v1171 = game.Players.LocalPlayer.Character
                    if v1171 and (v1171:FindFirstChild("Humanoid") and v1171.Humanoid.Sit) then
                        local v1172 = v1171.Humanoid.SeatPart
                        if v1172 and v1172:IsDescendantOf(game.Workspace.Boats) then
                            local v1173 = v1172.Parent
                            repeat
                                wait()
                                stopboat = topos(CFrame.new(- 9999999, getgenv().PosYBoat, 0), v1173.VehicleSeat)
                            until game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Frozen Island") or not (v1171:FindFirstChild("Humanoid").Sit and _G.FindLeviathan)
                            if stopboat then
                                stopboat:Stop()
                            end
                            if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Frozen Island") then
                                _G.FindLeviathan = false
                                Notify("Bap Red", "Frozen Island Spawn", 3)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                                wait(0.1)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                            end
                        end
                    end
                end
            end)
        end
    end)
    spawn(function()
        while wait() do
            if _G.FindLeviathan then
                pcall(function()
                    local v1174, v1175, v1176 = pairs(game:GetService("Workspace").Boats:GetChildren())
                    while true do
                        local v1177
                        v1176, v1177 = v1174(v1175, v1176)
                        if v1176 == nil then
                            break
                        end
                        local v1178, v1179, v1180 = pairs(game:GetService("Workspace").Boats[v1177.Name]:GetDescendants())
                        while true do
                            local v1181
                            v1180, v1181 = v1178(v1179, v1180)
                            if v1180 == nil then
                                break
                            end
                            if v1181:IsA("BasePart") then
                                if _G.NoClipRock or _G.FindLeviathan then
                                    v1181.CanCollide = false
                                else
                                    v1181.CanCollide = true
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Tween Frozen Dimension",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1182)
        _G.FrozenDimension = p1182
        StopTween(_G.FrozenDimension)
    end)
    spawn(function()
        while wait() do
            if _G.FrozenDimension then
                pcall(function()
                    if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                        topos(workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension").CFrame * CFrame.new(0, 250, 0))
                    end
                end)
            end
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Auto Kill / Attack Leviathan",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1183)
        _G.KillLeviathan = p1183
        StopTween(_G.KillLeviathan)
    end)
    spawn(function()
        while wait() do
            if _G.KillLeviathan then
                pcall(function()
                    local v1184, v1185, v1186 = pairs(game:GetService("Workspace").SeaBeasts:GetChildren())
                    while true do
                        local v1187
                        v1186, v1187 = v1184(v1185, v1186)
                        if v1186 == nil then
                            break
                        end
                        if v1187.Name == "Leviathan" and v1187:FindFirstChild("HumanoidRootPart") then
                            repeat
                                wait()
                                TP2(v1187.HumanoidRootPart.CFrame * CFrame.new(0, 500, 0))
                                pcall(function()
                                    _G.SeaSkill = true
                                end)
                                _G.SeaSkill = true
                                AimBotSkillPosition = v1187.HumanoidRootPart
                                Skillaimbot = true
                            until not (v1187:FindFirstChild("HumanoidRootPart") and _G.KillLeviathan)
                            _G.SeaSkill = false
                            Skillaimbot = false
                        end
                    end
                end)
            end
        end
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Attack Segment Leviathan",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1188)
        _G.SegmentLeviathan = p1188
        StopTween(_G.SegmentLeviathan)
    end)
    spawn(function()
        while wait() do
            if _G.SegmentLeviathan then
                pcall(function()
                    local v1189, v1190, v1191 = pairs(workspace.SeaBeasts:GetChildren())
                    while true do
						-- ::l1::
                        local v1192
                        v1191, v1192 = v1189(v1190, v1191)
                        if v1191 == nil then
                            return
                        end
                        if not v1192 or (v1192.Name ~= "Leviathan Segment" or (not v1192:FindFirstChild("Health") or v1192.Health.Value <= 0)) then
							-- goto l1
                        end
						-- ::l10::
                        wait()
                        if v1192:FindFirstChild("HumanoidRootPart") then
                            topos(v1192.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                            pcall(function()
                                _G.SeaSkill = true
                            end)
                            AimBotSkillPosition = v1192.HumanoidRootPart
                            Skillaimbot = true
                        end
                        if v1192:FindFirstChild("HumanoidRootPart") and (_G.SegmentLeviathan and v1192.Health.Value > 0) then
							-- goto l10
                        end
                        _G.SeaSkill = false
                        Skillaimbot = false
                    end
                end)
            end
        end
    end)
    v281.E:AddSection("Settings Skills Only Sea Event")
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Enable Melee Skill",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1193)
        _G.UseSeaMeleeSkill = p1193
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Enable Fruit Skill",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1194)
        _G.UseSeaFruitSkill = p1194
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Enable Sword Skill",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1195)
        _G.UseSeaSwordSkill = p1195
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Enable Gun Skill",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1196)
        _G.UseSeaGunSkill = p1196
    end)
    v281.E:AddSection("Settings Melee Skill")
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill Z Melee",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1197)
        _G.SkillMeleeZ = p1197
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill X Melee",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1198)
        _G.SkillMeleeX = p1198
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill C Melee",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1199)
        _G.SkillMeleeC = p1199
    end)
    v281.E:AddSection("Settings Fruit Skill")
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill Z Fruit",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1200)
        _G.SkillFruitZ = p1200
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill X Fruit",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1201)
        _G.SkillFruitX = p1201
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill C Fruit",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1202)
        _G.SkillFruitC = p1202
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill V Fruit",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1203)
        _G.SkillFruitV = p1203
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill F Fruit",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1204)
        _G.SkillFruitF = p1204
    end)
    v281.E:AddSection("Settings Sword and Gun")
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill Z | Sword And Gun",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1205)
        _G.SkillGunZ = p1205
        _G.SkillSwordZ = p1205
    end)
    Toggle = v281.E:AddToggle("Toggle", {
        ["Title"] = "Use Skill X | Sword And Gun",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1206)
        _G.SkillGunX = p1206
        _G.SkillSwordX = p1206
    end)
    function EquipAllWeapon()
        pcall(function()
            local v1207, v1208, v1209 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
            while true do
                local v1210
                v1209, v1210 = v1207(v1208, v1209)
                if v1209 == nil then
                    break
                end
                if v1210:IsA("Tool") and (v1210.Name ~= "Summon Sea Beast" and (v1210.Name ~= "Water Body" and v1210.Name ~= "Awakening")) then
                    local v1211 = game.Players.LocalPlayer.Backpack:FindFirstChild(v1210.Name)
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1211)
                    wait(1)
                end
            end
        end)
    end
    local v1212 = getrawmetatable(game)
    local vu1213 = v1212.__namecall
    setreadonly(v1212, false)
    v1212.__namecall = newcclosure(function(...)
		-- upvalues: (ref) vu1213
        local v1214 = getnamecallmethod()
        local v1215 = {
            ...
        }
        if tostring(v1214) ~= "FireServer" or (tostring(v1215[1]) ~= "RemoteEvent" or (tostring(v1215[2]) == "true" or (tostring(v1215[2]) == "false" or not Skillaimbot))) then
            return vu1213(...)
        end
        v1215[2] = AimBotSkillPosition
        return vu1213(unpack(v1215))
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if UseSkill then
                    local v1216, v1217, v1218 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v1219
                        v1218, v1219 = v1216(v1217, v1218)
                        if v1218 == nil then
                            break
                        end
                        if v1219.Name == MonFarm and (v1219:FindFirstChild("Humanoid") and (v1219:FindFirstChild("HumanoidRootPart") and v1219.Humanoid.Health <= v1219.Humanoid.MaxHealth * _G.Kill_At / 100)) then
                            if _G.SkillZ then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                                wait(_G.HoldSKillZ)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                            end
                            if _G.SkillX then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                                wait(_G.HoldSKillX)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                            end
                            if _G.SkillC then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                                wait(_G.HoldSKillC)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                            end
                            if _G.SkillV then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                                wait(_G.HoldSKillV)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                            end
                            if _G.SkillF then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                                wait(_G.HoldSKillF)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                            end
                        end
                    end
                end
            end)
        end
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if UseGunSkill then
                    local v1220, v1221, v1222 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v1223
                        v1222, v1223 = v1220(v1221, v1222)
                        if v1222 == nil then
                            break
                        end
                        if v1223.Name == MonFarm and (v1223:FindFirstChild("Humanoid") and (v1223:FindFirstChild("HumanoidRootPart") and v1223.Humanoid.Health <= v1223.Humanoid.MaxHealth * _G.Kill_At / 100)) then
                            if _G.SkillZ then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                                wait(0.5)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                            end
                            if _G.SkillX then
                                game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                                wait(0.5)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                            end
                        end
                    end
                end
            end)
        end
    end)
end
v281.Ve:AddSection("Quest")
v281.Ve:AddButton({
    ["Title"] = "Teleport To Dojo Trainer",
    ["Callback"] = function()
        TP2(CFrame.new(5866, 1208, 870))
    end
})
v281.Ve:AddButton({
    ["Title"] = "Teleport To Dragon Hunter",
    ["Callback"] = function()
        TP2(CFrame.new(5863, 1209, 809))
    end
})
v281.Ve:AddButton({
    ["Title"] = "Teleport To Dragon Wizard",
    ["Callback"] = function()
        TP2(CFrame.new(5773, 1209, 806))
    end
})
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Quest Dojo Trainer (Test)",
    ["Default"] = false
})
Toggle:OnChanged(function(p1224)
    _G.QuestDojo = p1224
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Quest Dragon Hunter (Test)",
    ["Default"] = false
})
Toggle:OnChanged(function(p1225)
    _G.QuestDragon = p1225
end)
v281.Ve:AddSection("Craft Item")
v281.Ve:AddButton({
    ["Title"] = "Craft Volcanic Magnet",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "CraftItem",
            "Craft",
            "Volcanic Magnet"
        }))
    end
})
v281.Ve:AddButton({
    ["Title"] = "Craft Dino Hood",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "CraftItem",
            "Craft",
            "DinoHood"
        }))
    end
})
v281.Ve:AddButton({
    ["Title"] = "Craft T-Rex Skull",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "CraftItem",
            "Craft",
            "TRexSkull"
        }))
    end
})
v281.Ve:AddSection("Prehistoric Island")
local vu1226 = v281.Ve:AddParagraph({
    ["Title"] = "Status Prehistoric Island",
    ["Desc"] = ""
})
task.spawn(function()
	-- upvalues: (ref) vu1226
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu1226
            if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                vu1226:SetDesc("Prehistoric Island : Spawn!")
            else
                vu1226:SetDesc("Prehistoric Island : Not Spawn")
            end
        end)
    end
end)
v281.Ve:AddButton({
    ["Title"] = "Remove Lava In Prehistoric Island",
    ["Callback"] = function()
        local v1227, v1228, v1229 = pairs(game.Workspace:GetDescendants())
        while true do
            local v1230
            v1229, v1230 = v1227(v1228, v1229)
            if v1229 == nil then
                break
            end
            if v1230.Name == "Lava" then
                v1230:Destroy()
            end
        end
        local v1231, v1232, v1233 = pairs(game.ReplicatedStorage:GetDescendants())
        while true do
            local v1234
            v1233, v1234 = v1231(v1232, v1233)
            if v1233 == nil then
                break
            end
            if v1234.Name == "Lava" then
                v1234:Destroy()
            end
        end
    end
})
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Find Prehistoric Island",
    ["Default"] = false
})
Toggle:OnChanged(function(p1235)
    _G.FindPrehistoric = p1235
    StopTween(_G.FindPrehistoric)
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.FindPrehistoric then
                if CheckBoat() then
                    local v1236, v1237, v1238 = pairs(game:GetService("Workspace").Boats:GetChildren())
                    while true do
                        local v1239
                        v1238, v1239 = v1236(v1237, v1238)
                        if v1238 == nil then
                            break
                        end
                        if v1239.Name == _G.SelectedBoat and v1239:FindFirstChild("MyBoatEsp") then
                            if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit then
                                repeat
                                    wait()
                                    stopboat = TPB(CFrame.new(- 9999999, 1, 0), v1239.VehicleSeat)
                                until game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") or not (game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit and _G.FindPrehistoric)
                                if stopboat then
                                    stopboat:Stop()
                                end
                                if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                                    _G.FindPrehistoric = false
                                    Notify("Bap Red", "Prehistoric Island Spawn", 3)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                                    wait(0.1)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                                end
                            else
                                stoppos = TP2(v1239.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                            end
                        end
                    end
                else
                    local v1240 = CFrame.new(- 16927.451171875, 9.0863618850708, 433.8642883300781)
                    if (v1240.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                        stoppos = topos(v1240)
                    else
                        TP1(CFrame.new(- 16224, 9, 439))
                    end
                    if (v1240.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        if stoppos then
                            stoppos:Stop()
                        end
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
                        local v1241, v1242, v1243 = pairs(game:GetService("Workspace").Boats:GetChildren())
                        while true do
                            local v1244
                            v1243, v1244 = v1241(v1242, v1243)
                            if v1243 == nil then
                                break
                            end
                            if v1244.Name == _G.SelectedBoat and (v1244.VehicleSeat.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                                AddEsp("MyBoatEsp", v1244)
                            end
                        end
                    end
                end
            end
        end)
    end
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Teleport Prehistoric Island",
    ["Default"] = false
})
Toggle:OnChanged(function(p1245)
    _G.TpPrehistoric = p1245
    StopTween(_G.TpPrehistoric)
end)
spawn(function()
    pcall(function()
        while wait() do
            local v1246 = _G.TpPrehistoric and game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
            if v1246 then
                local v1247 = v1246.WorldPivot.Position
                topos(CFrame.new(v1247.X, 500, v1247.Z))
            end
        end
    end)
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Teleport Skull Core",
    ["Default"] = false
})
Toggle:OnChanged(function(p1248)
    _G.TpSkullCore = p1248
    StopTween(_G.TpSkullCore)
end)
spawn(function()
    local v1249 = nil
    while not v1249 do
        v1249 = game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
        wait()
    end
    while wait() do
        local v1250 = _G.TpSkullCore and game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
        if v1250 then
            local v1251 = v1250:FindFirstChild("Core")
            if v1251 then
                v1251 = v1250.Core:FindFirstChild("PrehistoricRelic")
            end
            if v1251 then
                v1251 = v1251:FindFirstChild("Skull")
            end
            if v1251 then
                topos(CFrame.new(v1251.Position))
                _G.TpSkullCore = false
            end
        end
    end
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Kill Golem",
    ["Default"] = false
})
Toggle:OnChanged(function(p1252)
    _G.Kill_Aura = p1252
    _G.KillGolem = p1252
    StopTween(_G.KillGolem)
end)
spawn(function()
    while wait() do
        if _G.KillGolem and World3 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Lava Golem") then
                    local v1253, v1254, v1255 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v1256
                        v1255, v1256 = v1253(v1254, v1255)
                        if v1255 == nil then
                            break
                        end
                        if v1256.Name == "Lava Golem" and (v1256:FindFirstChild("Humanoid") and (v1256:FindFirstChild("HumanoidRootPart") and v1256.Humanoid.Health > 0)) then
                            repeat
                                task.wait()
                                v1256.HumanoidRootPart.CanCollide = false
                                v1256.Humanoid.WalkSpeed = 0
                                TP2(v1256.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.KillGolem or (not v1256.Parent or v1256.Humanoid.Health <= 0)
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Lava Golem") then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Lava Golem").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                end
            end)
        end
    end
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Fix Volcano",
    ["Default"] = false
})
Toggle:OnChanged(function(p1257)
    _G.DefendVolcano = p1257
    StopTween(_G.DefendVolcano)
end)
local function vu1259(p1258)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, p1258, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, p1258, false, game)
end
local function vu1275()
    local v1260 = game.Workspace.Map.PrehistoricIsland.Core:FindFirstChild("InteriorLava")
    if v1260 and v1260:IsA("Model") then
        v1260:Destroy()
    end
    local v1261 = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
    if v1261 then
        local v1262, v1263, v1264 = pairs(v1261:GetDescendants())
        while true do
            local v1265
            v1264, v1265 = v1262(v1263, v1264)
            if v1264 == nil then
                break
            end
            if v1265:IsA("Part") and v1265.Name:lower():find("lava") then
                v1265:Destroy()
            end
        end
    end
    local v1266 = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
    if v1266 then
        local v1267, v1268, v1269 = pairs(v1266:GetDescendants())
        while true do
            local v1270
            v1269, v1270 = v1267(v1268, v1269)
            if v1269 == nil then
                break
            end
            if v1270:IsA("Model") then
                local v1271, v1272, v1273 = pairs(v1270:GetDescendants())
                while true do
                    local v1274
                    v1273, v1274 = v1271(v1272, v1273)
                    if v1273 == nil then
                        break
                    end
                    if v1274:IsA("MeshPart") and v1274.Name:lower():find("lava") then
                        v1274:Destroy()
                    end
                end
            end
        end
    end
end
local function vu1283()
    local v1276 = game.Workspace.Map.PrehistoricIsland.Core.VolcanoRocks
    local v1277, v1278, v1279 = pairs(v1276:GetChildren())
    while true do
        local v1280
        v1279, v1280 = v1277(v1278, v1279)
        if v1279 == nil then
            break
        end
        if v1280:IsA("Model") then
            local v1281 = v1280:FindFirstChild("volcanorock")
            if v1281 and v1281:IsA("MeshPart") then
                local v1282 = v1281.Color
                if v1282 == Color3.fromRGB(185, 53, 56) or v1282 == Color3.fromRGB(185, 53, 57) then
                    return v1281
                end
            end
        end
    end
    return nil
end
local function vu1295(p1284)
	-- upvalues: (ref) vu1259
    local v1285 = game.Players.LocalPlayer
    local v1286 = v1285.Backpack
    local v1287, v1288, v1289 = pairs(v1286:GetChildren())
    while true do
        local v1290
        v1289, v1290 = v1287(v1288, v1289)
        if v1289 == nil then
            break
        end
        if v1290:IsA("Tool") and v1290.ToolTip == p1284 then
            v1290.Parent = v1285.Character
            local v1291, v1292, v1293 = ipairs({
                "Z",
                "X",
                "C",
                "V",
                "F"
            })
            while true do
                local vu1294
                v1293, vu1294 = v1291(v1292, v1293)
                if v1293 == nil then
                    break
                end
                wait()
                pcall(function()
					-- upvalues: (ref) vu1259, (ref) vu1294
                    vu1259(vu1294)
                end)
            end
            v1290.Parent = v1286
            break
        end
    end
end
spawn(function()
	-- upvalues: (ref) vu1275, (ref) vu1283, (ref) vu1295
    while wait() do
        if _G.DefendVolcano then
            pcall(vu1275)
            local v1296 = vu1283()
            if v1296 then
                local v1297 = CFrame.new(v1296.Position)
                topos(v1297)
                local v1298 = v1296.Color
                if v1298 == Color3.fromRGB(185, 53, 56) or v1298 == Color3.fromRGB(185, 53, 57) then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1296.Position).Magnitude <= 1 then
                        if _G.UseMelee then
                            vu1295("Melee")
                        end
                        if _G.UseFruit then
                            vu1295("Blox Fruit")
                        end
                        if _G.UseSword then
                            vu1295("Sword")
                        end
                        if _G.UseGun then
                            vu1295("Gun")
                        end
                    end
                    _G.TpSkullCore = false
                else
                    vu1283()
                end
            else
                _G.TpSkullCore = true
            end
        end
    end
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Collect Bone",
    ["Default"] = false
})
Toggle:OnChanged(function(p1299)
    _G.CollectBone = p1299
end)
spawn(function()
    while wait() do
        if _G.CollectBone then
            local v1300, v1301, v1302 = pairs(workspace:GetDescendants())
            while true do
                local v1303
                v1302, v1303 = v1300(v1301, v1302)
                if v1302 == nil then
                    break
                end
                if v1303:IsA("BasePart") and v1303.Name == "DinoBone" then
                    topos(CFrame.new(v1303.Position))
                end
            end
        end
    end
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Collect Egg",
    ["Default"] = false
})
Toggle:OnChanged(function(p1304)
    _G.CollectEgg = p1304
end)
spawn(function()
    while wait() do
        if _G.CollectEgg then
            local v1305 = workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren()
            if # v1305 > 0 then
                local v1306 = v1305[math.random(1, # v1305)]
                if v1306:IsA("Model") and v1306.PrimaryPart then
                    topos(v1306.PrimaryPart.CFrame)
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1306.PrimaryPart.Position).Magnitude <= 1 then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                        wait(1.5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                    end
                end
            end
        end
    end
end)
v281.Ve:AddSection("Settings Use Weapons")
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Use Melee",
    ["Default"] = true
})
Toggle:OnChanged(function(p1307)
    _G.UseMelee = p1307
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Use Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1308)
    _G.UseFruit = p1308
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Use Sword",
    ["Default"] = false
})
Toggle:OnChanged(function(p1309)
    _G.UseSword = p1309
end)
Toggle = v281.Ve:AddToggle("Toggle", {
    ["Title"] = "Auto Use Gun",
    ["Default"] = false
})
Toggle:OnChanged(function(p1310)
    _G.UseGun = p1310
end)
v281.V:AddSection("ESP MENU")
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "ESP Player",
    ["Default"] = false
})
Toggle:OnChanged(function(p1311)
    ESPPlayer = p1311
    UpdatePlayerChams()
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "ESP Island Kitsune",
    ["Default"] = false
})
Toggle:OnChanged(function(p1312)
    IslandESP = p1312
    while IslandESP do
        wait()
        UpdateIslandESPKitsune()
    end
end)
function UpdateIslandESPKitsune()
    local v1313, v1314, v1315 = pairs(game:GetService("Workspace").Map.KitsuneIsland.ShrineActive:GetChildren())
    while true do
        local vu1316
        v1315, vu1316 = v1313(v1314, v1315)
        if v1315 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu1316
            if IslandESP then
                if vu1316.Name ~= "NeonShrinePart" then
                    if vu1316:FindFirstChild("IslandESP") then
                        vu1316.IslandESP.TextLabel.Text = "Kitsune Island"
                    else
                        local v1317 = Instance.new("BillboardGui", vu1316)
                        v1317.Name = "IslandESP"
                        v1317.ExtentsOffset = Vector3.new(0, 1, 0)
                        v1317.Size = UDim2.new(1, 200, 1, 30)
                        v1317.Adornee = vu1316
                        v1317.AlwaysOnTop = true
                        local v1318 = Instance.new("TextLabel", v1317)
                        v1318.Font = "Code"
                        v1318.FontSize = "Size14"
                        v1318.TextWrapped = true
                        v1318.Size = UDim2.new(1, 0, 1, 0)
                        v1318.TextYAlignment = "Top"
                        v1318.BackgroundTransparency = 1
                        v1318.TextStrokeTransparency = 0.5
                        v1318.TextColor3 = Color3.fromRGB(80, 245, 245)
                        v1318.Text = "Kitsune Island"
                    end
                end
            elseif vu1316:FindFirstChild("IslandESP") then
                vu1316:FindFirstChild("IslandESP"):Destroy()
            end
        end)
    end
end
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "ESP Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1319)
    DevilFruitESP = p1319
    while DevilFruitESP do
        wait()
        UpdateDevilChams()
    end
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "ESP Flower",
    ["Default"] = false
})
Toggle:OnChanged(function(p1320)
    FlowerESP = p1320
    UpdateFlowerChams()
end)
spawn(function()
    while wait() do
        if FlowerESP then
            UpdateFlowerChams()
        end
        if DevilFruitESP then
            UpdateDevilChams()
        end
        if ESPPlayer then
            UpdatePlayerChams()
        end
    end
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "ESP Island",
    ["Default"] = false
})
Toggle:OnChanged(function(p1321)
    IslandESP = p1321
end)
spawn(function()
    while wait() do
        if IslandESP then
            pcall(function()
                local v1322, v1323, v1324 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
                while true do
                    local v1325
                    v1324, v1325 = v1322(v1323, v1324)
                    if v1324 == nil then
                        break
                    end
                    if not v1325:FindFirstChild("IslandEsp") then
                        local v1326 = Instance.new("BillboardGui")
                        local v1327 = Instance.new("TextLabel")
                        v1326.Parent = v1325
                        v1326.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        v1326.Active = true
                        v1326.Name = "IslandEsp"
                        v1326.AlwaysOnTop = true
                        v1326.LightInfluence = 1
                        v1326.Size = UDim2.new(0, 200, 0, 50)
                        v1326.StudsOffset = Vector3.new(0, 2.5, 0)
                        v1327.Parent = v1326
                        v1327.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        v1327.BackgroundTransparency = 1
                        v1327.Size = UDim2.new(0, 200, 0, 50)
                        v1327.Font = Enum.Font.GothamBold
                        v1327.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v1327.FontSize = "Size14"
                        v1327.TextStrokeTransparency = 0.5
                    end
                    local v1328 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1325.Position).Magnitude / 10)
                    v1325.IslandEsp.TextLabel.Text = v1325.Name .. "\n" .. "[" .. v1328 .. "]"
                end
            end)
        else
            local v1329, v1330, v1331 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
            while true do
                local v1332
                v1331, v1332 = v1329(v1330, v1331)
                if v1331 == nil then
                    break
                end
                if v1332:FindFirstChild("IslandEsp") then
                    v1332.IslandEsp:Destroy()
                end
            end
        end
    end
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Esp Mystic Island",
    ["Default"] = false
})
Toggle:OnChanged(function(p1333)
    MirageIslandESP = p1333
    while MirageIslandESP do
        wait()
        UpdateIslandMirageESP()
    end
end)
v281.V:AddSection("Troll")
v281.V:AddButton({
    ["Title"] = "Rain Fruit",
    ["Callback"] = function()
        local v1334, v1335, v1336 = pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren())
        while true do
            local vu1337
            v1336, vu1337 = v1334(v1335, v1336)
            if v1336 == nil then
                break
            end
            vu1337.Parent = game.Workspace.Map
            vu1337:MoveTo(game.Players.LocalPlayer.Character.PrimaryPart.Position + Vector3.new(math.random(- 50, 50), 100, math.random(- 50, 50)))
            if vu1337.Fruit:FindFirstChild("AnimationController") then
                vu1337.Fruit:FindFirstChild("AnimationController"):LoadAnimation(vu1337.Fruit:FindFirstChild("Idle")):Play()
            end
            vu1337.Handle.Touched:Connect(function(p1338)
				-- upvalues: (ref) vu1337
                if p1338.Parent == game.Players.LocalPlayer.Character then
                    vu1337.Parent = game.Players.LocalPlayer.Backpack
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(vu1337)
                end
            end)
        end
    end
})
v281.V:AddButton({
    ["Title"] = "Instant Level/Beli/EXP",
    ["Callback"] = function()
        local v1339 = game:GetService("Players").LocalPlayer
        local v1340 = require(game:GetService("ReplicatedStorage").Notification)
        local v1341 = v1339:WaitForChild("Data")
        local v1342 = require(game.ReplicatedStorage:WaitForChild("EXPFunction"))
        local v1343 = require(game:GetService("ReplicatedStorage").Effect.Container.LevelUp)
        local v1344 = require(game:GetService("ReplicatedStorage").Util.Sound)
        local v1345 = game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp_Proxy") or game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp")
        function v129(p1346)
            repeat
                local v1347
                p1346, v1347 = string.gsub(p1346, "^(-?%d+)(%d%d%d)", "%1,%2")
            until v1347 == 0
            return p1346
        end
        v1340.new("<Color=Yellow>QUEST COMPLETED!<Color=/>"):Display()
        v1340.new("Earned <Color=Yellow>9,999,999,999,999 Exp.<Color=/> (+ None)"):Display()
        v1340.new("Earned <Color=Green>$9,999,999,999,999<Color=/>"):Display()
        v1339.Data.Exp.Value = 999999999999
        v1339.Data.Beli.Value = v1339.Data.Beli.Value + 999999999999
        local v1348 = 0
        while v1339.Data.Exp.Value - v1342(v1341.Level.Value) > 0 do
            v1339.Data.Exp.Value = v1339.Data.Exp.Value - v1342(v1341.Level.Value)
            v1339.Data.Level.Value = v1339.Data.Level.Value + 1
            v1339.Data.Points.Value = v1339.Data.Points.Value + 3
            v1343({
                v1339
            })
            v1344:Play(v1345.Value)
            v1340.new("<Color=Green>LEVEL UP!<Color=/> (" .. v1339.Data.Level.Value .. ")"):Display()
            v1348 = v1348 + 1
            if v1348 >= 5 then
                tick()
                wait(2)
                v1348 = 0
            end
        end
    end
})
v281.V:AddInput("Input_Level", {
    ["Title"] = "Fake Level",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = true,
    ["Finished"] = false,
    ["Callback"] = function(p1349)
        game:GetService("Players").LocalPlayer.Data.Level.Value = tonumber(p1349)
    end
})
v281.V:AddInput("Input_Exp", {
    ["Title"] = "Fake Exp",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = true,
    ["Finished"] = false,
    ["Callback"] = function(p1350)
        game:GetService("Players").LocalPlayer.Data.Exp.Value = tonumber(p1350)
    end
})
v281.V:AddInput("Input_Money", {
    ["Title"] = "Fake Money",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = true,
    ["Finished"] = false,
    ["Callback"] = function(p1351)
        game:GetService("Players").LocalPlayer.Data.Beli.Value = tonumber(p1351)
    end
})
v281.V:AddInput("Input_Fragment", {
    ["Title"] = "Fake Fragment",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = true,
    ["Finished"] = false,
    ["Callback"] = function(p1352)
        game:GetService("Players").LocalPlayer.Data.Fragments.Value = tonumber(p1352)
    end
})
v281.V:AddInput("Input_Points", {
    ["Title"] = "Fake Points",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = true,
    ["Finished"] = false,
    ["Callback"] = function(p1353)
        game:GetService("Players").LocalPlayer.Data.Points.Value = tonumber(p1353)
    end
})
v281.V:AddInput("Input_Bounty", {
    ["Title"] = "Fake Bounty",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = true,
    ["Finished"] = false,
    ["Callback"] = function(p1354)
        game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value = tonumber(p1354)
    end
})
v281.V:AddSection("Highlight")
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Show Chat disabled",
    ["Default"] = false
})
Toggle:OnChanged(function(p1355)
    _G.chat = p1355
    local v1356 = game:GetService("StarterGui")
    if _G.chat then
        v1356:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
    else
        v1356:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
    end
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Show leaderboard disabled",
    ["Default"] = false
})
Toggle:OnChanged(function(p1357)
    _G.leaderboard = p1357
    local v1358 = game:GetService("StarterGui")
    if _G.leaderboard then
        v1358:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    else
        v1358:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
    end
end)
v281.V:AddSection("Hack")
v281.V:AddButton({
    ["Title"] = "Max Zoom",
    ["Callback"] = function()
        while wait() do
            game.Players.LocalPlayer.CameraMaxZoomDistance = 9223372036854718
        end
    end
})
v281.V:AddButton({
    ["Title"] = "Kaitun Cap",
    ["Callback"] = function()
        local v1359 = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.UIController.Inventory)
        local v1360 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
        local v1361 = {}
        local v1362 = {
            "Mythical",
            "Legendary",
            "Rare",
            "Uncommon",
            "Common"
        }
        local vu1363 = {
            ["Common"] = Color3.fromRGB(179, 179, 179),
            ["Uncommon"] = Color3.fromRGB(92, 140, 211),
            ["Rare"] = Color3.fromRGB(140, 82, 255),
            ["Legendary"] = Color3.fromRGB(213, 43, 228),
            ["Mythical"] = Color3.fromRGB(238, 47, 50)
        }
        function GetRaity(p1364)
			-- upvalues: (ref) vu1363
            local v1365, v1366, v1367 = pairs(vu1363)
            while true do
                local v1368
                v1367, v1368 = v1365(v1366, v1367)
                if v1367 == nil then
                    break
                end
                if v1368 == p1364 then
                    return v1367
                end
            end
        end
        local v1369, v1370, v1371 = pairs(v1360)
        while true do
            local v1372
            v1371, v1372 = v1369(v1370, v1371)
            if v1371 == nil then
                break
            end
            v1361[v1372.Name] = v1372
        end
        local v1373 = # getupvalue(v1359.UpdateRender, 4)
        local v1374 = 0
        local v1375 = {}
        local v1376 = {}
        while v1374 < v1373 do
            local v1377 = 0
            while v1377 < 25000 and v1374 < v1373 do
                game:GetService("Players").LocalPlayer.PlayerGui.Main.InventoryContainer.Right.Content.ScrollingFrame.CanvasPosition = Vector2.new(0, v1377)
                local v1378, v1379, v1380 = pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.InventoryContainer.Right.Content.ScrollingFrame.Frame:GetChildren())
                while true do
                    local v1381
                    v1380, v1381 = v1378(v1379, v1380)
                    if v1380 == nil then
                        break
                    end
                    if v1381:IsA("Frame") and (not v1376[v1381.ItemName.Text] and v1381.ItemName.Visible == true) then
                        local v1382 = GetRaity(v1381.Background.BackgroundColor3)
                        if v1382 then
                            print("Rac")
                            if not v1375[v1382] then
                                v1375[v1382] = {}
                            end
                            table.insert(v1375[v1382], v1381:Clone())
                        end
                        v1374 = v1374 + 1
                        v1376[v1381.ItemName.Text] = true
                    end
                end
                v1377 = v1377 + 20
            end
            wait()
        end
        function GetXY(p1383)
            return p1383 * 100
        end
        local v1384 = Instance.new("UIListLayout")
        v1384.FillDirection = Enum.FillDirection.Vertical
        v1384.SortOrder = 2
        v1384.Padding = UDim.new(0, 10)
        local v1385 = Instance.new("Frame", game.Players.LocalPlayer.PlayerGui.BubbleChat)
        v1385.BackgroundTransparency = 1
        v1385.Size = UDim2.new(0.5, 0, 1, 0)
        v1384.Parent = v1385
        local v1386 = Instance.new("Frame", game.Players.LocalPlayer.PlayerGui.BubbleChat)
        v1386.BackgroundTransparency = 1
        v1386.Size = UDim2.new(0.5, 0, 1, 0)
        v1386.Position = UDim2.new(0.6, 0, 0, 0)
        v1384:Clone().Parent = v1386
        local v1387, v1388, v1389 = pairs(v1375)
        while true do
            local v1390
            v1389, v1390 = v1387(v1388, v1389)
            if v1389 == nil then
                break
            end
            local v1391 = Instance.new("Frame", v1385)
            v1391.BackgroundTransparency = 1
            v1391.Size = UDim2.new(1, 0, 0, 0)
            v1391.LayoutOrder = table.find(v1362, v1389)
            local v1392 = Instance.new("Frame", v1386)
            v1392.BackgroundTransparency = 1
            v1392.Size = UDim2.new(1, 0, 0, 0)
            v1392.LayoutOrder = table.find(v1362, v1389)
            local v1393 = Instance.new("UIGridLayout", v1391)
            v1393.CellPadding = UDim2.new(0.005, 0, 0.005, 0)
            v1393.CellSize = UDim2.new(0, 70, 0, 70)
            v1393.FillDirectionMaxCells = 100
            v1393.FillDirection = Enum.FillDirection.Horizontal
            v1393:Clone().Parent = v1392
            local v1394, v1395, v1396 = pairs(v1390)
            while true do
                local v1397
                v1396, v1397 = v1394(v1395, v1396)
                if v1396 == nil then
                    break
                end
                if v1361[v1397.ItemName.Text] and v1361[v1397.ItemName.Text].Mastery then
                    if v1397.ItemLine2.Text ~= "Accessory" then
                        local v1398 = v1397.ItemName:Clone()
                        v1398.BackgroundTransparency = 1
                        v1398.TextSize = 10
                        v1398.TextXAlignment = 2
                        v1398.TextYAlignment = 2
                        v1398.ZIndex = 5
                        v1398.Text = v1361[v1397.ItemName.Text].Mastery
                        v1398.Size = UDim2.new(0.5, 0, 0.5, 0)
                        v1398.Position = UDim2.new(0.5, 0, 0.5, 0)
                        v1398.Parent = v1397
                    end
                    v1397.Parent = v1391
                elseif v1397.ItemLine2.Text == "Blox Fruit" then
                    v1397.Parent = v1392
                end
            end
            v1391.AutomaticSize = 2
            v1392.AutomaticSize = 2
        end
        local v1399 = {
            ["Superhuman"] = Vector2.new(3, 2),
            ["GodHuman"] = Vector2.new(3, 2),
            ["DeathStep"] = Vector2.new(4, 3),
            ["ElectricClaw"] = Vector2.new(2, 0),
            ["SharkmanKarate"] = Vector2.new(0, 0),
            ["DragonTalon"] = Vector2.new(1, 5)
        }
        local v1400 = Instance.new("Frame", v1385)
        v1400.BackgroundTransparency = 1
        v1400.Size = UDim2.new(1, 0, 0, 0)
        v1400.AutomaticSize = 2
        v1400.LayoutOrder = 100
        local v1401 = Instance.new("UIGridLayout", v1400)
        v1401.CellPadding = UDim2.new(0.005, 0, 0.005, 0)
        v1401.CellSize = UDim2.new(0, 70, 0, 70)
        v1401.FillDirectionMaxCells = 100
        v1401.FillDirection = Enum.FillDirection.Horizontal
        local v1402, v1403, v1404 = pairs({
            "Superhuman",
            "ElectricClaw",
            "DragonTalon",
            "SharkmanKarate",
            "DeathStep",
            "GodHuman"
        })
        while true do
            local v1405
            v1404, v1405 = v1402(v1403, v1404)
            if v1404 == nil then
                break
            end
            if v1399[v1405] and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy" .. v1405, true) == 1 then
                local v1406 = Instance.new("ImageLabel", v1400)
                v1406.Image = "rbxassetid://9945562382"
                v1406.ImageRectSize = Vector2.new(100, 100)
                v1406.ImageRectOffset = v1399[v1405] * 100
            end
        end
        function formatNumber(p1407)
            return tostring(p1407):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
        end
        game:GetService("Players").LocalPlayer.PlayerGui.Main.Beli.Position = UDim2.new(0, 800, 0, 500)
        game:GetService("Players").LocalPlayer.PlayerGui.Main.Level.Position = UDim2.new(0, 800, 0, 550)
        local v1408 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Fragments:Clone()
        v1408.Parent = game:GetService("Players").LocalPlayer.PlayerGui.BubbleChat
        v1408.Position = UDim2.new(0, 800, 0.63, 0)
        v1408.Text = "\195\131\226\128\160\195\162\226\130\172\226\132\162" .. formatNumber(game.Players.LocalPlayer.Data.Fragments.Value)
        print("Done")
        pcall(function()
            game:GetService("Players").LocalPlayer.PlayerGui.Main.MenuButton:Destroy()
        end)
        pcall(function()
            game:GetService("Players").LocalPlayer.PlayerGui.Main.HP:Destroy()
        end)
        pcall(function()
            game:GetService("Players").LocalPlayer.PlayerGui.Main.Energy:Destroy()
        end)
        local v1409, v1410, v1411 = pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main:GetChildren())
        while true do
            local v1412
            v1411, v1412 = v1409(v1410, v1411)
            if v1411 == nil then
                break
            end
            if v1412:IsA("ImageButton") then
                v1412:Destroy()
            end
        end
        pcall(function()
            game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass:Destroy()
        end)
    end
})
v281.V:AddSection("Graphic")
v281.V:AddButton({
    ["Title"] = "Remove Fog (Sea 3)",
    ["Callback"] = function()
        game:GetService("Lighting").LightingLayers:Destroy()
        game:GetService("Lighting").Sky:Destroy()
    end
})
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Remove Fog",
    ["Default"] = false
})
Toggle:OnChanged(function(p1413)
    RemoveFog = p1413
    if RemoveFog then
        while RemoveFog do
            wait()
            game.Lighting.FogEnd = 9000000000
            if not RemoveFog then
                game.Lighting.FogEnd = 2500
            end
        end
    end
end)
v281.V:AddButton({
    ["Title"] = "Unlock FPS",
    ["Callback"] = function()
        setfpscap(9999999)
    end
})
v281.V:AddSection("Abilities")
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Dodge No Cooldown",
    ["Default"] = false
})
Toggle:OnChanged(function(p1414)
    nododgecool = p1414
    NoDodgeCool()
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Infinite Energy",
    ["Default"] = false
})
Toggle:OnChanged(function(p1415)
	-- upvalues: (ref) vu146, (ref) vu145
    InfiniteEnergy = p1415
    vu146 = vu145.Character.Energy.Value
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Infinite Ability",
    ["Default"] = false
})
Toggle:OnChanged(function(p1416)
    InfAbility = p1416
    local v1417 = not p1416 and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility")
    if v1417 then
        v1417:Destroy()
    end
end)
spawn(function()
    while wait() do
        if InfAbility then
            InfAb()
        end
    end
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Infinite Obversation Range",
    ["Default"] = false
})
Toggle:OnChanged(function(p1418)
    getgenv().InfiniteObRange = p1418
    local v1419 = game:GetService("Players").LocalPlayer.VisionRadius.Value
    while getgenv().InfiniteObRange do
        wait()
        local v1420 = game:GetService("Players").LocalPlayer
        local v1421 = v1420.Character
        local v1422 = v1420.VisionRadius
        if v1420 then
            if v1421.Humanoid.Health <= 0 then
                wait(5)
            end
            v1422.Value = math.huge
        elseif not getgenv().InfiniteObRange and v1420 then
            v1422.Value = v1419
        end
    end
end)
Toggle = v281.V:AddToggle("Toggle", {
    ["Title"] = "Infinite Geppo",
    ["Default"] = false
})
Toggle:OnChanged(function(p1423)
    getgenv().InfGeppo = p1423
end)
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().InfGeppo then
                local v1424 = next
                local v1425, v1426 = getgc()
                while true do
                    local v1427
                    v1426, v1427 = v1424(v1425, v1426)
                    if v1426 == nil then
                        break
                    end
                    if game:GetService("Players").LocalPlayer.Character.Geppo and typeof(v1427) == "function" and getfenv(v1427).script == game:GetService("Players").LocalPlayer.Character.Geppo then
                        local v1428 = next
                        local v1429, v1430 = getupvalues(v1427)
                        while true do
                            local v1431
                            v1430, v1431 = v1428(v1429, v1430)
                            if v1430 == nil then
                                break
                            end
                            if tostring(v1430) == "9" then
                                local v1432 = v1430
                                repeat
                                    wait(0.1)
                                    setupvalue(v1427, v1430, 0)
                                until not getgenv().InfGeppo or game:GetService("Players").LocalPlayer.Character.Humanoid.Health <= 0
                                v1430 = v1432
                            end
                        end
                    end
                end
            end
        end)
    end
end)
v281.V:AddButton({
    ["Title"] = "Remove Lava",
    ["Callback"] = function()
        local v1433, v1434, v1435 = pairs(game.Workspace:GetDescendants())
        while true do
            local v1436
            v1435, v1436 = v1433(v1434, v1435)
            if v1435 == nil then
                break
            end
            if v1436.Name == "Lava" then
                v1436:Destroy()
            end
        end
        local v1437, v1438, v1439 = pairs(game.ReplicatedStorage:GetDescendants())
        while true do
            local v1440
            v1439, v1440 = v1437(v1438, v1439)
            if v1439 == nil then
                break
            end
            if v1440.Name == "Lava" then
                v1440:Destroy()
            end
        end
    end
})
local vu1441 = v281.P:AddParagraph({
    ["Title"] = "Player",
    ["Desc"] = ""
})
spawn(function()
	-- upvalues: (ref) vu1441
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu1441
            local v1442, v1443, v1444 = pairs(game:GetService("Players"):GetPlayers())
            while true do
                local v1445
                v1444, v1445 = v1442(v1443, v1444)
                if v1444 == nil then
                    break
                end
                if v1444 == 12 then
                    vu1441:SetDesc("Players:" .. " " .. v1444 .. " / 12 (Max)")
                elseif v1444 == 1 then
                    vu1441:SetDesc("Player:" .. " " .. v1444 .. " / 12")
                else
                    vu1441:SetDesc("Players:" .. " " .. v1444 .. " / 12")
                end
            end
        end)
    end
end)
local v1446, v1447, v1448 = pairs(game:GetService("Players"):GetPlayers())
local vu1449 = vu163
local vu1450 = {}
while true do
    local v1451
    v1448, v1451 = v1446(v1447, v1448)
    if v1448 == nil then
        break
    end
    table.insert(vu1450, v1451.Name)
end
SelectedPly = v281.P:AddDropdown("SelectedPly", {
    ["Title"] = "Select Player",
    ["Values"] = vu1450,
    ["Default"] = _G.SelectPly
})
SelectedPly:SetValue(_G.SelectPly)
SelectedPly:OnChanged(function(p1452)
    _G.SelectPly = p1452
end)
v281.P:AddButton({
    ["Title"] = "Refresh Player",
    ["Description"] = "",
    ["Callback"] = function()
		-- upvalues: (ref) vu1450
        vu1450 = {}
        if not SelectedPly then
            SelectedPly = {}
        end
        if type(SelectedPly.Clear) == "function" then
            SelectedPly:Clear()
        end
        local v1453, v1454, v1455 = pairs(game:GetService("Players"):GetChildren())
        while true do
            local v1456
            v1455, v1456 = v1453(v1454, v1455)
            if v1455 == nil then
                break
            end
            table.insert(vu1450, v1456.Name)
            if type(SelectedPly.Add) == "function" then
                SelectedPly:Add(v1456.Name)
            end
        end
    end
})
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Spectate Player",
    ["Default"] = false
})
Toggle:OnChanged(function(p1457)
    SpectatePlys = p1457
    local v1458 = game:GetService("Players").LocalPlayer.Character
    if v1458 then
        v1458 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
    end
    local v1459 = _G.SelectPly
    if v1459 then
        v1459 = game:GetService("Players"):FindFirstChild(_G.SelectPly)
    end
    local v1460 = v1459 and v1459.Character
    if v1460 then
        v1460 = v1459.Character:FindFirstChild("Humanoid")
    end
    if v1460 then
        repeat
            wait(0.1)
            game:GetService("Workspace").Camera.CameraSubject = v1460
        until SpectatePlys == false
        if v1458 then
            game:GetService("Workspace").Camera.CameraSubject = v1458
        end
    end
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Teleport",
    ["Default"] = false
})
Toggle:OnChanged(function(p1461)
    _G.TeleportPly = p1461
    pcall(function()
        if _G.TeleportPly then
            repeat
                topos(game:GetService("Players")[_G.SelectPly].Character.HumanoidRootPart.CFrame)
                wait()
            until _G.TeleportPly == false
        end
        StopTween(_G.TeleportPly)
    end)
end)
v281.P:AddSection("PvP")
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Aimbot Nearest",
    ["Default"] = false
})
Toggle:OnChanged(function(p1462)
    _G.AimNearest = p1462
end)
local vu1463 = game:GetService("Players")
local vu1464 = vu1463.LocalPlayer
local v1465 = game:GetService("RunService")
local function vu1475()
	-- upvalues: (ref) vu1463, (ref) vu1464
    local v1466 = math.huge
    local v1467 = vu1463
    local v1468, v1469, v1470 = pairs(v1467:GetPlayers())
    local v1471 = nil
    while true do
        local v1472
        v1470, v1472 = v1468(v1469, v1470)
        if v1470 == nil then
            break
        end
        if v1472 ~= vu1464 and v1472.Character and (v1472.Character:FindFirstChild("HumanoidRootPart") and (v1472.Team ~= vu1464.Team and v1472.Team.Name ~= "Marines")) then
            local v1473 = v1472.Character.HumanoidRootPart.Position
            local v1474 = (vu1464.Character.HumanoidRootPart.Position - v1473).Magnitude
            if v1474 < v1466 then
                v1471 = v1472
                v1466 = v1474
            end
        end
    end
    return v1471
end
v1465.RenderStepped:Connect(function()
	-- upvalues: (ref) vu1475
    local v1476 = _G.AimNearest and vu1475()
    if v1476 then
        _G.Aim_Players = v1476
    end
end)
local v1477 = getrawmetatable(game)
local vu1478 = v1477.__namecall
setreadonly(v1477, false)
v1477.__namecall = newcclosure(function(...)
	-- upvalues: (ref) vu1478
    local v1479 = getnamecallmethod()
    local v1480 = {
        ...
    }
    if tostring(v1479) ~= "FireServer" or (tostring(v1480[1]) ~= "RemoteEvent" or (tostring(v1480[2]) == "true" or (tostring(v1480[2]) == "false" or not (_G.AimNearest and _G.Aim_Players)))) then
        return vu1478(...)
    end
    v1480[2] = _G.Aim_Players.Character.HumanoidRootPart.Position
    return vu1478(unpack(v1480))
end)
setreadonly(v1477, true)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "No Stun When Using Skill",
    ["Default"] = false
})
Toggle:OnChanged(function(p1481)
    _G.NoSt = p1481
end)
spawn(function()
	-- upvalues: (ref) vu256
    while wait() do
        if _G.NoSt then
            local v1482 = next
            local v1483, v1484 = vu256.Character:GetDescendants()
            while true do
                local v1485
                v1484, v1485 = v1482(v1483, v1484)
                if v1484 == nil then
                    break
                end
                if table.find({
                    "BodyGyro",
                    "BodyPosition"
                }, v1485.ClassName) then
                    v1485:Destroy()
                end
            end
        end
    end
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Enabled PvP",
    ["Default"] = false
})
Toggle:OnChanged(function(p1486)
    _G.EnabledPvP = p1486
end)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.EnabledPvP and game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
            end
        end
    end)
end)
v281.P:AddButton({
    ["Title"] = "Set Position Spawn",
    ["Callback"] = function()
        _G.Pos_Spawn = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Com()
    end
})
v281.P:AddButton({
    ["Title"] = "Respawn",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
        wait()
    end
})
v281.P:AddSection("Other Players")
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Auto Active V3",
    ["Default"] = false
})
Toggle:OnChanged(function(p1487)
    _G.ActiveV3 = p1487
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.ActiveV3 then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
            end
        end
    end)
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Auto Active V4",
    ["Default"] = false
})
Toggle:OnChanged(function(p1488)
    _G.ActiveV4 = p1488
end)
spawn(function()
    while task.wait() do
        if _G.ActiveV4 then
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy") and game.Players.LocalPlayer.Character.RaceEnergy.Value >= 1 and (game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") and not game.Players.LocalPlayer.Character.RaceTransformed.Value) then
                    game:GetService("Players").LocalPlayer.Backpack.Awakening.RemoteFunction:InvokeServer(unpack({
                        true
                    }))
                end
            end)
        end
    end
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Enable Fly",
    ["Default"] = false
})
Toggle:OnChanged(function(p1489)
	-- upvalues: (ref) vu180, (ref) vu1449
    if p1489 then
        _G.NoClip = true
        vu180(speaker, true)
    else
        _G.NoClip = false
        vu1449(speaker)
    end
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Walk on Water",
    ["Default"] = true
})
Toggle:OnChanged(function(p1490)
    _G.WalkWater = p1490
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.WalkWater then
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
            else
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
            end
        end)
    end
end)
Dropdown = v281.P:AddDropdown("Dropdown", {
    ["Title"] = "Select Walk Speed",
    ["Values"] = {
        "50",
        "100",
        "200",
        "250",
        "300",
        "350"
    },
    ["Multi"] = false
})
Dropdown:SetValue("200")
Dropdown:OnChanged(function(p1491)
    _G.SelectSp = p1491
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Walk Speed",
    ["Default"] = false
})
Toggle:OnChanged(function(p1492)
    _G.WalkSp = p1492
end)
game:GetService("RunService").RenderStepped:Connect(function()
	-- upvalues: (ref) vu256
    if vu256.Character and (vu256.Character:FindFirstChild("Humanoid") and _G.WalkSp) then
        vu256.Character.Humanoid.WalkSpeed = tonumber(_G.SelectSp)
    end
end)
Dropdown = v281.P:AddDropdown("Dropdown", {
    ["Title"] = "Select High Jump",
    ["Values"] = {
        "50",
        "100",
        "200",
        "250",
        "300",
        "350",
        "400"
    },
    ["Multi"] = false
})
Dropdown:SetValue("200")
Dropdown:OnChanged(function(p1493)
    _G.SelectJp = p1493
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "High Jump",
    ["Default"] = false
})
Toggle:OnChanged(function(p1494)
    _G.JumpSp = p1494
end)
game:GetService("RunService").RenderStepped:Connect(function()
	-- upvalues: (ref) vu256
    if vu256.Character and (vu256.Character:FindFirstChild("Humanoid") and _G.JumpSp) then
        vu256.Character.Humanoid.JumpPower = tonumber(_G.SelectJp)
    end
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "NoClip",
    ["Default"] = false
})
Toggle:OnChanged(function(p1495)
    _G.NoClip = p1495
end)
spawn(function()
    while wait() do
        if sethiddenproperty then
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 100)
        end
        if setscriptable then
            setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
            local v1496 = game.Players.LocalPlayer
            local v1497 = math.huge * math.huge
            local _ = math.huge * math.huge * 0 / 0 * 0 / 0 * 0 / 0 * 0 / 0 * 0 / 0
            v1496.SimulationRadius = v1497
        end
    end
end)
v281.P:AddSection("Stats")
local vu1498 = v281.P:AddParagraph({
    ["Title"] = "Stat Points",
    ["Desc"] = ""
})
local vu1499 = v281.P:AddParagraph({
    ["Title"] = "Melee",
    ["Desc"] = ""
})
local vu1500 = v281.P:AddParagraph({
    ["Title"] = "Defense",
    ["Desc"] = ""
})
local vu1501 = v281.P:AddParagraph({
    ["Title"] = "Sword",
    ["Desc"] = ""
})
local vu1502 = v281.P:AddParagraph({
    ["Title"] = "Gun",
    ["Desc"] = ""
})
local vu1503 = v281.P:AddParagraph({
    ["Title"] = "Fruit",
    ["Desc"] = ""
})
spawn(function()
	-- upvalues: (ref) vu1498, (ref) vu1499, (ref) vu1500, (ref) vu1501, (ref) vu1502, (ref) vu1503
    while task.wait() do
        pcall(function()
			-- upvalues: (ref) vu1498, (ref) vu1499, (ref) vu1500, (ref) vu1501, (ref) vu1502, (ref) vu1503
            vu1498:SetDesc("Stat Points: " .. tostring(game:GetService("Players").LocalPlayer.Data.Points.Value))
            vu1499:SetDesc("Melee: " .. game.Players.localPlayer.Data.Stats.Melee.Level.Value)
            vu1500:SetDesc("Defense: " .. game.Players.localPlayer.Data.Stats.Defense.Level.Value)
            vu1501:SetDesc("Sword: " .. game.Players.localPlayer.Data.Stats.Sword.Level.Value)
            vu1502:SetDesc("Gun: " .. game.Players.localPlayer.Data.Stats.Gun.Level.Value)
            vu1503:SetDescSet("Fruit: " .. game.Players.localPlayer.Data.Stats["Demon Fruit"].Level.Value)
        end)
    end
end)
v281.P:AddSlider("Slider", {
    ["Title"] = "Select Stats Kaitun",
    ["Min"] = 1,
    ["Max"] = 100,
    ["Default"] = 1,
    ["Rounding"] = 1,
    ["Callback"] = function(p1504)
        _G.Point = p1504
    end
})
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Auto Stats Kaitun",
    ["Default"] = false
})
Toggle:OnChanged(function(p1505)
    _G.Stats_Kaitun = p1505
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.Stats_Kaitun then
                if World1 then
                    local v1506 = {
                        "AddPoint",
                        "Melee",
                        _G.Point
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1506))
                elseif World2 then
                    local v1507 = {
                        "AddPoint",
                        "Melee",
                        _G.Point
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1507))
                    local v1508 = {
                        "AddPoint",
                        "Defense",
                        _G.Point
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1508))
                end
            end
        end)
    end
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Melee",
    ["Default"] = false
})
Toggle:OnChanged(function(p1509)
    melee = p1509
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Defense",
    ["Default"] = false
})
Toggle:OnChanged(function(p1510)
    defense = p1510
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Sword",
    ["Default"] = false
})
Toggle:OnChanged(function(p1511)
    sword = p1511
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Gun",
    ["Default"] = false
})
Toggle:OnChanged(function(p1512)
    gun = p1512
end)
Toggle = v281.P:AddToggle("Toggle", {
    ["Title"] = "Devil Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1513)
    demonfruit = p1513
end)
spawn(function()
    while wait() do
        if melee then
            local v1514 = {
                "AddPoint",
                "Melee",
                _G.Point
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1514))
        end
        if defense then
            local v1515 = {
                "AddPoint",
                "Defense",
                _G.Point
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1515))
        end
        if sword then
            local v1516 = {
                "AddPoint",
                "Sword",
                _G.Point
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1516))
        end
        if gun then
            local v1517 = {
                "AddPoint",
                "Gun",
                _G.Point
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1517))
        end
        if demonfruit then
            local v1518 = {
                "AddPoint",
                "Demon Fruit",
                _G.Point
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1518))
        end
    end
end)
v281.R:AddSection("Raid")
_G.SelectChip = selectraids or ""
Raidslist = {}
RaidsModule = require(game.ReplicatedStorage.Raids)
local v1519, v1520, v1521 = pairs(RaidsModule.raids)
while true do
    local v1522
    v1521, v1522 = v1519(v1520, v1521)
    if v1521 == nil then
        break
    end
    table.insert(Raidslist, v1522)
end
local v1523, v1524, v1525 = pairs(RaidsModule.advancedRaids)
while true do
    local v1526
    v1525, v1526 = v1523(v1524, v1525)
    if v1525 == nil then
        break
    end
    table.insert(Raidslist, v1526)
end
Dropdown = v281.R:AddDropdown("Dropdown", {
    ["Title"] = "Select Chips",
    ["Values"] = Raidslist,
    ["Multi"] = false,
    ["Default"] = false
})
Dropdown:OnChanged(function(p1527)
    _G.SelectChip = p1527
end)
Toggle = v281.R:AddToggle("Toggle", {
    ["Title"] = "Auto Select Dungeon",
    ["Default"] = false
})
Toggle:OnChanged(function(p1528)
    _G.SelectDungeon = p1528
end)
spawn(function()
    while wait() do
        if _G.SelectDungeon then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame-Flame") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame-Flame") then
                    _G.SelectChip = "Flame"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice-Ice") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice-Ice") then
                    _G.SelectChip = "Ice"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake-Quake") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake-Quake") then
                    _G.SelectChip = "Quake"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light-Light") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light-Light") then
                    _G.SelectChip = "Light"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark-Dark") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark-Dark") then
                    _G.SelectChip = "Dark"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("String-String") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("String-String") then
                    _G.SelectChip = "String"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble-Rumble") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble-Rumble") then
                    _G.SelectChip = "Rumble"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma-Magma") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma-Magma") then
                    _G.SelectChip = "Magma"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Human-Human: Buddha Fruit") then
                    _G.SelectChip = "Human: Buddha"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand-Sand") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand-Sand") then
                    _G.SelectChip = "Sand"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird-Bird: Phoenix") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird-Bird: Phoenix") then
                    _G.SelectChip = "Bird: Phoenix"
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough") then
                    _G.SelectChip = "Dough"
                else
                    _G.SelectChip = "Flame"
                end
            end)
        end
    end
end)
Toggle = v281.R:AddToggle("Toggle", {
    ["Title"] = "Auto Buy Chip",
    ["Default"] = false
})
Toggle:OnChanged(function(p1529)
    _G.BuyChip = p1529
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.BuyChip and not (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip")) and not game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Island 1") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
            end
        end
    end)
end)
v281.R:AddButton({
    ["Title"] = "Buy Chip Select",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
    end
})
Toggle = v281.R:AddToggle("Toggle", {
    ["Title"] = "Auto Start Go To Dungeon",
    ["Default"] = false
})
Toggle:OnChanged(function(p1530)
    _G.StartRaid = p1530
end)
spawn(function()
    while wait(0.1) do
        pcall(function()
            if _G.StartRaid and game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible == false and (not game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Island 1") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip")) then
                if World2 then
                    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                elseif World3 then
                    fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                end
            end
        end)
    end
end)
v281.R:AddButton({
    ["Title"] = "Start Go To Dungeon",
    ["Callback"] = function()
        if World2 then
            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
        elseif World3 then
            fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
        end
    end
})
Toggle = v281.R:AddToggle("Toggle", {
    ["Title"] = "Auto Next Island And Kill Mob",
    ["Default"] = false
})
Toggle:OnChanged(function(p1531)
    _G.Dungeon = p1531
    StopTween(_G.Dungeon)
end)
function IsIslandRaid(p1532)
    if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Island " .. p1532) then
        min = 4500
        local v1533, v1534, v1535 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
        while true do
            local v1536
            v1535, v1536 = v1533(v1534, v1535)
            if v1535 == nil then
                break
            end
            if v1536.Name == "Island " .. p1532 and (v1536.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < min then
                min = (v1536.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            end
        end
        local v1537, v1538, v1539 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
        while true do
            local v1540
            v1539, v1540 = v1537(v1538, v1539)
            if v1539 == nil then
                break
            end
            if v1540.Name == "Island " .. p1532 and (v1540.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= min then
                return v1540
            end
        end
    end
end
function getNextIsland()
    TableIslandsRaid = {
        5,
        4,
        3,
        2,
        1
    }
    local v1541, v1542, v1543 = pairs(TableIslandsRaid)
    while true do
        local v1544
        v1543, v1544 = v1541(v1542, v1543)
        if v1543 == nil then
            break
        end
        if IsIslandRaid(v1544) and (IsIslandRaid(v1544).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4500 then
            return IsIslandRaid(v1544)
        end
    end
end
function attackNearbyEnemies()
    local v1545, v1546, v1547 = pairs(game:GetService("Workspace").Enemies:GetChildren())
    local v1548 = {}
    while true do
        local v1549
        v1547, v1549 = v1545(v1546, v1547)
        if v1547 == nil then
            break
        end
        if v1549:FindFirstChild("HumanoidRootPart") and (v1549:FindFirstChild("Humanoid") and (v1549.Humanoid.Health > 0 and (v1549.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000)) then
            table.insert(v1548, v1549)
        end
    end
    local v1550, v1551, v1552 = pairs(v1548)
	-- ::l13::
    if false then
        return
    end
    local v1553
    v1552, v1553 = v1550(v1551, v1552)
    if v1552 == nil then
        break
    end
    while true do
        if v1553:FindFirstChild("Humanoid") and v1553.Humanoid.Health > 0 then
            EquipWeapon(_G.SelectWeapon)
            topos(v1553.HumanoidRootPart.CFrame * Pos)
            wait(0.1)
        end
        if not v1553:FindFirstChild("Humanoid") or v1553.Humanoid.Health <= 0 then
			-- goto l13
        end
    end
end
spawn(function()
    while wait() do
        if _G.Dungeon then
            attackNearbyEnemies()
            if getNextIsland() then
                spawn(topos(getNextIsland().CFrame * CFrame.new(0, 60, 0)), 1)
            end
        end
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G.Kill_Aura then
                local vu1554 = game:GetService("Players").LocalPlayer
                local v1555 = game:GetService("Workspace").Enemies:GetChildren()
                local v1556 = vu1554.Character and vu1554.Character:FindFirstChild("HumanoidRootPart")
                if v1556 then
                    v1556 = vu1554.Character.HumanoidRootPart.Position
                end
                if v1556 then
                    local v1557, v1558, v1559 = pairs(v1555)
                    while true do
                        local vu1560
                        v1559, vu1560 = v1557(v1558, v1559)
                        if v1559 == nil then
                            break
                        end
                        if vu1560:FindFirstChild("Humanoid") and (vu1560:FindFirstChild("HumanoidRootPart") and (vu1560.Humanoid.Health > 0 and (vu1560.HumanoidRootPart.Position - v1556).Magnitude <= 1000)) then
                            pcall(function()
								-- upvalues: (ref) vu1554, (ref) vu1560
                                repeat
                                    wait()
                                    sethiddenproperty(vu1554, "SimulationRadius", math.huge)
                                    vu1560.Humanoid.Health = 0
                                    vu1560.HumanoidRootPart.CanCollide = false
                                until not _G.Kill_Aura or (not vu1560.Parent or vu1560.Humanoid.Health <= 0)
                            end)
                        end
                    end
                end
            end
        end
    end)
end)
Toggle = v281.R:AddToggle("Toggle", {
    ["Title"] = "Auto Awakener",
    ["Default"] = false
})
Toggle:OnChanged(function(p1561)
    _G.Awakener = p1561
end)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Awakener then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Check")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Awaken")
            end
        end
    end)
end)
if World2 then
    v281.R:AddButton({
        ["Title"] = "Teleport to Lab",
        ["Callback"] = function()
            topos(CFrame.new(- 6438.73535, 250.645355, - 4501.50684))
        end
    })
elseif World3 then
    v281.R:AddButton({
        ["Title"] = "Teleport to Lab",
        ["Callback"] = function()
            topos(CFrame.new(- 11571.440429688, 49.172668457031, - 7574.7368164062))
        end
    })
end
if World2 then
    v281.R:AddSection("Misc KoKo Sword")
    Toggle = v281.R:AddToggle("Toggle", {
        ["Title"] = "Auto Law",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1562)
        _G.OderSword = p1562
        StopTween(_G.OderSword)
    end)
    Toggle = v281.R:AddToggle("Toggle", {
        ["Title"] = "Auto Law Hop",
        ["Default"] = false
    })
    Toggle:OnChanged(function(p1563)
        _G.OderSwordHop = p1563
    end)
    spawn(function()
        while wait() do
            if _G.OderSword then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                        local v1564, v1565, v1566 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                        while true do
                            local v1567
                            v1566, v1567 = v1564(v1565, v1566)
                            if v1566 == nil then
                                break
                            end
                            if v1567.Name == "Order" and (v1567:FindFirstChild("Humanoid") and (v1567:FindFirstChild("HumanoidRootPart") and v1567.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    v1567.HumanoidRootPart.CanCollide = false
                                    v1567.Humanoid.WalkSpeed = 0
                                    TP2(v1567.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.OderSword or (not v1567.Parent or v1567.Humanoid.Health <= 0)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif _G.OderSwordHop then
                        Hop()
                    end
                end)
            end
        end
    end)
    v281.R:AddButton({
        ["Title"] = "Buy Microchip Law Boss",
        ["Callback"] = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "BlackbeardReward",
                "Microchip",
                "2"
            }))
        end
    })
    v281.R:AddButton({
        ["Title"] = "Start Go To Raid Law Boss",
        ["Callback"] = function()
            if World2 then
                fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            end
        end
    })
end
v281.T:AddSection("World")
v281.T:AddButton({
    ["Title"] = "Teleport To Old World",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
})
v281.T:AddButton({
    ["Title"] = "Teleport To Second Sea",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})
v281.T:AddButton({
    ["Title"] = "Teleport To Third Sea",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
})
v281.T:AddSection("Island")
if World1 then
    Dropdown = v281.T:AddDropdown("Dropdown", {
        ["Title"] = "Select Island",
        ["Default"] = false,
        ["Values"] = {
            "WindMill",
            "Marine",
            "Middle Town",
            "Jungle",
            "Pirate Village",
            "Desert",
            "Snow Island",
            "MarineFord",
            "Colosseum",
            "Sky Island 1",
            "Sky Island 2",
            "Sky Island 3",
            "Prison",
            "Magma Village",
            "Under Water Island",
            "Fountain City"
        }
    })
    Dropdown:OnChanged(function(p1568)
        _G.SelectIsland = p1568
    end)
end
if World2 then
    Dropdown = v281.T:AddDropdown("Dropdown", {
        ["Title"] = "Select Island",
        ["Default"] = false,
        ["Values"] = {
            "The Cafe",
            "Frist Spot",
            "Dark Area",
            "Flamingo Mansion",
            "Flamingo Room",
            "Green Zone",
            "Zombie Island",
            "Two Snow Mountain",
            "Punk Hazard",
            "Cursed Ship",
            "Ice Castle",
            "Forgotten Island",
            "Ussop Island"
        }
    })
    Dropdown:OnChanged(function(p1569)
        _G.SelectIsland = p1569
    end)
end
if World3 then
    Dropdown = v281.T:AddDropdown("Dropdown", {
        ["Title"] = "Select Island",
        ["Default"] = false,
        ["Values"] = {
            "Mansion",
            "Port Town",
            "Great Tree",
            "Castle On The Sea",
            "Hydra Island",
            "Floating Turtle",
            "Haunted Castle",
            "Ice Cream Island",
            "Peanut Island",
            "Cake Island",
            "Candy Cane Island",
            "Tiki Outpost"
        }
    })
    Dropdown:OnChanged(function(p1570)
        _G.SelectIsland = p1570
    end)
end
Toggle = v281.T:AddToggle("Toggle", {
    ["Title"] = "Teleport",
    ["Default"] = false
})
Toggle:OnChanged(function(p1571)
    _G.TeleportIsland = p1571
    if _G.TeleportIsland then
        spawn(function()
            while true do
                wait()
                local v1572 = {
                    ["Middle Town"] = CFrame.new(- 688, 15, 1585),
                    ["MarineFord"] = CFrame.new(- 4810, 21, 4359),
                    ["Marine"] = CFrame.new(- 2728, 25, 2056),
                    ["WindMill"] = CFrame.new(889, 17, 1434),
                    ["Desert"] = CFrame.new(945, 21, 4375),
                    ["Snow Island"] = CFrame.new(1298, 87, - 1344),
                    ["Pirate Village"] = CFrame.new(- 1173, 45, 3837),
                    ["Jungle"] = CFrame.new(- 1614, 37, 146),
                    ["Prison"] = CFrame.new(4870, 6, 736),
                    ["Under Water Island"] = CFrame.new(61164, 5, 1820),
                    ["Colosseum"] = CFrame.new(- 1535, 7, - 3014),
                    ["Magma Village"] = CFrame.new(- 5290, 9, 8349),
                    ["Sky Island 1"] = CFrame.new(- 4814, 718, - 2551),
                    ["Sky Island 2"] = CFrame.new(- 4652, 873, - 1754),
                    ["Sky Island 3"] = CFrame.new(- 7895, 5547, - 380),
                    ["Fountain City"] = CFrame.new(5128, 60, 4106),
                    ["The Cafe"] = CFrame.new(- 382, 73, 290),
                    ["Frist Spot"] = CFrame.new(- 11, 29, 2771),
                    ["Dark Area"] = CFrame.new(3494, 13, - 3259),
                    ["Flamingo Mansion"] = CFrame.new(- 317, 331, 597),
                    ["Flamingo Room"] = CFrame.new(2285, 15, 905),
                    ["Green Zone"] = CFrame.new(- 2258, 73, - 2696),
                    ["Zombie Island"] = CFrame.new(- 5552, 194, - 776),
                    ["Two Snow Mountain"] = CFrame.new(752, 408, - 5277),
                    ["Punk Hazard"] = CFrame.new(- 5897, 18, - 5096),
                    ["Cursed Ship"] = CFrame.new(919, 125, 32869),
                    ["Ice Castle"] = CFrame.new(5505, 40, - 6178),
                    ["Forgotten Island"] = CFrame.new(- 3050, 240, - 10178),
                    ["Ussop Island"] = CFrame.new(4816, 8, 2863),
                    ["Mansion"] = CFrame.new(- 12471, 374, - 7551),
                    ["Port Town"] = CFrame.new(- 339, 21, 5555),
                    ["Castle On The Sea"] = CFrame.new(- 5073, 315, - 3153),
                    ["Hydra Island"] = CFrame.new(5290, 1005, 392),
                    ["Great Tree"] = CFrame.new(2681, 1682, - 7190),
                    ["Floating Turtle"] = CFrame.new(- 12528, 332, - 8658),
                    ["Haunted Castle"] = CFrame.new(- 9517, 142, 5528),
                    ["Ice Cream Island"] = CFrame.new(- 902, 79, - 10988),
                    ["Peanut Island"] = CFrame.new(- 2062, 50, - 10232),
                    ["Cake Island"] = CFrame.new(- 1897, 14, - 11576),
                    ["Candy Cane Island"] = CFrame.new(- 1038, 10, - 14076),
                    ["Tiki Outpost"] = CFrame.new(- 16224, 9, 439)
                }
                if _G.SelectIsland and v1572[_G.SelectIsland] then
                    topos(v1572[_G.SelectIsland])
                end
                if not _G.TeleportIsland then
                    return
                end
            end
        end)
    end
    StopTween(_G.TeleportIsland)
end)
v281.T:AddSection("Teleport Fast")
if World1 then
    Dropdown = v281.T:AddDropdown("Dropdown", {
        ["Title"] = "Select Island",
        ["Values"] = {
            "Sky Island 1",
            "Sky Island 2",
            "Under Water Island",
            "Under Water Island Entrace"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("")
    Dropdown:OnChanged(function(p1573)
        _G.SelectFast = p1573
    end)
end
if World2 then
    Dropdown = v281.T:AddDropdown("Dropdown", {
        ["Title"] = "Select Island",
        ["Values"] = {
            "Flamingo Mansion",
            "Flamingo Room",
            "Cursed Ship",
            "Zombie Island"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("")
    Dropdown:OnChanged(function(p1574)
        _G.SelectFast = p1574
    end)
end
if World3 then
    Dropdown = v281.T:AddDropdown("Dropdown", {
        ["Title"] = "Select Island",
        ["Values"] = {
            "Mansion",
            "Hydra Island",
            "Castle on the Sea",
            "Floating Turtle",
            "Beautiful Pirate"
        },
        ["Multi"] = false
    })
    Dropdown:SetValue("")
    Dropdown:OnChanged(function(p1575)
        _G.SelectFast = p1575
    end)
end
Toggle = v281.T:AddToggle("Toggle", {
    ["Title"] = "Teleport Fast",
    ["Default"] = false
})
Toggle:OnChanged(function(p1576)
    _G.TeleFast = p1576
    if _G.TeleFast ~= true then
		-- ::l3::
        return
    else
        while true do
            if true then
                wait()
                if _G.SelectFast ~= "Sky Island 1" then
                    if _G.SelectFast ~= "Sky Island 2" then
                        if _G.SelectFast ~= "Under Water Island" then
                            if _G.SelectFast ~= "Under Water Island Entrace" then
                                if _G.SelectFast ~= "Flamingo Mansion" then
                                    if _G.SelectFast ~= "Flamingo Room" then
                                        if _G.SelectFast ~= "Cursed Ship" then
                                            if _G.SelectFast ~= "Zombie Island" then
                                                if _G.SelectFast ~= "Mansion" then
                                                    if _G.SelectFast ~= "Hydra Island" then
                                                        if _G.SelectFast ~= "Castle on the Sea" then
                                                            if _G.SelectFast ~= "Floating Turtle" then
                                                                if _G.SelectFast == "Beautiful Pirate" then
                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5319, 23, - 93))
                                                                end
                                                            else
                                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 12001, 332, - 8861))
                                                            end
                                                        else
                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5092, 315, - 3130))
                                                        end
                                                    else
                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5662, 1013, - 335))
                                                    end
                                                else
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 12471, 374, - 7551))
                                                end
                                            else
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 6509, 83, - 133))
                                            end
                                        else
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923, 125, 32853))
                                        end
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2283, 15, 867))
                                    end
                                else
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 317, 331, 597))
                                end
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(3865, 5, - 1926))
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61164, 5, 1820))
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7895, 5547, - 380))
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4652, 873, - 1754))
                end
            end
            if not _G.TeleFast then
				-- goto l3
            end
        end
    end
end)
v281.S:AddSection("Abilities")
v281.S:AddButton({
    ["Title"] = "Buy Geppo [ 10,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Buso Haki [ 25,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Soru [ 25,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Observation Haki [ 750,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
    end
})
Toggle = v281.S:AddToggle("Toggle", {
    ["Title"] = "Auto Buy Abilities",
    ["Default"] = false
})
Toggle:OnChanged(function(p1577)
    Abilities = p1577
    while Abilities do
        wait(0.1)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
    end
end)
v281.S:AddSection("Fighting Style")
v281.S:AddButton({
    ["Title"] = "Buy Black Leg [ 150,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Electro [ 550,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Fishman Karate [ 750,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Dragon Claw [ 1,500 Fragments ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Superhuman [ 3,000,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Death Step [ 5,000 Fragments 5,000,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Sharkman Karate [ 5,000 Fragments 2,500,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Electric Claw [ 5,000 Fragments 3,000,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Dragon Talon [ 5,000 Fragments 3,000,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy God Human [ 5,000 Fragments 5,000,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Sanguine Art [ 5,000 Fragments $5,000,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
})
v281.S:AddSection("Sword")
v281.S:AddButton({
    ["Title"] = "Cutlass [ 1,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
    end
})
v281.S:AddButton({
    ["Title"] = "Katana [ 1,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")
    end
})
v281.S:AddButton({
    ["Title"] = "Iron Mace [ 25,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
    end
})
v281.S:AddButton({
    ["Title"] = "Dual Katana [ 12,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
    end
})
v281.S:AddButton({
    ["Title"] = "Triple Katana [ 60,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
    end
})
v281.S:AddButton({
    ["Title"] = "Pipe [ 100,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
    end
})
v281.S:AddButton({
    ["Title"] = "Dual-Headed Blade [ 400,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
    end
})
v281.S:AddButton({
    ["Title"] = "Bisento [ 1,200,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
    end
})
v281.S:AddButton({
    ["Title"] = "Soul Cane [ 750,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
    end
})
v281.S:AddButton({
    ["Title"] = "Pole v.2 [ 5,000 Fragments ]",
    ["Callback"] = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
    end
})
v281.S:AddSection("Gun")
v281.S:AddButton({
    ["Title"] = "Slingshot [ 5,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
    end
})
v281.S:AddButton({
    ["Title"] = "Musket [ 8,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Musket")
    end
})
v281.S:AddButton({
    ["Title"] = "Flintlock [ 10,500 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
    end
})
v281.S:AddButton({
    ["Title"] = "Refined Slingshot [ 30,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
    end
})
v281.S:AddButton({
    ["Title"] = "Refined Flintlock [ 65,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "BuyItem",
            "Refined Flintlock"
        }))
    end
})
v281.S:AddButton({
    ["Title"] = "Cannon [ 100,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
    end
})
v281.S:AddButton({
    ["Title"] = "Kabucha [ 1,500 Fragments ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
    end
})
v281.S:AddButton({
    ["Title"] = "Bizarre Rifle [ 250 Ectoplasm ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
    end
})
v281.S:AddSection("Stats")
v281.S:AddButton({
    ["Title"] = "Reset Stats (Use 2.5K Fragments)",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
    end
})
v281.S:AddButton({
    ["Title"] = "Random Race (Use 3K Fragments)",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
    end
})
v281.S:AddButton({
    ["Title"] = "Buy Cyborg (Use 2.5K Fragments)",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "CyborgTrainer",
            "Buy"
        }))
    end
})
v281.S:AddSection("Accessories")
v281.S:AddButton({
    ["Title"] = "Black Cape [ 50,000 Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "BuyItem",
            "Black Cape"
        }))
    end
})
v281.S:AddButton({
    ["Title"] = "Swordsman Hat [ 150k Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "BuyItem",
            "Swordsman Hat"
        }))
    end
})
v281.S:AddButton({
    ["Title"] = "Tomoe Ring [ 500k Beli ]",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "BuyItem",
            "Tomoe Ring"
        }))
    end
})
v281.D:AddSection("Sniper")
local v1578 = game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits")
Table_DevilFruitSniper = {}
ShopDevilSell = {}
local v1579 = next
local v1580 = nil
while true do
    local v1581
    v1580, v1581 = v1579(v1578, v1580)
    if v1580 == nil then
        break
    end
    table.insert(Table_DevilFruitSniper, v1581.Name)
    if v1581.OnSale then
        table.insert(ShopDevilSell, v1581.Name)
    end
end
Dropdown = v281.D:AddDropdown("Dropdown", {
    ["Title"] = "Select Fruits Sniper",
    ["Values"] = Table_DevilFruitSniper,
    ["Multi"] = false
})
Dropdown:SetValue("")
Dropdown:OnChanged(function(p1582)
    _G.SelectFruit = p1582
end)
Toggle = v281.D:AddToggle("Toggle", {
    ["Title"] = "Auto Buy Fruit Sniper",
    ["Default"] = false
})
Toggle:OnChanged(function(p1583)
    _G.BuyFruitSniper = p1583
end)
v281.D:AddSection("Others")
_G.SelectFruitEat = ""
Dropdown = v281.D:AddDropdown("Dropdown", {
    ["Title"] = "Select Fruits Eat",
    ["Values"] = Table_DevilFruitSniper,
    ["Multi"] = false
})
Dropdown:SetValue("")
Dropdown:OnChanged(function(p1584)
    _G.SelectFruitEat = p1584
end)
Toggle = v281.D:AddToggle("Toggle", {
    ["Title"] = "Auto Eat Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1585)
    _G.EatFruit = p1585
end)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.EatFruit then
                game:GetService("Players").LocalPlayer.Character:FindFirstChild(_G.SelectFruitEat).EatRemote:InvokeServer()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.BuyFruitSniper then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", "_G.SelectFruit", false)
            end
        end
    end)
end)
v281.D:AddButton({
    ["Title"] = "Random Fruit",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
    end
})
v281.D:AddButton({
    ["Title"] = "Open Devil Shop",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
        game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitShop.Visible = true
    end
})
local v1586 = v281.D:AddParagraph({
    ["Title"] = "Mirage Stock",
    ["Desc"] = ""
})
local v1587 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
function addCommas(p1588)
    local v1589 = tostring(p1588)
    repeat
        local v1590
        v1589, v1590 = v1589:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        k = v1590
    until k == 0
    return v1589
end
local v1591, v1592, v1593 = pairs(v1587)
local v1594 = {}
while true do
    local v1595
    v1593, v1595 = v1591(v1592, v1593)
    if v1593 == nil then
        break
    end
    if v1595.OnSale == true then
        local v1596 = addCommas(v1595.Price)
        local v1597 = v1595.Name .. " - $" .. v1596
        table.insert(v1594, v1597)
    end
end
v1586:SetDesc((table.concat(v1594, "\n")))
Toggle = v281.D:AddToggle("Toggle", {
    ["Title"] = "Auto Store Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1598)
    _G.StoreFruit = p1598
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.StoreFruit then
                local v1599, v1600, v1601 = pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())
                while true do
                    local v1602
                    v1601, v1602 = v1599(v1600, v1601)
                    if v1601 == nil then
                        break
                    end
                    if string.find(v1602.Name, "Fruit") then
                        local v1603 = v1602.Name
                        local v1604 = string.gsub(v1602.Name, " Fruit", "")
                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v1603) then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v1604 .. "-" .. v1604, game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v1603))
                        end
                    end
                end
            end
        end)
    end
end)
Toggle = v281.D:AddToggle("Toggle", {
    ["Title"] = "Bring to Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1605)
    _G.Grabfruit = p1605
end)
Toggle = v281.D:AddToggle("Toggle", {
    ["Title"] = "Tween to Fruit",
    ["Default"] = false
})
Toggle:OnChanged(function(p1606)
    _G.Tweenfruit = p1606
    StopTween(_G.Tweenfruit)
end)
spawn(function()
    while wait(0.1) do
        local v1607, v1608, v1609 = ipairs(game.Workspace:GetChildren())
        while true do
            local v1610
            v1609, v1610 = v1607(v1608, v1609)
            if v1609 == nil then
                break
            end
            if v1610:IsA("Tool") and v1610:FindFirstChild("Handle") then
                if _G.Grabfruit then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v1610.Handle.CFrame
                elseif _G.Tweenfruit then
                    topos(v1610.Handle.CFrame)
                end
            end
        end
    end
end)
v281.Mc:AddSection("Server")
v281.Mc:AddButton({
    ["Title"] = "Rejoin Server",
    ["Callback"] = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})
v281.Mc:AddButton({
    ["Title"] = "Server Hop",
    ["Callback"] = function()
        Hop()
    end
})
v281.Mc:AddButton({
    ["Title"] = "Hop To Lower Player",
    ["Callback"] = function()
        Hop()
    end
})
v281.Mc:AddButton({
    ["Title"] = "Copy Job Id",
    ["Callback"] = function()
        setclipboard(tostring(game.JobId))
    end
})
v281.Mc:AddInput("Input Job Id", {
    ["Title"] = "Input Job Id",
    ["Default"] = "",
    ["Placeholder"] = "Job ID",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Callback"] = function(p1611)
        _G.Job = p1611
    end
})
v281.Mc:AddButton({
    ["Title"] = "Join Sever",
    ["Callback"] = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer)
    end
})
v281.Mc:AddSection("Misc")
v281.Mc:AddButton({
    ["Title"] = "Title Name",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "getTitles"
        }))
        game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
    end
})
v281.Mc:AddButton({
    ["Title"] = "Color Haki",
    ["Callback"] = function()
        game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
    end
})
v281.Mc:AddSection("Teams")
v281.Mc:AddButton({
    ["Title"] = "Join Pirates Team",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
})
v281.Mc:AddButton({
    ["Title"] = "Join Marines Team",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
})
v281.Mc:AddSection("Codes")
local vu1612 = {
    "NOMOREHACK",
    "BANEXPLOIT",
    "WildDares",
    "BossBuild",
    "GetPranked",
    "EARN_FRUITS",
    "FIGHT4FRUIT",
    "NOEXPLOITER",
    "NOOB2ADMIN",
    "CODESLIDE",
    "ADMINHACKED",
    "ADMINDARES",
    "fruitconcepts",
    "krazydares",
    "TRIPLEABUSE",
    "SEATROLLING",
    "24NOADMIN",
    "REWARDFUN",
    "Chandler",
    "NEWTROLL",
    "KITT_RESET",
    "Sub2CaptainMaui",
    "kittgaming",
    "Sub2Fer999",
    "Enyu_is_Pro",
    "Magicbus",
    "JCWK",
    "Starcodeheo",
    "Bluxxy",
    "fudd10_v2",
    "SUB2GAMERROBOT_EXP1",
    "Sub2NoobMaster123",
    "Sub2UncleKizaru",
    "Sub2Daigrock",
    "Axiore",
    "TantaiGaming",
    "StrawHatMaine",
    "Sub2OfficialNoobie",
    "Fudd10",
    "Bignews",
    "TheGreatAce",
    "SECRET_ADMIN",
    "SUB2GAMERROBOT_RESET1",
    "SUB2OFFICIALNOOBIE",
    "AXIORE",
    "BIGNEWS",
    "BLUXXY",
    "CHANDLER",
    "ENYU_IS_PRO",
    "FUDD10",
    "FUDD10_V2",
    "KITTGAMING",
    "MAGICBUS",
    "STARCODEHEO",
    "STRAWHATMAINE",
    "SUB2CAPTAINMAUI",
    "SUB2DAIGROCK",
    "SUB2FER999",
    "SUB2NOOBMASTER123",
    "SUB2UNCLEKIZARU",
    "TANTAIGAMING",
    "THEGREATACE"
}
v281.Mc:AddButton({
    ["Title"] = "Redeem All Codes",
    ["Callback"] = function()
		-- upvalues: (ref) vu1612
        function RedeemCode(p1613)
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(p1613)
        end
        local v1614, v1615, v1616 = pairs(vu1612)
        while true do
            local v1617
            v1616, v1617 = v1614(v1615, v1616)
            if v1616 == nil then
                break
            end
            RedeemCode(v1617)
        end
    end
})
v281.Mc:AddSection("State")
Dropdown = v281.Mc:AddDropdown("Dropdown", {
    ["Title"] = "Select Haki State",
    ["Values"] = {
        "State 0",
        "State 1",
        "State 2",
        "State 3",
        "State 4",
        "State 5"
    },
    ["Multi"] = false
})
Dropdown:SetValue("")
Dropdown:OnChanged(function(p1618)
    _G.SelectStateHaki = p1618
end)
v281.Mc:AddButton({
    ["Title"] = "Change Buso Haki State",
    ["Callback"] = function()
        if _G.SelectStateHaki ~= "State 0" then
            if _G.SelectStateHaki ~= "State 1" then
                if _G.SelectStateHaki ~= "State 2" then
                    if _G.SelectStateHaki ~= "State 3" then
                        if _G.SelectStateHaki ~= "State 4" then
                            if _G.SelectStateHaki == "State 5" then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 5)
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 4)
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 3)
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 2)
                end
            else
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 1)
            end
        else
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 0)
        end
    end
})
game:GetService("Players")
game:GetService("StarterGui"):SetCore("SendNotification", {
    ["Title"] = "Bap Red",
    ["Text"] = "\196\144\195\163 t\225\186\163i xong",
    ["Icon"] = "rbxthumb://type=Asset&id=110905876048511&w=150&h=150",
    ["Duration"] = 10
})
