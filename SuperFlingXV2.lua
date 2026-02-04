-- SuperFlingX - Dark Pro Edition 2026 (with Sadie’s Working.lua flight + Farm Kill restored)
-- Walk starts 25 • fly starts 80 • max 2000 • W forward S backward A left D right Q toggle fly
-- Vertical fly: Space up, LeftControl down (removed Q/E vertical)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

if game.CoreGui:FindFirstChild("SuperFling") then
    game.CoreGui.SuperFling:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "SuperFling"
sg.Parent = game.CoreGui
sg.ResetOnSpawn = false

-- Dark Pro theme
local theme = {
    bg_main       = Color3.fromRGB(18, 18, 22),
    bg_sidebar    = Color3.fromRGB(24, 24, 30),
    bg_content    = Color3.fromRGB(20, 20, 25),
    accent_pink   = Color3.fromRGB(180, 70, 255),
    accent_mint   = Color3.fromRGB(0, 220, 180),
    accent_red    = Color3.fromRGB(255, 80, 100),
    accent_lav    = Color3.fromRGB(140, 100, 255),
    accent_yellow = Color3.fromRGB(255, 210, 80),
    text_dark     = Color3.fromRGB(235, 235, 245),
    text_light    = Color3.fromRGB(160, 160, 190),
    border_soft   = Color3.fromRGB(60, 60, 80),
    hover         = Color3.fromRGB(40, 40, 55),
    slider_bg     = Color3.fromRGB(35, 35, 45),
    switch_on     = Color3.fromRGB(0, 220, 180),
    switch_off    = Color3.fromRGB(255, 80, 100),
    player_unsel  = Color3.fromRGB(32, 32, 42),
    player_sel    = Color3.fromRGB(90, 60, 160),
    player_sel_hover = Color3.fromRGB(110, 80, 180),
    tab_active    = Color3.fromRGB(45, 45, 65),
    tab_inactive  = Color3.fromRGB(28, 28, 38),
}

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 620, 0, 520)
main.Position = UDim2.new(0.5, -310, 0.5, -260)
main.BackgroundColor3 = theme.bg_main
main.BorderSizePixel = 0
main.Parent = sg

local uc_main = Instance.new("UICorner")
uc_main.CornerRadius = UDim.new(0, 24)
uc_main.Parent = main

local glowStroke = Instance.new("UIStroke")
glowStroke.Color = theme.border_soft
glowStroke.Thickness = 2.5
glowStroke.Transparency = 0.25
glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glowStroke.Parent = main

local outerGlow = Instance.new("UIStroke")
outerGlow.Color = theme.accent_mint
outerGlow.Thickness = 5
outerGlow.Transparency = 0.5
outerGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outerGlow.Parent = main

local pulseInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(glowStroke, pulseInfo, {Transparency = 0.05}):Play()
TweenService:Create(outerGlow, pulseInfo, {Transparency = 0.3}):Play()

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.BackgroundColor3 = theme.bg_sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local uc_sidebar = Instance.new("UICorner")
uc_sidebar.CornerRadius = UDim.new(0, 24)
uc_sidebar.Parent = sidebar

local sidebarList = Instance.new("UIListLayout")
sidebarList.Padding = UDim.new(0, 10)
sidebarList.SortOrder = Enum.SortOrder.LayoutOrder
sidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sidebarList.VerticalAlignment = Enum.VerticalAlignment.Top
sidebarList.Parent = sidebar

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 60)
sidebarPadding.Parent = sidebar

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -160, 1, 0)
content.Position = UDim2.new(0, 160, 0, 0)
content.BackgroundColor3 = theme.bg_content
content.BorderSizePixel = 0
content.Parent = main

local uc_content = Instance.new("UICorner")
uc_content.CornerRadius = UDim.new(0, 24)
uc_content.Parent = content

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = theme.bg_main
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local uc_title = Instance.new("UICorner")
uc_title.CornerRadius = UDim.new(0, 24)
uc_title.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 170, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SUPER FLING X"
title.TextColor3 = theme.accent_pink
title.TextSize = 26
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -110, 0, 22)
subtitle.Position = UDim2.new(0, 170, 0, 28)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Dark Pro Edition • 2026"
subtitle.TextColor3 = theme.text_light
subtitle.TextSize = 15
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 45, 0, 45)
closeBtn.Position = UDim2.new(1, -55, 0.5, -22.5)
closeBtn.BackgroundColor3 = theme.accent_red
closeBtn.BackgroundTransparency = 0.15
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 30
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 12)
closeCorner.Parent = closeBtn

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    if spawnMarker then spawnMarker:Destroy() end
    sg:Destroy()
end)

-- Dragging
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Tab system
local tabs = {}
local contentFrames = {}
local currentTab = nil

local function createTab(name, color)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -30, 0, 45)
    tabBtn.BackgroundColor3 = theme.tab_inactive
    tabBtn.BackgroundTransparency = 0.05
    tabBtn.Text = name
    tabBtn.TextColor3 = theme.text_dark
    tabBtn.TextSize = 18
    tabBtn.Font = Enum.Font.GothamSemibold
    tabBtn.AutoButtonColor = false
    tabBtn.Parent = sidebar

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 14)
    tabCorner.Parent = tabBtn

    local tabStroke = Instance.new("UIStroke")
    tabStroke.Color = color
    tabStroke.Thickness = 2
    tabStroke.Transparency = 0.3
    tabStroke.Parent = tabBtn

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 5
    contentFrame.ScrollBarImageColor3 = theme.accent_pink
    contentFrame.Visible = false
    contentFrame.Parent = content

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 15)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    contentLayout.Parent = contentFrame

    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 60)
    contentPadding.PaddingBottom = UDim.new(0, 25)
    contentPadding.PaddingLeft = UDim.new(0, 25)
    contentPadding.PaddingRight = UDim.new(0, 25)
    contentPadding.Parent = contentFrame

    tabs[name] = tabBtn
    contentFrames[name] = contentFrame

    tabBtn.MouseEnter:Connect(function()
        TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = theme.hover, BackgroundTransparency = 0}):Play()
    end)
    tabBtn.MouseLeave:Connect(function()
        if currentTab ~= name then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = theme.tab_inactive, BackgroundTransparency = 0.05}):Play()
        end
    end)

    tabBtn.MouseButton1Click:Connect(function()
        if currentTab then
            contentFrames[currentTab].Visible = false
            TweenService:Create(tabs[currentTab], TweenInfo.new(0.15), {BackgroundColor3 = theme.tab_inactive, BackgroundTransparency = 0.05}):Play()
        end
        currentTab = name
        contentFrames[name].Visible = true
        TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = theme.tab_active, BackgroundTransparency = 0}):Play()
    end)

    return contentFrame
end

-- Create tabs
local homeTab    = createTab("Home",    theme.accent_yellow)
local gameTab    = createTab("Game",    theme.accent_mint)
local playerTab  = createTab("Player",  theme.accent_lav)
local autoTab    = createTab("Auto",    theme.accent_pink)
local flingTab   = createTab("Fling",   theme.accent_mint)
local opTab      = createTab("OP",      theme.accent_lav)
local funnyTab   = createTab("Funny",   theme.accent_yellow)

-- Home content
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 220)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Welcome to Super Fling X!\n\nThank you for using our pro edition.\nHave fun flinging, flying, and farming!\nCrafted by SadieSin in 2026."
welcomeLabel.TextColor3 = theme.text_dark
welcomeLabel.TextSize = 20
welcomeLabel.Font = Enum.Font.Gotham
welcomeLabel.TextWrapped = true
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
welcomeLabel.Parent = homeTab

-- Game tab placeholder
local gameLabel = Instance.new("TextLabel")
gameLabel.Size = UDim2.new(1, 0, 0, 55)
gameLabel.BackgroundTransparency = 1
gameLabel.Text = "More features soon!"
gameLabel.TextColor3 = theme.text_light
gameLabel.TextSize = 18
gameLabel.Font = Enum.Font.Gotham
gameLabel.Parent = gameTab

-- ────────────────────────────────────────────────
-- Shared variables
-- ────────────────────────────────────────────────

local selectedPlayers = {}
local flinging = false
local farmkilling = false
local noclipping = false
local distanceLabelsEnabled = false
local infJumping = false
local clickFlingEnabled = false
local touchFlingEnabled = false

local mainLoop = nil           -- super fling
local cycleTimer = nil
local farmKillLoop = nil
local farmKillCycle = nil
local savedPosition = nil

local espConnections = {}
local distanceConnections = {}
local originalCollisions = {}
local playerButtons = {}
local clickConn = nil
local touchLoop = nil
local flingCooldowns = {}

local activeFling = false
local flingTarget = nil
local flingStartCFrame = nil
local flingConn = nil
local espRefreshConnection = nil

local spawnPoint = nil
local spawnMarker = nil

local flySpeed = 80
local walkSpeed = 25
local FLYING = false
local flyLoop = nil
local flyCleanup = nil
local noclipFlyConnection = nil

-- Walkspeed enforcer
local walkspeedEnforcer = nil
local function enforceWalkSpeed()
    if walkspeedEnforcer then walkspeedEnforcer:Disconnect() end
    walkspeedEnforcer = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= walkSpeed then
            hum.WalkSpeed = walkSpeed
        end
    end)
end

local function createSpawnMarker(position)
    if spawnMarker and spawnMarker.Parent then spawnMarker:Destroy() end

    spawnMarker = Instance.new("Part")
    spawnMarker.Name = "SadieSpawnMarker"
    spawnMarker.Shape = Enum.PartType.Ball
    spawnMarker.Size = Vector3.new(2.5, 2.5, 2.5)
    spawnMarker.Position = position
    spawnMarker.Anchored = true
    spawnMarker.CanCollide = false
    spawnMarker.Material = Enum.Material.Neon
    spawnMarker.Color = theme.accent_pink
    spawnMarker.Transparency = 0.4
    spawnMarker.Parent = workspace

    local light = Instance.new("PointLight")
    light.Color = theme.accent_pink
    light.Brightness = 4
    light.Range = 14
    light.Parent = spawnMarker

    local pulse = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    TweenService:Create(spawnMarker, pulse, {Transparency = 0.6}):Play()
    TweenService:Create(light, pulse, {Brightness = 1.8}):Play()
end

local function setSpawnPoint()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    spawnPoint = char.HumanoidRootPart.CFrame
    createSpawnMarker(spawnPoint.Position)
end

local function teleportToSpawnPoint()
    if not spawnPoint then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- Stop conflicting modes
    if flinging then flinging = false if mainLoop then mainLoop:Disconnect() end if cycleTimer then task.cancel(cycleTimer) end end
    if farmkilling then farmkilling = false if farmKillLoop then farmKillLoop:Disconnect() end if farmKillCycle then task.cancel(farmKillCycle) end end
    if FLYING then FLYING = false if noclipFlyConnection then noclipFlyConnection:Disconnect() end if flyLoop then flyLoop:Disconnect() flyLoop = nil end if flyCleanup then flyCleanup() flyCleanup = nil end if char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end end
    if touchFlingEnabled then touchFlingEnabled = false if touchLoop then touchLoop:Disconnect() end end
    if clickFlingEnabled then clickFlingEnabled = false if clickConn then clickConn:Disconnect() end end

    char.HumanoidRootPart.CFrame = spawnPoint
end

-- ────────────────────────────────────────────────
-- Attach Fling (used by touch & click fling)
-- ────────────────────────────────────────────────

local function startAttachFling(target, startCFrame)
    if activeFling then return end
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    pcall(function() root:SetNetworkOwner(LocalPlayer) end)

    activeFling = true
    flingTarget = target
    flingStartCFrame = startCFrame

    flingConn = RunService.Heartbeat:Connect(function()
        if not activeFling then return end
        local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then activeFling = false return end
        local offset = Vector3.new(math.random(-1.2,1.2), math.random(-0.4,1.6), math.random(-1.2,1.2))
        local targetVel = targetRoot.AssemblyLinearVelocity
        if targetVel.Magnitude > 5 then
            offset = offset + targetVel.Unit * 1.8
        end
        root.CFrame = targetRoot.CFrame * CFrame.new(offset)
        root.AssemblyAngularVelocity = Vector3.new(18000 + math.random(-4000,4000), 18000 + math.random(-4000,4000), 18000 + math.random(-4000,4000))
        root.AssemblyLinearVelocity = Vector3.new(math.random(-220,220), math.random(-120,350), math.random(-220,220))
    end)

    task.delay(3, function()
        activeFling = false
        if flingConn then flingConn:Disconnect() end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        if flingStartCFrame then root.CFrame = flingStartCFrame end
        flingTarget = nil
        flingStartCFrame = nil
    end)
end

-- ────────────────────────────────────────────────
-- Super Fling
-- ────────────────────────────────────────────────

local function startSuperFling()
    if #selectedPlayers == 0 then return end
    if farmkilling then farmkilling = false if farmKillLoop then farmKillLoop:Disconnect() end if farmKillCycle then task.cancel(farmKillCycle) end end

    flinging = true
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    savedPosition = root.CFrame
    pcall(function() root:SetNetworkOwner(LocalPlayer) end)
    local currentIndex = 1
    mainLoop = RunService.Heartbeat:Connect(function()
        if not flinging or not root or not root.Parent then return end
        local target = selectedPlayers[currentIndex]
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = target.Character.HumanoidRootPart
            local offset = Vector3.new(math.random(-1,1), math.random(-0.5,1.5), math.random(-1,1))
            local targetVel = targetRoot.AssemblyLinearVelocity
            if targetVel.Magnitude > 5 then
                offset = offset + targetVel.Unit * 1.5
            end
            root.CFrame = targetRoot.CFrame * CFrame.new(offset)
        end
        root.AssemblyAngularVelocity = Vector3.new(15000 + math.random(-3000,3000), 15000 + math.random(-3000,3000), 15000 + math.random(-3000,3000))
        local burst = Vector3.new(math.random(-200,200), math.random(-100,300), math.random(-200,200))
        root.AssemblyLinearVelocity = burst
    end)
    local function cycle()
        if not flinging then return end
        currentIndex = currentIndex + 1
        if currentIndex > #selectedPlayers then currentIndex = 1 end
        cycleTimer = task.delay(2, cycle)
    end
    cycle()
end

local function stopSuperFling()
    flinging = false
    if mainLoop then mainLoop:Disconnect() mainLoop = nil end
    if cycleTimer then task.cancel(cycleTimer) cycleTimer = nil end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        if savedPosition then root.CFrame = savedPosition end
    end
end

-- ────────────────────────────────────────────────
-- Farm Kill
-- ────────────────────────────────────────────────

local function startFarmKill()
    if #selectedPlayers == 0 then return end
    if flinging then flinging = false if mainLoop then mainLoop:Disconnect() end if cycleTimer then task.cancel(cycleTimer) end end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    savedPosition = root.CFrame
    pcall(function() root:SetNetworkOwner(LocalPlayer) end)

    farmkilling = true
    local currentIndex = 1

    farmKillLoop = RunService.Heartbeat:Connect(function()
        if not farmkilling or not root or not root.Parent then return end

        local target = selectedPlayers[currentIndex]
        if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
            currentIndex = (currentIndex % #selectedPlayers) + 1
            return
        end

        local tRoot = target.Character.HumanoidRootPart

        local direction = (tRoot.Position - root.Position).Unit
        local lookCFrame = CFrame.new(Vector3.new(), direction)
        root.CFrame = CFrame.new(tRoot.Position.X, tRoot.Position.Y - 3, tRoot.Position.Z) * lookCFrame

        VirtualInputManager:SendKeyEvent(true,  Enum.KeyCode.One,   false, game) task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One,   false, game)
        VirtualInputManager:SendKeyEvent(true,  Enum.KeyCode.Two,   false, game) task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two,   false, game)
        VirtualInputManager:SendKeyEvent(true,  Enum.KeyCode.Three, false, game) task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Three, false, game)
        VirtualInputManager:SendKeyEvent(true,  Enum.KeyCode.Four,  false, game) task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Four,  false, game)
    end)

    farmKillCycle = task.spawn(function()
        while farmkilling do
            currentIndex = (currentIndex % #selectedPlayers) + 1
            task.wait(3)
        end
    end)
end

local function stopFarmKill()
    farmkilling = false
    if farmKillLoop then farmKillLoop:Disconnect() farmKillLoop = nil end
    if farmKillCycle then task.cancel(farmKillCycle) farmKillCycle = nil end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and savedPosition then
        LocalPlayer.Character.HumanoidRootPart.CFrame = savedPosition
    end
end

-- ────────────────────────────────────────────────
-- Other features
-- ────────────────────────────────────────────────

local function toggleNoclip(active)
    noclipping = active
    local char = LocalPlayer.Character
    if not char then return end
    if noclipping then
        originalCollisions = {}
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                originalCollisions[part] = true
                part.CanCollide = false
            end
        end
        local loop = RunService.Stepped:Connect(function()
            if not noclipping then loop:Disconnect() return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
        table.insert(espConnections, loop)
    else
        for part, was in pairs(originalCollisions) do
            if part and part.Parent then part.CanCollide = was end
        end
        originalCollisions = {}
    end
end

local function toggleInfJump(active)
    infJumping = active
    if infJumping then
        local conn = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local h = char:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
        table.insert(espConnections, conn)
    end
end

local function applyESPToPlayer(player)
    if player == LocalPlayer then return end
    if not player.Character then return end

    local char = player.Character
    if not char:FindFirstChild("Head") or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChildOfClass("Humanoid") then return end

    if char:FindFirstChild("SadieESP") then char.SadieESP:Destroy() end
    if char.Head:FindFirstChild("SadieBillboard") then char.Head.SadieBillboard:Destroy() end

    local highlight = Instance.new("Highlight")
    highlight.Name = "SadieESP"
    highlight.FillTransparency = 0.85
    highlight.OutlineColor = theme.accent_mint
    highlight.OutlineTransparency = 0.2
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = char

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "SadieBillboard"
    billboard.Adornee = char.Head
    billboard.Size = UDim2.new(0, 220, 0, 90)
    billboard.StudsOffset = Vector3.new(0, 5.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = char.Head

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Parent = billboard

    local uiList = Instance.new("UIListLayout")
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.Padding = UDim.new(0, 2)
    uiList.FillDirection = Enum.FillDirection.Vertical
    uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiList.VerticalAlignment = Enum.VerticalAlignment.Top
    uiList.Parent = container

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = theme.accent_lav
    nameLabel.TextStrokeTransparency = 0.4
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 13
    local display = player.DisplayName
    local username = player.Name
    nameLabel.Text = (display ~= username) and (display .. " @" .. username) or username
    nameLabel.Parent = container

    local hpFrame = Instance.new("Frame")
    hpFrame.Size = UDim2.new(0.75, 0, 0, 6)
    hpFrame.BackgroundColor3 = Color3.fromRGB(245, 230, 245)
    hpFrame.BorderSizePixel = 0
    hpFrame.Parent = container

    local hpCorner = Instance.new("UICorner")
    hpCorner.CornerRadius = UDim.new(0, 3)
    hpCorner.Parent = hpFrame

    local hpBar = Instance.new("Frame")
    hpBar.Name = "HPBar"
    hpBar.Size = UDim2.new(1, 0, 1, 0)
    hpBar.BackgroundColor3 = theme.accent_mint
    hpBar.BorderSizePixel = 0
    hpBar.Parent = hpFrame

    local hpBarCorner = Instance.new("UICorner")
    hpBarCorner.CornerRadius = UDim.new(0, 3)
    hpBarCorner.Parent = hpBar

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0, 20)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = theme.accent_mint
    distLabel.TextStrokeTransparency = 0.5
    distLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    distLabel.Font = Enum.Font.GothamSemibold
    distLabel.TextSize = 12
    distLabel.Text = "Calculating..."
    distLabel.Parent = container

    local conn = RunService.Heartbeat:Connect(function()
        if not distanceLabelsEnabled then
            billboard.Enabled = false
            return
        end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            billboard.Enabled = false
            return
        end

        local myRoot = LocalPlayer.Character.HumanoidRootPart
        local targetRoot = char:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            billboard.Enabled = false
            return
        end

        local dist = (myRoot.Position - targetRoot.Position).Magnitude
        distLabel.Text = string.format("%.1f studs", dist)

        local hpPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
        hpBar.Size = UDim2.new(hpPercent, 0, 1, 0)

        local hue = 0.45 + (hpPercent * 0.15)
        hpBar.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 1)

        billboard.Enabled = true
    end)

    table.insert(distanceConnections, conn)

    local removeConn = char.AncestryChanged:Connect(function()
        if not char.Parent then
            pcall(function()
                highlight:Destroy()
                billboard:Destroy()
                conn:Disconnect()
            end)
        end
    end)
    table.insert(espConnections, removeConn)
end

local function refreshAllESP()
    if not distanceLabelsEnabled then return end
    for _, player in ipairs(Players:GetPlayers()) do
        task.spawn(function() pcall(applyESPToPlayer, player) end)
    end
end

local function removeAllESPAndLabels()
    for _, conn in ipairs(espConnections) do pcall(function() conn:Disconnect() end) end
    for _, conn in ipairs(distanceConnections) do pcall(function() conn:Disconnect() end) end
    espConnections = {}
    distanceConnections = {}
    for _, p in Players:GetPlayers() do
        if p.Character then
            if p.Character:FindFirstChild("SadieESP") then p.Character.SadieESP:Destroy() end
            if p.Character.Head and p.Character.Head:FindFirstChild("SadieBillboard") then
                p.Character.Head.SadieBillboard:Destroy()
            end
        end
    end
end

local function toggleESPAndDistance(active)
    distanceLabelsEnabled = active
    if distanceLabelsEnabled then
        refreshAllESP()
        if not espRefreshConnection then
            espRefreshConnection = task.spawn(function()
                while distanceLabelsEnabled and sg.Parent do
                    refreshAllESP()
                    task.wait(12)
                end
                espRefreshConnection = nil
            end)
        end
    else
        removeAllESPAndLabels()
        if espRefreshConnection then task.cancel(espRefreshConnection) espRefreshConnection = nil end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if distanceLabelsEnabled then
            task.wait(0.5)
            pcall(applyESPToPlayer, player)
        end
    end)
    if distanceLabelsEnabled then
        task.spawn(function()
            task.wait(1)
            pcall(applyESPToPlayer, player)
        end)
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            if distanceLabelsEnabled then
                task.wait(0.5)
                pcall(applyESPToPlayer, player)
            end
        end)
    end
end

-- ────────────────────────────────────────────────
-- Player list update function (only called when players change)
-- ────────────────────────────────────────────────

local function updateList(scrollFrame)
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    playerButtons = {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local displayName = p.DisplayName
            local username = p.Name
            local displayText = (displayName ~= username) and (displayName .. " @" .. username) or username

            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -20, 0, 40)
            b.BackgroundTransparency = 0.15
            b.Text = displayText
            b.TextColor3 = theme.text_dark
            b.TextSize = 14
            b.Font = Enum.Font.GothamSemibold
            b.AutoButtonColor = false
            b.Parent = scrollFrame

            local isSelected = table.find(selectedPlayers, p) ~= nil
            b.BackgroundColor3 = isSelected and theme.player_sel or theme.player_unsel
            b.BackgroundTransparency = isSelected and 0 or 0.15

            local bc = Instance.new("UICorner")
            bc.CornerRadius = UDim.new(0, 12)
            bc.Parent = b

            local stroke = Instance.new("UIStroke")
            stroke.Color = theme.border_soft
            stroke.Thickness = 1.5
            stroke.Transparency = 0.4
            stroke.Parent = b

            playerButtons[p] = b

            b.MouseEnter:Connect(function()
                local isSel = table.find(selectedPlayers, p) ~= nil
                TweenService:Create(b, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0,
                    BackgroundColor3 = isSel and theme.player_sel_hover or theme.hover
                }):Play()
            end)

            b.MouseLeave:Connect(function()
                local isSel = table.find(selectedPlayers, p) ~= nil
                TweenService:Create(b, TweenInfo.new(0.15), {
                    BackgroundTransparency = isSel and 0 or 0.15,
                    BackgroundColor3 = isSel and theme.player_sel or theme.player_unsel
                }):Play()
            end)

            b.MouseButton1Click:Connect(function()
                local index = table.find(selectedPlayers, p)
                if index then
                    table.remove(selectedPlayers, index)
                else
                    table.insert(selectedPlayers, p)
                end

                -- Update only this button
                local nowSelected = table.find(selectedPlayers, p) ~= nil
                TweenService:Create(b, TweenInfo.new(0.15), {
                    BackgroundColor3 = nowSelected and theme.player_sel or theme.player_unsel,
                    BackgroundTransparency = nowSelected and 0 or 0.15
                }):Play()
            end)
        end
    end
end

-- ────────────────────────────────────────────────
-- UI Creation Helpers
-- ────────────────────────────────────────────────

local function createFeatureContainer(parent, name, desc, height)
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, 0, 0, height)
    cont.BackgroundTransparency = 1
    cont.Parent = parent

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 25)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = theme.text_dark
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = cont

    local description = Instance.new("TextLabel")
    description.Size = UDim2.new(1, 0, 0, 35)
    description.Position = UDim2.new(0, 0, 0, 25)
    description.BackgroundColor3 = theme.bg_main
    description.BackgroundTransparency = 0.7
    description.Text = desc
    description.TextColor3 = theme.text_light
    description.TextSize = 13
    description.Font = Enum.Font.Gotham
    description.TextWrapped = true
    description.TextXAlignment = Enum.TextXAlignment.Left
    description.Parent = cont

    local descCorner = Instance.new("UICorner")
    descCorner.CornerRadius = UDim.new(0, 10)
    descCorner.Parent = description

    return cont
end

local function createToggle(parent, text, desc, onToggle)
    local cont = createFeatureContainer(parent, text, desc, 100)

    local switchFrame = Instance.new("Frame")
    switchFrame.Size = UDim2.new(0, 50, 0, 26)
    switchFrame.Position = UDim2.new(1, -55, 0, 5)
    switchFrame.BackgroundColor3 = theme.switch_off
    switchFrame.Parent = cont

    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switchFrame

    local switchHandle = Instance.new("Frame")
    switchHandle.Size = UDim2.new(0, 24, 0, 24)
    switchHandle.Position = UDim2.new(0, 1, 0.5, -12)
    switchHandle.BackgroundColor3 = Color3.new(1,1,1)
    switchHandle.Parent = switchFrame

    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(1, 0)
    handleCorner.Parent = switchHandle

    local switchStroke = Instance.new("UIStroke")
    switchStroke.Color = theme.border_soft
    switchStroke.Thickness = 1.5
    switchStroke.Transparency = 0.3
    switchStroke.Parent = switchFrame

    local active = false

    local function updateSwitch()
        TweenService:Create(switchFrame, TweenInfo.new(0.2), {BackgroundColor3 = active and theme.switch_on or theme.switch_off}):Play()
        TweenService:Create(switchHandle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = active and UDim2.new(0, 25, 0.5, -12) or UDim2.new(0, 1, 0.5, -12)}):Play()
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = switchFrame

    btn.MouseButton1Click:Connect(function()
        active = not active
        updateSwitch()
        onToggle(active)
    end)

    return function(newActive)
        active = newActive
        updateSwitch()
    end
end

local function createButton(parent, text, desc, onClick)
    local cont = createFeatureContainer(parent, text, desc, 100)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 0, 32)
    btn.Position = UDim2.new(1, -120, 0, 8)
    btn.BackgroundColor3 = theme.accent_pink
    btn.BackgroundTransparency = 0.1
    btn.Text = text
    btn.TextColor3 = theme.text_dark
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBlack
    btn.Parent = cont

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.border_soft
    stroke.Transparency = 0.3
    stroke.Thickness = 1.5
    stroke.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0, BackgroundColor3 = theme.hover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1, BackgroundColor3 = theme.accent_pink}):Play()
    end)

    btn.MouseButton1Click:Connect(onClick)
end

-- ────────────────────────────────────────────────
-- GODMODE (hookmetamethod + death disconnect + script disable)
-- ────────────────────────────────────────────────

local godmodeActive = false
local oldNamecall

local function enableGodmode()
    if godmodeActive then return end
    godmodeActive = true

    -- Hook :TakeDamage, :BreakJoints, Kill related calls
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if not checkcaller() then
            local method = getnamecallmethod()
            if self == LocalPlayer.Character or self.Parent == LocalPlayer.Character then
                if method:find("Damage") or method == "BreakJoints" or method:find("Kill") or method == "TakeDamage" then
                    return
                end
            end
        end
        return oldNamecall(self, ...)
    end)

    -- Disconnect death / ragdoll signals and disable local scripts
    local function protectCharacter(char)
        if not char then return end
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            for _, conn in ipairs(getconnections(hum.Died)) do
                conn:Disable()
            end
            for _, conn in ipairs(getconnections(hum.HealthChanged)) do
                conn:Disable()
            end
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            hum.HealthChanged:Connect(function(h)
                if h < 1 then
                    hum.Health = hum.MaxHealth
                end
            end)
        end

        -- Disable localscripts in character
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("LocalScript") then
                v.Disabled = true
                pcall(function() v.Parent = nil end)
            end
        end
    end

    if LocalPlayer.Character then
        protectCharacter(LocalPlayer.Character)
    end
    LocalPlayer.CharacterAdded:Connect(protectCharacter)
end

-- Add godmode toggle to Player tab
createToggle(playerTab, "GODMODE", "Enable godmode (damage block + script disable)", function(active)
    if active then
        enableGodmode()
    else
        warn("[SuperFlingX] Godmode cannot be fully disabled once enabled")
    end
end)

-- ────────────────────────────────────────────────
-- Player Tab
-- ────────────────────────────────────────────────

local flyCont = Instance.new("Frame")
flyCont.Size = UDim2.new(1, 0, 0, 80)
flyCont.BackgroundTransparency = 1
flyCont.Parent = playerTab

local flyLbl = Instance.new("TextLabel")
flyLbl.Size = UDim2.new(1, 0, 0, 25)
flyLbl.BackgroundTransparency = 1
flyLbl.Text = "Fly Speed: 80"
flyLbl.TextColor3 = theme.text_dark
flyLbl.TextSize = 15
flyLbl.Font = Enum.Font.Gotham
flyLbl.Parent = flyCont

local flySlider = Instance.new("Frame")
flySlider.Size = UDim2.new(1, 0, 0, 10)
flySlider.Position = UDim2.new(0, 0, 0, 30)
flySlider.BackgroundColor3 = theme.slider_bg
flySlider.Parent = flyCont
Instance.new("UICorner", flySlider).CornerRadius = UDim.new(0, 5)

local flyBar = Instance.new("Frame", flySlider)
flyBar.Size = UDim2.new(80/2000, 0, 1, 0)
flyBar.BackgroundColor3 = theme.accent_pink
Instance.new("UICorner", flyBar).CornerRadius = UDim.new(0, 5)

local flyHandle = Instance.new("TextButton", flySlider)
flyHandle.Size = UDim2.new(0, 20, 0, 20)
flyHandle.Position = UDim2.new(80/2000, -10, 0.5, -10)
flyHandle.BackgroundColor3 = Color3.new(1,1,1)
flyHandle.Text = ""
Instance.new("UICorner", flyHandle).CornerRadius = UDim.new(1,0)

local walkCont = Instance.new("Frame")
walkCont.Size = UDim2.new(1, 0, 0, 80)
walkCont.BackgroundTransparency = 1
walkCont.Parent = playerTab

local walkLbl = Instance.new("TextLabel")
walkLbl.Size = UDim2.new(1, 0, 0, 25)
walkLbl.BackgroundTransparency = 1
walkLbl.Text = "Walk Speed: 25"
walkLbl.TextColor3 = theme.text_dark
walkLbl.TextSize = 15
walkLbl.Font = Enum.Font.Gotham
walkLbl.Parent = walkCont

local walkSlider = Instance.new("Frame")
walkSlider.Size = UDim2.new(1, 0, 0, 10)
walkSlider.Position = UDim2.new(0, 0, 0, 30)
walkSlider.BackgroundColor3 = theme.slider_bg
walkSlider.Parent = walkCont
Instance.new("UICorner", walkSlider).CornerRadius = UDim.new(0, 5)

local walkBar = Instance.new("Frame", walkSlider)
walkBar.Size = UDim2.new(25/2000, 0, 1, 0)
walkBar.BackgroundColor3 = theme.accent_lav
Instance.new("UICorner", walkBar).CornerRadius = UDim.new(0, 5)

local walkHandle = Instance.new("TextButton", walkSlider)
walkHandle.Size = UDim2.new(0, 20, 0, 20)
walkHandle.Position = UDim2.new(25/2000, -10, 0.5, -10)
walkHandle.BackgroundColor3 = Color3.new(1,1,1)
walkHandle.Text = ""
Instance.new("UICorner", walkHandle).CornerRadius = UDim.new(1,0)

createButton(playerTab, "RESET SPEEDS", "Reset fly and walk speeds to defaults.", function()
    flySpeed = 80
    walkSpeed = 25

    flyLbl.Text = "Fly Speed: 80"
    flyBar.Size = UDim2.new(80/2000, 0, 1, 0)
    flyHandle.Position = UDim2.new(80/2000, -10, 0.5, -10)

    walkLbl.Text = "Walk Speed: 25"
    walkBar.Size = UDim2.new(25/2000, 0, 1, 0)
    walkHandle.Position = UDim2.new(25/2000, -10, 0.5, -10)

    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = walkSpeed
        enforceWalkSpeed()
    end
end)

local updateFlyToggle = createToggle(playerTab, "FLY", "Toggle flying (WASD Space/Ctrl). Q keybind to toggle.", function(active)
    FLYING = active
    if FLYING then
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") or not char:FindFirstChild("HumanoidRootPart") then
            FLYING = false
            updateFlyToggle(false)
            return
        end

        local humanoid = char.Humanoid
        local root = char.HumanoidRootPart

        humanoid.PlatformStand = true

        noclipFlyConnection = RunService.Heartbeat:Connect(function()
            if not FLYING then return end
            for _, p in char:GetDescendants() do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end)

        local keys = {Forward = false, Backward = false, Left = false, Right = false, Up = false, Down = false}

        local inputBeganConn = UserInputService.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.W then keys.Forward = true end
            if input.KeyCode == Enum.KeyCode.S then keys.Backward = true end
            if input.KeyCode == Enum.KeyCode.A then keys.Left = true end
            if input.KeyCode == Enum.KeyCode.D then keys.Right = true end
            if input.KeyCode == Enum.KeyCode.Space then keys.Up = true end
            if input.KeyCode == Enum.KeyCode.LeftControl then keys.Down = true end
        end)

        local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then keys.Forward = false end
            if input.KeyCode == Enum.KeyCode.S then keys.Backward = false end
            if input.KeyCode == Enum.KeyCode.A then keys.Left = false end
            if input.KeyCode == Enum.KeyCode.D then keys.Right = false end
            if input.KeyCode == Enum.KeyCode.Space then keys.Up = false end
            if input.KeyCode == Enum.KeyCode.LeftControl then keys.Down = false end
        end)

        flyLoop = RunService.RenderStepped:Connect(function()
            if not FLYING or not root or not root.Parent then return end

            local cam = workspace.CurrentCamera
            local lookCFrame = cam.CFrame - cam.CFrame.Position
            root.CFrame = CFrame.new(root.Position) * lookCFrame

            local moveDir = Vector3.new()
            if keys.Forward then moveDir += cam.CFrame.LookVector end
            if keys.Backward then moveDir -= cam.CFrame.LookVector end
            if keys.Left then moveDir -= cam.CFrame.RightVector end
            if keys.Right then moveDir += cam.CFrame.RightVector end
            if keys.Up then moveDir += Vector3.new(0,1,0) end
            if keys.Down then moveDir -= Vector3.new(0,1,0) end

            if moveDir.Magnitude > 0 then moveDir = moveDir.Unit * flySpeed end

            root.AssemblyLinearVelocity = moveDir
            root.AssemblyAngularVelocity = Vector3.zero
        end)

        flyCleanup = function()
            inputBeganConn:Disconnect()
            inputEndedConn:Disconnect()
            humanoid.PlatformStand = false
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
    else
        if noclipFlyConnection then noclipFlyConnection:Disconnect() end
        if flyLoop then flyLoop:Disconnect() flyLoop = nil end
        if flyCleanup then flyCleanup() flyCleanup = nil end

        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
        end
    end
end)

-- Add Q keybind to toggle fly
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Q then
        updateFlyToggle(not FLYING)
    end
end)

local flyDrag = false
local function updateFly(input)
    local w = flySlider.AbsoluteSize.X
    local x = math.clamp(input.Position.X - flySlider.AbsolutePosition.X, 0, w)
    local p = x / w
    flySpeed = math.max(1, math.floor(p * 2000))
    flyLbl.Text = "Fly Speed: " .. flySpeed
    flyBar.Size = UDim2.new(p, 0, 1, 0)
    flyHandle.Position = UDim2.new(p, -10, 0.5, -10)
end

flyHandle.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        flyDrag = true
        updateFly(i)
    end
end)

local walkDrag = false
local function updateWalk(input)
    local w = walkSlider.AbsoluteSize.X
    local x = math.clamp(input.Position.X - walkSlider.AbsolutePosition.X, 0, w)
    local p = x / w
    walkSpeed = math.max(1, math.floor(p * 2000))
    walkLbl.Text = "Walk Speed: " .. walkSpeed
    walkBar.Size = UDim2.new(p, 0, 1, 0)
    walkHandle.Position = UDim2.new(p, -10, 0.5, -10)

    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = walkSpeed
        enforceWalkSpeed()
    end
end

walkHandle.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        walkDrag = true
        updateWalk(i)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        flyDrag = false
        walkDrag = false
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then
            h.WalkSpeed = walkSpeed
            enforceWalkSpeed()
        end
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if flyDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then updateFly(i) end
    if walkDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then updateWalk(i) end
end)

local updateESPToggle = createToggle(playerTab, "ESP + DIST", "Toggle ESP and distance labels.", function(active)
    toggleESPAndDistance(active)
end)

local updateNoclipToggle = createToggle(playerTab, "NOCLIP", "Toggle no-clip.", function(active)
    toggleNoclip(active)
end)

local updateInfJumpToggle = createToggle(playerTab, "INF JUMP", "Toggle infinite jump.", function(active)
    toggleInfJump(active)
end)

-- ────────────────────────────────────────────────
-- Auto Tab
-- ────────────────────────────────────────────────

local farmKillCont = createFeatureContainer(autoTab, "FARM KILL", "Auto spam abilities on selected players.", 100)
local updateFarmKillToggle = createToggle(farmKillCont, "FARM KILL", "Auto spam abilities on selected players.", function(active)
    if active then
        startFarmKill()
    else
        stopFarmKill()
    end
end)

local superFlingCont = createFeatureContainer(autoTab, "SUPER FLING", "Rapid fling selected players.", 100)
local updateSuperFlingToggle = createToggle(superFlingCont, "SUPER FLING", "Rapid fling selected players.", function(active)
    if active then startSuperFling() else stopSuperFling() end
end)

-- Select buttons row
local selectRow = Instance.new("Frame")
selectRow.Size = UDim2.new(1, 0, 0, 50)
selectRow.BackgroundTransparency = 1
selectRow.Parent = autoTab

local selectAllBtn = Instance.new("TextButton")
selectAllBtn.Size = UDim2.new(0.48, -10, 0, 40)
selectAllBtn.Position = UDim2.new(0, 0, 0, 5)
selectAllBtn.BackgroundColor3 = theme.accent_mint
selectAllBtn.BackgroundTransparency = 0.1
selectAllBtn.Text = "SELECT ALL"
selectAllBtn.TextColor3 = theme.text_dark
selectAllBtn.TextSize = 14
selectAllBtn.Font = Enum.Font.GothamSemibold
selectAllBtn.Parent = selectRow

local selectAllCorner = Instance.new("UICorner", selectAllBtn)
selectAllCorner.CornerRadius = UDim.new(0, 12)

selectAllBtn.MouseButton1Click:Connect(function()
    selectedPlayers = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(selectedPlayers, p)
        end
    end
    
    -- Update existing buttons instantly
    for player, button in pairs(playerButtons) do
        local isSel = table.find(selectedPlayers, player) ~= nil
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = isSel and theme.player_sel or theme.player_unsel,
            BackgroundTransparency = isSel and 0 or 0.15
        }):Play()
    end
end)

local deselectAllBtn = Instance.new("TextButton")
deselectAllBtn.Size = UDim2.new(0.48, -10, 0, 40)
deselectAllBtn.Position = UDim2.new(0.52, 10, 0, 5)
deselectAllBtn.BackgroundColor3 = theme.accent_pink
deselectAllBtn.BackgroundTransparency = 0.1
deselectAllBtn.Text = "DESELECT ALL"
deselectAllBtn.TextColor3 = theme.text_dark
deselectAllBtn.TextSize = 14
deselectAllBtn.Font = Enum.Font.GothamSemibold
deselectAllBtn.Parent = selectRow

local deselectAllCorner = Instance.new("UICorner", deselectAllBtn)
deselectAllCorner.CornerRadius = UDim.new(0, 12)

deselectAllBtn.MouseButton1Click:Connect(function()
    selectedPlayers = {}
    
    -- Update existing buttons instantly
    for _, button in pairs(playerButtons) do
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = theme.player_unsel,
            BackgroundTransparency = 0.15
        }):Play()
    end
end)

-- Small arrows
local arrowLabel = Instance.new("TextLabel")
arrowLabel.Size = UDim2.new(1, 0, 0, 30)
arrowLabel.BackgroundTransparency = 1
arrowLabel.Text = "↓          ↓"
arrowLabel.TextColor3 = theme.text_dark
arrowLabel.TextSize = 28
arrowLabel.Font = Enum.Font.GothamBold
arrowLabel.Parent = autoTab

-- Player list title
local playerListTitle = Instance.new("TextLabel")
playerListTitle.Size = UDim2.new(1, 0, 0, 35)
playerListTitle.BackgroundTransparency = 1
playerListTitle.Text = "Player List"
playerListTitle.TextColor3 = theme.accent_lav
playerListTitle.TextSize = 20
playerListTitle.Font = Enum.Font.GothamBold
playerListTitle.Parent = autoTab

-- Player scroll frame
local playerScroll = Instance.new("ScrollingFrame")
playerScroll.Name = "PlayerScroll"
playerScroll.Size = UDim2.new(1, 0, 0, 320)
playerScroll.BackgroundTransparency = 0.8
playerScroll.BackgroundColor3 = theme.bg_main
playerScroll.ScrollBarThickness = 5
playerScroll.ScrollBarImageColor3 = theme.accent_mint
playerScroll.Parent = autoTab

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 8)
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Parent = playerScroll

-- Initial population
updateList(playerScroll)

-- Update list only when players actually join/leave
Players.PlayerAdded:Connect(function()
    task.wait(0.3) -- small delay to let character load if needed
    updateList(playerScroll)
end)

Players.PlayerRemoving:Connect(function()
    updateList(playerScroll)
end)

-- ────────────────────────────────────────────────
-- Fling Tab
-- ────────────────────────────────────────────────

local updateTouchFlingToggle = createToggle(flingTab, "TOUCH FLING", "Fling on touch.", function(active)
    touchFlingEnabled = active
    if touchFlingEnabled then
        touchLoop = RunService.Heartbeat:Connect(function()
            if activeFling then return end
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local root = char.HumanoidRootPart
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local tRoot = p.Character.HumanoidRootPart
                    local dist = (root.Position - tRoot.Position).Magnitude
                    if dist < 5.5 and (not flingCooldowns[p] or tick() - flingCooldowns[p] > 4) then
                        startAttachFling(p, root.CFrame)
                        flingCooldowns[p] = tick()
                        break
                    end
                end
            end
        end)
    else
        if touchLoop then touchLoop:Disconnect() touchLoop = nil end
        activeFling = false
    end
end)

local updateClickFlingToggle = createToggle(flingTab, "CLICK FLING", "Fling on click.", function(active)
    clickFlingEnabled = active
    if clickFlingEnabled then
        clickConn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local mouse = LocalPlayer:GetMouse()
                if mouse.Target then
                    local model = mouse.Target:FindFirstAncestorWhichIsA("Model")
                    local target = Players:GetPlayerFromCharacter(model)
                    if target and target ~= LocalPlayer then
                        startAttachFling(target, LocalPlayer.Character.HumanoidRootPart.CFrame)
                    end
                end
            end
        end)
    else
        if clickConn then clickConn:Disconnect() clickConn = nil end
    end
end)

-- ────────────────────────────────────────────────
-- OP & Funny tabs
-- ────────────────────────────────────────────────

local opLabel = Instance.new("TextLabel")
opLabel.Size = UDim2.new(1, 0, 0, 55)
opLabel.BackgroundTransparency = 1
opLabel.Text = "OP features incoming!"
opLabel.TextColor3 = theme.text_light
opLabel.TextSize = 18
opLabel.Font = Enum.Font.Gotham
opLabel.Parent = opTab

createButton(funnyTab, "SET SPAWN", "Set current position as spawn.", setSpawnPoint)
createButton(funnyTab, "TP SPAWN", "Teleport to spawn point.", teleportToSpawnPoint)

-- ────────────────────────────────────────────────
-- Reset on character respawn
-- ────────────────────────────────────────────────

LocalPlayer.CharacterAdded:Connect(function(newChar)
    FLYING = false
    flinging = false
    farmkilling = false

    if noclipFlyConnection then noclipFlyConnection:Disconnect() end
    if flyLoop then flyLoop:Disconnect() flyLoop = nil end
    if flyCleanup then flyCleanup() flyCleanup = nil end
    if mainLoop then mainLoop:Disconnect() mainLoop = nil end
    if cycleTimer then task.cancel(cycleTimer) cycleTimer = nil end
    if farmKillLoop then farmKillLoop:Disconnect() farmKillLoop = nil end
    if farmKillCycle then task.cancel(farmKillCycle) farmKillCycle = nil end

    task.delay(0.6, function()
        local h = newChar:FindFirstChildOfClass("Humanoid")
        if h then
            h.WalkSpeed = walkSpeed
            enforceWalkSpeed()
        end
    end)
end)

-- Open home tab by default
tabs["Home"].MouseButton1Click:Fire()

print("SuperFlingX Dark Pro Edition 2026 loaded — improved player list selection UI")
