-- Aero Hub — Fixed Desync Version
-- Combines working desync logic with modern GUI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- // 0. HELPER FUNCTION //
local function new(class, props, parent)
    local obj = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            if k ~= "Parent" then obj[k] = v end
        end
        if props.Parent then obj.Parent = props.Parent end
    end
    if parent then obj.Parent = parent end
    return obj
end

-- // 1. SOUND SETUP //
local sounds = {
    click = Instance.new("Sound"),
    open = Instance.new("Sound"),
    hover = Instance.new("Sound")
}
sounds.click.SoundId = "rbxassetid://4590657391"
sounds.open.SoundId = "rbxassetid://6895079853"
sounds.hover.SoundId = "rbxassetid://6895079697"
for _, s in pairs(sounds) do
    s.Parent = SoundService
    s.Volume = 1
end

-- // 2. ADVANCED LOADING SCREEN //
local loadScreen = new("ScreenGui", {Name = "AeroLoading", IgnoreGuiInset = true, ResetOnSpawn = false}, playerGui)

-- Blur Effect
local blur = new("BlurEffect", {Size = 24, Name = "AeroBlur"}, Lighting)

-- Background
local bg = new("Frame", {Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(8,8,10), ZIndex = 10}, loadScreen)

-- Background Particles (Floating Motes)
task.spawn(function()
    for i = 1, 20 do
        local mote = new("Frame", {
            BackgroundColor3 = Color3.fromRGB(100,100,255),
            BackgroundTransparency = 0.8,
            Size = UDim2.new(0, math.random(2,6), 0, math.random(2,6)),
            Position = UDim2.new(math.random(), 0, 1.1, 0),
            Parent = bg,
            ZIndex = 10
        })
        new("UICorner", {CornerRadius = UDim.new(1,0)}, mote)
        
        local duration = math.random(3, 8)
        local targetPos = UDim2.new(mote.Position.X.Scale + (math.random()-0.5)*0.2, 0, -0.1, 0)
        
        TweenService:Create(mote, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Position = targetPos, BackgroundTransparency = 1}):Play()
        
        task.delay(duration, function() if mote then mote:Destroy() end end)
        wait(math.random(0.1, 0.5))
    end
end)

-- Main Logo Container
local centerFrame = new("Frame", {Size=UDim2.new(0,300,0,300), Position=UDim2.new(0.5,0,0.45,0), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1, ZIndex=11}, bg)

-- Spinning Ring
local spinner = new("ImageLabel", {
    Size = UDim2.new(1,0,1,0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(140,100,255),
    ImageTransparency = 0.2,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100,100,100,100),
    SliceScale = 1,
    ZIndex = 11
}, centerFrame)

-- Rotate the spinner
task.spawn(function()
    while loadScreen.Parent do
        spinner.Rotation = spinner.Rotation + 4
        RunService.RenderStepped:Wait()
    end
end)

-- Logo Text
local logo = new("TextLabel", {
    Text = "AERO HUB",
    Font = Enum.Font.GothamBlack,
    TextSize = 52,
    TextColor3 = Color3.fromRGB(255,255,255),
    Size = UDim2.new(1,0,1,0),
    BackgroundTransparency = 1,
    TextTransparency = 1,
    ZIndex = 12
}, centerFrame)

-- Loading Bar Background
local barBg = new("Frame", {
    Size = UDim2.new(0, 300, 0, 6),
    Position = UDim2.new(0.5, -150, 0.7, 0),
    BackgroundColor3 = Color3.fromRGB(25,25,30),
    BorderSizePixel = 0,
    ZIndex = 11
}, bg)
new("UICorner", {CornerRadius = UDim.new(1,0)}, barBg)

-- Loading Bar Fill
local barFill = new("Frame", {
    Name = "Fill",
    Size = UDim2.new(0,0,1,0),
    BackgroundColor3 = Color3.fromRGB(140,100,255),
    BorderSizePixel = 0,
    ZIndex = 12
}, barBg)
new("UICorner", {CornerRadius = UDim.new(1,0)}, barFill)

local barGrad = new("UIGradient", {
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80,140,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200,80,255))
    }
}, barFill)

-- Status Text
local status = new("TextLabel", {
    Text = "INITIALIZING",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(120,120,150),
    Size = UDim2.new(1,0,0,20),
    Position = UDim2.new(0,0,1.5,0),
    BackgroundTransparency = 1,
    TextTransparency = 0,
    ZIndex = 11
}, barBg)

-- Animations
wait(0.5)
TweenService:Create(logo, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
TweenService:Create(centerFrame, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0,280,0,280)}):Play()

-- Bar Progress Simulation
task.spawn(function()
    TweenService:Create(barFill, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1,0,1,0)}):Play()
end)

local statuses = {"Loading Code", "Activating Anti-Kick...", "Initializing Desync...", "Join Our Discord"}


for _, text in ipairs(statuses) do
    status.Text = text
    pcall(function() sounds.click:Play() end)
    wait(0.75)
end
status.Text = "READY"
wait(0.5)

-- Fade Out Sequence
local fadeInfo = TweenInfo.new(0.6)
TweenService:Create(bg, fadeInfo, {BackgroundTransparency = 1}):Play()
TweenService:Create(logo, fadeInfo, {TextTransparency = 1}):Play()
TweenService:Create(spinner, fadeInfo, {ImageTransparency = 1}):Play()
TweenService:Create(barBg, fadeInfo, {BackgroundTransparency = 1}):Play()
TweenService:Create(barFill, fadeInfo, {BackgroundTransparency = 1}):Play()
TweenService:Create(status, fadeInfo, {TextTransparency = 1}):Play()
TweenService:Create(blur, fadeInfo, {Size = 0}):Play()

wait(0.6)
loadScreen:Destroy()
blur:Destroy()

-- // 3. CONFIGURATION //
local CONFIG = {
    desyncEnabled = false,
    desyncOffset = Vector3.new(50, 0, 50), -- Offset for fake position
    fakePosition = Vector3.new(0, 0, 0),
    realPosition = Vector3.new(0, 0, 0),
    visualIndicator = nil
}

-- Create visual indicator (red sphere showing fake position)
local function createVisualIndicator()
    local part = Instance.new("Part")
    part.Name = "DesyncIndicator"
    part.Shape = Enum.PartType.Ball
    part.Size = Vector3.new(3, 3, 3)
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Material = Enum.Material.Neon
    part.CanCollide = false
    part.Anchored = true
    part.Transparency = 1
    part.Parent = workspace
    
    local light = Instance.new("PointLight")
    light.Brightness = 2
    light.Range = 20
    light.Color = Color3.fromRGB(255, 0, 0)
    light.Parent = part
    
    return part
end

CONFIG.visualIndicator = createVisualIndicator()

-- Apply FastFlags if supported
pcall(function()
    if setfflag then
        setfflag("DFFlagPlayerHumanoidPropertyUpdateRestrict", "False")
        setfflag("DFIntDebugDefaultTargetWorldStepsPerFrame", "-2147483648")
        setfflag("DFIntMaxMissedWorldStepsRemembered", "-2147483648")
        setfflag("DFIntWorldStepsOffsetAdjustRate", "2147483648")
        setfflag("DFIntDebugSendDistInSteps", "-2147483648")
        setfflag("DFIntWorldStepMax", "-2147483648")
        setfflag("DFIntWarpFactor", "2147483648")
    end
end)


-- // 4. GUI SETUP //
local screenGui = new("ScreenGui", {Name = "AeroHubUI", ResetOnSpawn=false, IgnoreGuiInset=true}, playerGui)

local panel = new("Frame", {Name="Panel", Size=UDim2.new(0,460,0,260), Position=UDim2.new(0.5,-230,0.5,-130), BackgroundColor3=Color3.fromRGB(18,18,22), BorderSizePixel=0, Visible=false}, screenGui)
new("UICorner",{CornerRadius=UDim.new(0,16)}, panel)

-- TopBar
local top = new("Frame", {Name="TopBar", Size=UDim2.new(1,0,0,44), Position=UDim2.new(0,0,0,0), BackgroundColor3=Color3.fromRGB(24,24,30), BorderSizePixel=0}, panel)
new("UICorner",{CornerRadius=UDim.new(0,12)}, top)

local title = new("TextLabel", {Name="Title", Size=UDim2.new(1,-120,1,0), Position=UDim2.new(0,12,0,0), BackgroundTransparency=1, Text="Aero Hub", Font=Enum.Font.GothamBold, TextScaled=true, TextColor3=Color3.fromRGB(200,160,255), TextXAlignment=Enum.TextXAlignment.Left}, top)

-- Close/Minimize Buttons
local minBtn = new("TextButton", {Name="Minimize", Size=UDim2.new(0,34,0,34), Position=UDim2.new(1,-86,0.5,-17), BackgroundColor3=Color3.fromRGB(255,200,80), BorderSizePixel=0, Text="-", Font=Enum.Font.GothamBlack, TextSize=24, TextColor3=Color3.fromRGB(40,40,40)}, top)
new("UICorner",{CornerRadius=UDim.new(0,8)}, minBtn)

local closeBtn = new("TextButton", {Name="Close", Size=UDim2.new(0,34,0,34), Position=UDim2.new(1,-44,0.5,-17), BackgroundColor3=Color3.fromRGB(255,90,90), BorderSizePixel=0, Text="X", Font=Enum.Font.GothamBlack, TextSize=18, TextColor3=Color3.fromRGB(40,10,10)}, top)
new("UICorner",{CornerRadius=UDim.new(0,8)}, closeBtn)

-- Content
local content = new("Frame", {Name="Content", Size=UDim2.new(1,0,1,-54), Position=UDim2.new(0,0,0,50), BackgroundTransparency=1}, panel)

local label = new("TextLabel", {Name="FeatureLabel", Size=UDim2.new(0.68,0,0,36), Position=UDim2.new(0,16,0,6), BackgroundTransparency=1, Text="Desync Visualizer", Font=Enum.Font.GothamBold, TextScaled=true, TextColor3=Color3.fromRGB(255,255,255), TextXAlignment=Enum.TextXAlignment.Left}, content)

local subLabel = new("TextLabel", {Name="SubLabel", Size=UDim2.new(0.9,0,0,60), Position=UDim2.new(0,16,0,44), BackgroundTransparency=1, Text="Toggle to activate desync.\nRed sphere shows fake position.", Font=Enum.Font.Gotham, TextSize=13, TextColor3=Color3.fromRGB(170,170,190), TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top, TextWrapped=true}, content)

local guiElements = {posLabel=subLabel}

-- Toggle
local toggleFrame = new("Frame", {Name="ToggleFrame", Size=UDim2.new(0,120,0,50), Position=UDim2.new(1,-140,0,6), BackgroundColor3=Color3.fromRGB(48,48,64), BorderSizePixel=0}, content)
new("UICorner",{CornerRadius=UDim.new(0,50)}, toggleFrame)

local knob = new("Frame", {Name="Knob", Size=UDim2.new(0,44,0,44), Position=UDim2.new(0,6,0,3), BackgroundColor3=Color3.fromRGB(250,250,250), BorderSizePixel=0}, toggleFrame)
new("UICorner",{CornerRadius=UDim.new(1,0)}, knob)

local symbol = new("TextLabel", {Name="Symbol", Size=UDim2.new(1,0,1,-2), Position=UDim2.new(0,0,0,1), BackgroundTransparency=1, Text="X", Font=Enum.Font.GothamBlack, TextSize=26, TextColor3=Color3.fromRGB(255,255,255)}, knob)

local isOn = false
local rolling = false
local toggleOnColor = Color3.fromRGB(80,200,80)
local toggleOffColor = Color3.fromRGB(48,48,64)

local function toggle()
    if rolling then return end
    rolling = true
    isOn = not isOn
    pcall(function() sounds.click:Play() end)
    
    local targetPos = isOn and UDim2.new(1,-50,0,3) or UDim2.new(0,6,0,3)
    TweenService:Create(knob, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position=targetPos}):Play()
    toggleFrame.BackgroundColor3 = isOn and toggleOnColor or toggleOffColor
    symbol.Text = isOn and "✓" or "X"
    symbol.TextSize = isOn and 32 or 26
    
    CONFIG.desyncEnabled = isOn
    
    if isOn then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            CONFIG.realPosition = char.HumanoidRootPart.Position
            CONFIG.fakePosition = CONFIG.realPosition + CONFIG.desyncOffset
            CONFIG.visualIndicator.Position = CONFIG.fakePosition
            CONFIG.visualIndicator.Transparency = 0.5
        end
    else
        CONFIG.visualIndicator.Transparency = 1
        guiElements.posLabel.Text = "Desync disabled."
    end
    
    rolling = false
end

toggleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
end)

knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
end)

-- PFP Ring & Image
local pfpSize = 72
local pfpOuter = new("Frame", {Size=UDim2.new(0,pfpSize+16,0,pfpSize+16), Position=UDim2.new(0,12,1,-pfpSize-12), BackgroundTransparency=1}, panel)

local ringBacking = new("Frame", {Size=UDim2.new(0,pfpSize+6,0,pfpSize+6), Position=UDim2.new(0.5,0,0.5,0), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=Color3.fromRGB(255,255,255), BorderSizePixel=0}, pfpOuter)
new("UICorner",{CornerRadius=UDim.new(1,0)}, ringBacking)

local ringGradient = new("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,110)), ColorSequenceKeypoint.new(0.25,Color3.fromRGB(255,150,0)), ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,230,0)), ColorSequenceKeypoint.new(0.75,Color3.fromRGB(0,200,255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(180,0,255))}, Rotation=0}, ringBacking)

local pfpHolder = new("Frame", {Size=UDim2.new(0,pfpSize,0,pfpSize), Position=UDim2.new(0.5,0,0.5,0), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=Color3.fromRGB(18,18,22), BorderSizePixel=0, ZIndex=2}, pfpOuter)
new("UICorner",{CornerRadius=UDim.new(1,0)}, pfpHolder)

local pfp = new("ImageLabel", {Size=UDim2.new(1,-4,1,-4), Position=UDim2.new(0.5,0,0.5,0), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1, Image="", ScaleType=Enum.ScaleType.Crop, ZIndex=2}, pfpHolder)
new("UICorner",{CornerRadius=UDim.new(1,0)}, pfp)

task.spawn(function()
    local success, thumb = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    if success and thumb then pfp.Image = thumb end
end)

local ringRotation = 0
RunService.RenderStepped:Connect(function(dt)
    ringRotation = (ringRotation + dt * 60) % 360
    ringGradient.Rotation = ringRotation
end)

-- Dragging
local dragging = false
local dragStartPos = Vector2.new()
local panelStart = panel.Position
local targetPos = panel.Position

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        panelStart = panel.Position
        targetPos = panelStart
    end
end)

top.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        targetPos = UDim2.new(panelStart.X.Scale, panelStart.X.Offset+delta.X, panelStart.Y.Scale, panelStart.Y.Offset+delta.Y)
    end
end)

RunService.RenderStepped:Connect(function(dt)
    local cur = panel.Position
    local alpha = math.clamp(dt*25,0,1)*0.5
    panel.Position = UDim2.new(cur.X.Scale, cur.X.Offset+(targetPos.X.Offset-cur.X.Offset)*alpha, cur.Y.Scale, cur.Y.Offset+(targetPos.Y.Offset-cur.Y.Offset)*alpha)
end)

-- Rainbow label
local hue=0
RunService.RenderStepped:Connect(function(dt)
    hue = (hue + dt*0.2) % 1
    label.TextColor3 = Color3.fromHSV(hue,0.8,1)
end)

-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
    pcall(function() sounds.click:Play() end)
    
    -- Smooth close animation
    local closeTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    
    -- Scale down and fade out
    TweenService:Create(panel, closeTweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    
    -- Fade out children
    for _, child in pairs(panel:GetDescendants()) do
        if child:IsA("GuiObject") then
            TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            if child:IsA("TextLabel") or child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            elseif child:IsA("ImageLabel") then
                TweenService:Create(child, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            end
        end
    end

    wait(0.5)
    screenGui:Destroy()
end)

-- Minimize button functionality
local minimized = false
local originalSize = UDim2.new(0, 460, 0, 260)
local minimizedSize = UDim2.new(0, 460, 0, 44) -- Top bar height

minBtn.MouseButton1Click:Connect(function()
    pcall(function() sounds.click:Play() end)
    minimized = not minimized
    
    local targetSize = minimized and minimizedSize or originalSize
    local targetContentTransparency = minimized and 1 or 0
    
    -- Animate Panel Size
    TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = targetSize}):Play()
    
    -- Fade Content
    TweenService:Create(content, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play() -- Content frame is always transparent
    
    for _, child in pairs(content:GetDescendants()) do
        if child:IsA("GuiObject") then
             -- If minimizing, fade out immediately. If maximizing, wait a bit then fade in.
            if minimized then
                TweenService:Create(child, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    TweenService:Create(child, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
                elseif child:IsA("ImageLabel") then
                    TweenService:Create(child, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
                end
            else
                task.delay(0.1, function()
                    TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = child.Name == "Knob" and 0 or 1}):Play() -- Handle specific transparencies if needed, but here we just reset. 
                    -- Actually, we need to restore original transparencies.
                    -- Since we removed the complex toggle UI, we just have labels and PFP.
                    -- Labels are BackgroundTransparency=1.
                    if child:IsA("TextLabel") then
                         TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                    elseif child:IsA("ImageLabel") then
                         TweenService:Create(child, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
                    end
                end)
            end
        end
    end
    
    -- Also hide PFP when minimized
    if minimized then
         TweenService:Create(pfpOuter, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
         for _, v in pairs(pfpOuter:GetDescendants()) do
            if v:IsA("GuiObject") then
                 TweenService:Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                 if v:IsA("ImageLabel") then TweenService:Create(v, TweenInfo.new(0.2), {ImageTransparency = 1}):Play() end
            end
         end
    else
         task.delay(0.1, function()
             -- Restore PFP
             -- Note: pfpOuter is BackgroundTransparency=1 originally.
             -- ringBacking is visible.
             TweenService:Create(ringBacking, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
             TweenService:Create(pfpHolder, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
             TweenService:Create(pfp, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
         end)
    end
end)


-- // 5. MAIN DESYNC LOOP //
RunService.RenderStepped:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hrp then return end
    
    CONFIG.realPosition = hrp.Position
    
    if CONFIG.desyncEnabled then
        -- Update fake position with offset
        CONFIG.fakePosition = CONFIG.realPosition + CONFIG.desyncOffset
        
        -- Update visual indicator
        if CONFIG.visualIndicator then
            CONFIG.visualIndicator.Position = CONFIG.fakePosition + Vector3.new(0, 1.5, 0)
        end
        
        -- Update position display
        local realStr = string.format("(%.1f, %.1f, %.1f)", CONFIG.realPosition.X, CONFIG.realPosition.Y, CONFIG.realPosition.Z)
        local fakeStr = string.format("(%.1f, %.1f, %.1f)", CONFIG.fakePosition.X, CONFIG.fakePosition.Y, CONFIG.fakePosition.Z)
        guiElements.posLabel.Text = "Real: " .. realStr .. "\nFake: " .. fakeStr
    end
end)


-- Show Panel
panel.Visible = true
panel.Size = UDim2.new(0,0,0,0)
TweenService:Create(panel, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size=UDim2.new(0,460,0,260)}):Play()
pcall(function() sounds.open:Play() end)

print("✓ Aero Hub: Desync Ready")
print("✓ Red sphere shows your fake position")
print("✓ Toggle to activate desync visualization")

