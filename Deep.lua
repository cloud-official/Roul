local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create the Orange UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OrangeUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Enhanced color scheme
local colors = {
    background = Color3.fromRGB(40, 35, 30),
    primary = Color3.fromRGB(255, 120, 50),
    secondary = Color3.fromRGB(70, 50, 40),
    accent = Color3.fromRGB(255, 150, 80),
    text = Color3.fromRGB(240, 240, 240),
    toggleOn = Color3.fromRGB(100, 200, 100),
    toggleOff = Color3.fromRGB(200, 80, 80),
    dropdownToggleOn = Color3.fromRGB(255, 140, 60),
    dropdownToggleOff = Color3.fromRGB(180, 80, 50),
    sliderTrack = Color3.fromRGB(80, 60, 50),
    sliderFill = Color3.fromRGB(255, 140, 60),
    inputBackground = Color3.fromRGB(50, 40, 35),
    light = Color3.fromRGB(80, 60, 50),
    border = Color3.fromRGB(100, 70, 50),
    tabActive = Color3.fromRGB(255, 120, 50),
    tabInactive = Color3.fromRGB(70, 50, 40),
    notification = Color3.fromRGB(255, 100, 50),
    dropdownClose = Color3.fromRGB(255, 80, 40),
    reopenButton = Color3.fromRGB(255, 100, 50),
    labelDefault = Color3.fromRGB(240, 240, 240),
    labelTitle = Color3.fromRGB(255, 180, 100),
    labelWarning = Color3.fromRGB(255, 100, 100),
    labelSuccess = Color3.fromRGB(100, 255, 100),
    labelInfo = Color3.fromRGB(100, 180, 255),
    labelSection = Color3.fromRGB(255, 140, 60)
}

-- Mobile reopen button
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 50, 0, 50)
reopenButton.Position = UDim2.new(1, -70, 1, -70)
reopenButton.Text = "X"
reopenButton.Font = Enum.Font.GothamBold
reopenButton.TextSize = 24
reopenButton.TextColor3 = colors.text
reopenButton.BackgroundColor3 = colors.reopenButton
reopenButton.BorderSizePixel = 0
reopenButton.Visible = false
reopenButton.ZIndex = 10
reopenButton.Parent = screenGui

local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(1, 0)
reopenCorner.Parent = reopenButton

-- Enhanced Notification System (now on top layer)
local notificationFrame = Instance.new("Frame")
notificationFrame.Size = UDim2.new(0, 320, 0, 90)
notificationFrame.Position = UDim2.new(0.5, -160, 1, -100)
notificationFrame.BackgroundColor3 = colors.notification
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
notificationFrame.ZIndex = 1000  -- Increased ZIndex to ensure it's on top
notificationFrame.Parent = screenGui

local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 8)
notificationCorner.Parent = notificationFrame

-- Notification drag areas (thicker but invisible)
local notifTopDrag = Instance.new("Frame")
notifTopDrag.Size = UDim2.new(1, 0, 0, 25) -- Thicker drag area
notifTopDrag.Position = UDim2.new(0, 0, 0, 0)
notifTopDrag.BackgroundTransparency = 1 -- Completely invisible
notifTopDrag.ZIndex = 1001
notifTopDrag.Parent = notificationFrame

local notifBottomDrag = Instance.new("Frame")
notifBottomDrag.Size = UDim2.new(1, 0, 0, 25) -- Thicker drag area
notifBottomDrag.Position = UDim2.new(0, 0, 1, -25)
notifBottomDrag.BackgroundTransparency = 1 -- Completely invisible
notifBottomDrag.ZIndex = 1001
notifBottomDrag.Parent = notificationFrame

local notificationLabel = Instance.new("TextLabel")
notificationLabel.Size = UDim2.new(1, -20, 0.7, -5)
notificationLabel.Position = UDim2.new(0, 10, 0, 5)
notificationLabel.BackgroundTransparency = 1
notificationLabel.TextColor3 = colors.text
notificationLabel.Font = Enum.Font.GothamBold
notificationLabel.TextSize = 15
notificationLabel.TextWrapped = true
notificationLabel.TextXAlignment = Enum.TextXAlignment.Left
notificationLabel.TextYAlignment = Enum.TextYAlignment.Top
notificationLabel.ClipsDescendants = true
notificationLabel.ZIndex = 1002 -- Higher than frame
notificationLabel.Parent = notificationFrame

local notificationSubLabel = Instance.new("TextLabel")
notificationSubLabel.Size = UDim2.new(1, -20, 0.3, -5)
notificationSubLabel.Position = UDim2.new(0, 10, 0.7, 0)
notificationSubLabel.BackgroundTransparency = 1
notificationSubLabel.TextColor3 = colors.text
notificationSubLabel.Font = Enum.Font.Gotham
notificationSubLabel.TextSize = 12
notificationSubLabel.Text = "NOTIFICATION"
notificationSubLabel.TextXAlignment = Enum.TextXAlignment.Left
notificationSubLabel.ZIndex = 1002 -- Higher than frame
notificationSubLabel.Parent = notificationFrame

local function showNotification(message, duration)
    notificationLabel.Text = message
    notificationFrame.Visible = true
    
    notificationFrame.Position = UDim2.new(0.5, -160, 1, 100)
    TweenService:Create(notificationFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -160, 1, -100)}):Play()
    
    if duration then
        task.delay(duration, function()
            TweenService:Create(notificationFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -160, 1, 100)}):Play()
            task.wait(0.3)
            notificationFrame.Visible = false
        end)
    end
end

-- Create the main frame with enhanced drag lines
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.6, -150, 0.5, -100)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = colors.background
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Add rounded corners and border
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local border = Instance.new("UIStroke")
border.Color = colors.border
border.Thickness = 1
border.Parent = frame

-- Title bar (top drag area)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = colors.primary
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Name = "TopCorner"
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = colors.text
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Text = "UI Library"
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3
title.Parent = titleBar

-- Enhanced drag lines (thicker but invisible)
local bottomDragLine = Instance.new("Frame")
bottomDragLine.Size = UDim2.new(1, 0, 0, 20) -- Thicker drag area
bottomDragLine.Position = UDim2.new(0, 0, 1, -20)
bottomDragLine.BackgroundTransparency = 1 -- Completely invisible
bottomDragLine.BorderSizePixel = 0
bottomDragLine.ZIndex = 2
bottomDragLine.Parent = frame

local leftDragLine = Instance.new("Frame")
leftDragLine.Size = UDim2.new(0, 30, 1, -50) -- Increased width to 30 and adjusted height
leftDragLine.Position = UDim2.new(0, 0, 0, 30)
leftDragLine.BackgroundTransparency = 1 -- Completely invisible
leftDragLine.ZIndex = 2
leftDragLine.Parent = frame

local rightDragLine = Instance.new("Frame")
rightDragLine.Size = UDim2.new(0, 30, 1, -50) -- Increased width to 30 and adjusted height
rightDragLine.Position = UDim2.new(1, -30, 0, 30)
rightDragLine.BackgroundTransparency = 1 -- Completely invisible
rightDragLine.ZIndex = 2
rightDragLine.Parent = frame

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = colors.text
closeBtn.BackgroundColor3 = colors.dropdownClose
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 3

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    reopenButton.Visible = true
    showNotification("UI has been hidden\nTap the orange X button to reopen the menu", 3)
end)

reopenButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    reopenButton.Visible = false
    showNotification("UI has been restored\nYou can now access all features", 2)
end)

closeBtn.Parent = titleBar

-- TAB SYSTEM
local tabButtons = {}
local tabFrames = {}
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(1, -10, 0, 40)
tabsContainer.Position = UDim2.new(0, 5, 0, 35)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = frame

local tabsScrolling = Instance.new("ScrollingFrame")
tabsScrolling.Size = UDim2.new(1, 0, 1, 0)
tabsScrolling.BackgroundTransparency = 1
tabsScrolling.ScrollBarThickness = 5
tabsScrolling.ScrollBarImageColor3 = colors.primary
tabsScrolling.AutomaticCanvasSize = Enum.AutomaticSize.X
tabsScrolling.Parent = tabsContainer

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.Padding = UDim.new(0, 5)
tabsLayout.Parent = tabsScrolling

-- Content frame
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -10, 1, -100)
contentFrame.Position = UDim2.new(0, 5, 0, 80)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 5
contentFrame.ScrollBarImageColor3 = colors.primary
contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
contentFrame.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

-- Function to create tabs
local function createTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 100, 1, 0)
    tabButton.Text = name
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.TextColor3 = colors.text
    tabButton.BackgroundColor3 = colors.tabInactive
    tabButton.BorderSizePixel = 0
    tabButton.AutoButtonColor = false
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    
    local tabContentLayout = Instance.new("UIListLayout")
    tabContentLayout.Padding = UDim.new(0, 10)
    tabContentLayout.Parent = tabFrame
    
    tabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        for _, button in pairs(tabButtons) do
            button.BackgroundColor3 = colors.tabInactive
        end
        tabFrame.Visible = true
        tabButton.BackgroundColor3 = colors.tabActive
        showNotification("Switched to " .. name .. " tab\nAccess all " .. name .. " features here", 2)
    end)
    
    tabButtons[name] = tabButton
    tabFrames[name] = tabFrame
    
    tabButton.Parent = tabsScrolling
    tabFrame.Parent = contentFrame
    
    return tabFrame
end

-- UI Component Functions
local function createLabel(parent, text, size, labelType)
    local labelTypes = {
        default = {color = colors.labelDefault, bold = false},
        title = {color = colors.labelTitle, bold = true},
        warning = {color = colors.labelWarning, bold = true},
        success = {color = colors.labelSuccess, bold = true},
        info = {color = colors.labelInfo, bold = false},
        section = {color = colors.labelSection, bold = true}
    }
    
    local settings = labelTypes[labelType or "default"]
    
    local label = Instance.new("TextLabel")
    label.Size = size or UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = settings.color
    label.Font = settings.bold and Enum.Font.GothamBold or Enum.Font.Gotham
    label.TextSize = settings.bold and 16 or 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = #parent:GetChildren()
    label.Parent = parent
    
    if labelType == "section" then
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.TextSize = 15
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.Parent = label
    end
    
    return label
end

local function createSlider(parent, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 40) -- Reduced height from 50 to 40
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.LayoutOrder = #parent:GetChildren()
    
    local label = createLabel(sliderFrame, text .. ": " .. default, UDim2.new(1, 0, 0, 20))
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 6) -- Reduced height from 10 to 6
    track.Position = UDim2.new(0, 0, 0, 25)
    track.BackgroundColor3 = colors.sliderTrack
    track.BorderSizePixel = 0
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3) -- Smaller corner radius
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = colors.sliderFill
    fill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3) -- Smaller corner radius
    fillCorner.Parent = fill
    
    local handle = Instance.new("TextButton")
    handle.Size = UDim2.new(0, 12, 0, 12) -- Reduced size from 15 to 12
    handle.Position = UDim2.new(fill.Size.X.Scale, -6, 0.5, -6) -- Adjusted position
    handle.Text = ""
    handle.BackgroundColor3 = colors.primary
    handle.BorderSizePixel = 0
    handle.AutoButtonColor = false
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(1, 0)
    handleCorner.Parent = handle
    
    fill.Parent = track
    handle.Parent = track
    track.Parent = sliderFrame
    sliderFrame.Parent = parent
    
    local isDragging = false
    
    local function updateSlider(input)
        local xOffset = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * xOffset)
        
        fill.Size = UDim2.new(xOffset, 0, 1, 0)
        handle.Position = UDim2.new(xOffset, -6, 0.5, -6) -- Adjusted position
        label.Text = text .. ": " .. value
        
        callback(value)
    end
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            updateSlider(input)
        end
    end)
    
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            updateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return sliderFrame
end

local function createToggle(parent, text, default, callback, isDropdownToggle)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.LayoutOrder = #parent:GetChildren()

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.3, 0, 1, 0)
    btn.Position = UDim2.new(0.7, 0, 0, 0)
    btn.Text = default and "ON" or "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = colors.text
    btn.BackgroundColor3 = isDropdownToggle and (default and colors.dropdownToggleOn or colors.dropdownToggleOff) 
                          or (default and colors.toggleOn or colors.toggleOff)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local newState = not (btn.Text == "ON")
        btn.Text = newState and "ON" or "OFF"
        btn.BackgroundColor3 = isDropdownToggle and (newState and colors.dropdownToggleOn or colors.dropdownToggleOff)
                              or (newState and colors.toggleOn or colors.toggleOff)
        callback(newState)
        showNotification(text .. " " .. (newState and "ENABLED" or "DISABLED") .. "\nFeature status updated", 2)
    end)

    btn.Parent = toggleFrame
    toggleFrame.Parent = parent
    return btn
end

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = colors.text
    btn.BackgroundColor3 = colors.primary
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.LayoutOrder = #parent:GetChildren()

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        callback()
        showNotification(text .. " ACTIVATED\nAction completed successfully", 2)
    end)

    btn.Parent = parent
    return btn
end

local function createDropdown(parent, text, options)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 35)
    dropdownFrame.BackgroundColor3 = colors.secondary
    dropdownFrame.AutomaticSize = Enum.AutomaticSize.Y
    dropdownFrame.LayoutOrder = #parent:GetChildren()

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = dropdownFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = colors.border
    stroke.Thickness = 1
    stroke.Parent = dropdownFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = dropdownFrame

    local headerFrame = Instance.new("Frame")
    headerFrame.Size = UDim2.new(1, 0, 0, 35)
    headerFrame.BackgroundTransparency = 1
    headerFrame.LayoutOrder = 0
    headerFrame.Parent = dropdownFrame

    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, -40, 1, 0)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.Text = text .. " ▼"
    header.Font = Enum.Font.GothamBold
    header.TextSize = 14
    header.TextColor3 = colors.text
    header.BackgroundColor3 = colors.secondary
    header.BorderSizePixel = 0
    header.AutoButtonColor = false

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 6)
    headerCorner.Parent = header

    local headerStroke = Instance.new("UIStroke")
    headerStroke.Color = colors.border
    headerStroke.Thickness = 1
    headerStroke.Parent = header

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0.5, -15)
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 18
    closeButton.TextColor3 = colors.text
    closeButton.BackgroundColor3 = colors.dropdownClose
    closeButton.BorderSizePixel = 0
    closeButton.ZIndex = 2

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeButton

    -- Scrolling frame for dropdown content
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, 0, 0, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0, 40)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.Visible = false
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.ScrollBarImageColor3 = colors.primary
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.ClipsDescendants = true
    scrollFrame.LayoutOrder = 1

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 0, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.AutomaticSize = Enum.AutomaticSize.Y
    contentFrame.Parent = scrollFrame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 5)
    contentLayout.Parent = contentFrame

    -- Update canvas size when content changes
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentFrame.Size = UDim2.new(1, 0, 0, contentLayout.AbsoluteContentSize.Y)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y)
    end)

    local isOpen = false

    local function animateDropdown()
        if isOpen then
            scrollFrame.Visible = true
            scrollFrame.Size = UDim2.new(1, 0, 0, 0)
            TweenService:Create(scrollFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, math.min(contentLayout.AbsoluteContentSize.Y, 300))}):Play()
            TweenService:Create(header, TweenInfo.new(0.2), {BackgroundColor3 = colors.light}):Play()
            TweenService:Create(dropdownFrame, TweenInfo.new(0.2), {BackgroundColor3 = colors.light}):Play()
        else
            TweenService:Create(scrollFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TweenService:Create(header, TweenInfo.new(0.2), {BackgroundColor3 = colors.secondary}):Play()
            TweenService:Create(dropdownFrame, TweenInfo.new(0.2), {BackgroundColor3 = colors.secondary}):Play()
            task.wait(0.2)
            scrollFrame.Visible = false
        end
    end

    header.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        header.Text = text .. (isOpen and " ▲" or " ▼")
        animateDropdown()
    end)

    closeButton.MouseButton1Click:Connect(function()
        if isOpen then
            isOpen = false
            header.Text = text .. " ▼"
            animateDropdown()
        end
    end)

    header.Parent = headerFrame
    closeButton.Parent = headerFrame
    scrollFrame.Parent = dropdownFrame
    dropdownFrame.Parent = parent

    return {
        addButton = function(text, callback)
            local btn = createButton(contentFrame, text, callback)
            return btn
        end,
        addToggle = function(text, default, callback)
            local toggle = createToggle(contentFrame, text, default, callback, true)
            return toggle
        end,
        addLabel = function(text, labelType)
            local label = createLabel(contentFrame, text, nil, labelType)
            return label
        end,
        addSlider = function(text, min, max, default, callback)
            local slider = createSlider(contentFrame, text, min, max, default, callback)
            return slider
        end,
        frame = dropdownFrame
    }
end

-- Make sure the UI is properly sized
tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    tabsScrolling.CanvasSize = UDim2.new(0, tabsLayout.AbsoluteContentSize.X, 0, 0)
end)

contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
end)

-- Keybind to toggle UI
local toggleKey = Enum.KeyCode.RightControl
local uiVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == toggleKey then
        uiVisible = not uiVisible
        frame.Visible = uiVisible
        reopenButton.Visible = not uiVisible
        showNotification("UI " .. (uiVisible and "SHOWN" or "HIDDEN") .. "\n" .. (uiVisible and "Press RightControl to hide" or "Press RightControl or tap X to show"), 2)
    end
end)

-- Make frame draggable from all edges
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X,
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

local function connectDrag(framePart)
    framePart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
end

-- Connect drag to all edges
connectDrag(titleBar)
connectDrag(bottomDragLine)
connectDrag(leftDragLine)
connectDrag(rightDragLine)
connectDrag(notifTopDrag)
connectDrag(notifBottomDrag)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Mobile detection and adjustments
local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

if isMobile() then
    frame.Size = UDim2.new(0, 380, 0, 500)
    frame.Position = UDim2.new(0.6, -190, 0.6, -150)
    reopenButton.Size = UDim2.new(0, 70, 0, 70)
    reopenButton.TextSize = 32
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.TextSize = 28
    notificationFrame.Size = UDim2.new(0.9, 0, 0, 100)
    notificationFrame.Position = UDim2.new(0.5, 0, 1, -110)
    notificationFrame.AnchorPoint = Vector2.new(0.5, 0)
    notificationLabel.TextSize = 16
    notificationSubLabel.TextSize = 14
end
