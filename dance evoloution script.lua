
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SerenityStyleHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

-- Floating icon
local icon = Instance.new("TextButton")
icon.Name = "FloatingIcon"
icon.Size = UDim2.fromOffset(48, 48)
icon.Position = UDim2.new(0, 20, 0.5, -24)
icon.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
icon.Text = "S"
icon.TextColor3 = Color3.fromRGB(100, 210, 255)
icon.TextSize = 26
icon.Font = Enum.Font.GothamBold
icon.Parent = gui

Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 14)

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(100, 100, 170)
iconStroke.Thickness = 1.5
iconStroke.Parent = icon

-- Main window
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.Size = UDim2.fromOffset(570, 390)
main.Position = UDim2.new(0.5, -285, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(13, 14, 19)
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 47, 59)
mainStroke.Thickness = 1
mainStroke.Parent = main

-- Top bar
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 43)
top.BackgroundColor3 = Color3.fromRGB(9, 10, 14)
top.BorderSizePixel = 0
top.Parent = main

Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 230, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "✦  SERENITY HUB"
title.TextColor3 = Color3.fromRGB(120, 205, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

-- Version label
local version = Instance.new("TextLabel")
version.Size = UDim2.fromOffset(60, 30)
version.Position = UDim2.new(1, -110, 0, 6)
version.BackgroundColor3 = Color3.fromRGB(25, 26, 34)
version.Text = "v1.0"
version.TextColor3 = Color3.fromRGB(190, 190, 205)
version.Font = Enum.Font.Gotham
version.TextSize = 12
version.Parent = top

Instance.new("UICorner", version).CornerRadius = UDim.new(0, 7)

-- Destroy GUI button
local destroyButton = Instance.new("TextButton")
destroyButton.Name = "DestroyGUI"
destroyButton.Size = UDim2.fromOffset(30, 30)
destroyButton.Position = UDim2.new(1, -38, 0, 6)
destroyButton.BackgroundColor3 = Color3.fromRGB(130, 42, 52)
destroyButton.Text = "X"
destroyButton.TextColor3 = Color3.new(1, 1, 1)
destroyButton.Font = Enum.Font.GothamBold
destroyButton.TextSize = 14
destroyButton.Parent = top

Instance.new("UICorner", destroyButton).CornerRadius = UDim.new(0, 7)

destroyButton.Activated:Connect(function()
    gui:Destroy()
end)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(0, 43)
sidebar.Size = UDim2.new(0, 145, 1, -43)
sidebar.BackgroundColor3 = Color3.fromRGB(17, 18, 24)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 7)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Parent = sidebar

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 14)
sidebarPadding.PaddingLeft = UDim.new(0, 9)
sidebarPadding.PaddingRight = UDim.new(0, 9)
sidebarPadding.Parent = sidebar

local pages = {}
local selectedTab = "Automation"

local function makeTab(name, symbol, order)
    local button = Instance.new("TextButton")
    button.Name = name .. "Tab"
    button.Size = UDim2.new(1, 0, 0, 36)
    button.LayoutOrder = order
    button.BackgroundColor3 = Color3.fromRGB(17, 18, 24)
    button.BorderSizePixel = 0
    button.Text = symbol .. "   " .. name
    button.TextColor3 = Color3.fromRGB(175, 178, 192)
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 12
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = sidebar

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)

    button.Activated:Connect(function()
        selectedTab = name

        for tabName, tab in pairs(pages) do
            tab.BackgroundColor3 =
                tabName == selectedTab
                and Color3.fromRGB(87, 43, 102)
                or Color3.fromRGB(17, 18, 24)
        end
    end)

    pages[name] = button
end

makeTab("About", "ⓘ", 1)
makeTab("Dashboard", "▦", 2)
makeTab("Automation", "⚙", 3)
makeTab("Inventory", "◇", 4)
makeTab("Character", "♙", 5)
makeTab("Settings", "⚙", 6)

pages.Automation.BackgroundColor3 = Color3.fromRGB(87, 43, 102)

-- Main content
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.fromOffset(157, 54)
content.Size = UDim2.new(1, -170, 1, -65)
content.BackgroundTransparency = 1
content.Parent = main

local heading = Instance.new("TextLabel")
heading.Size = UDim2.new(1, 0, 0, 30)
heading.BackgroundTransparency = 1
heading.Text = "Automation"
heading.TextColor3 = Color3.fromRGB(245, 245, 250)
heading.TextSize = 21
heading.Font = Enum.Font.GothamBold
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = content

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(0, 29)
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Manage your automation options."
subtitle.TextColor3 = Color3.fromRGB(135, 138, 153)
subtitle.TextSize = 11
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = content

-- Options container
local options = Instance.new("Frame")
options.Name = "Options"
options.Position = UDim2.fromOffset(0, 65)
options.Size = UDim2.new(1, 0, 0, 244)
options.BackgroundColor3 = Color3.fromRGB(19, 20, 27)
options.BorderSizePixel = 0
options.Parent = content

Instance.new("UICorner", options).CornerRadius = UDim.new(0, 9)

local optionsPadding = Instance.new("UIPadding")
optionsPadding.PaddingLeft = UDim.new(0, 12)
optionsPadding.PaddingRight = UDim.new(0, 12)
optionsPadding.PaddingTop = UDim.new(0, 8)
optionsPadding.Parent = options

local optionsLayout = Instance.new("UIListLayout")
optionsLayout.Padding = UDim.new(0, 5)
optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
optionsLayout.Parent = options

--buttons


-- Checkbox states only; add your own functions later.
local states = {
    AutoAura = false,
    AutoRebirth = false,
    AutoAscend = false,
    AutoWin = false
}

local function makeCheckbox(key, label, order)
    local row = Instance.new("Frame")
    row.Name = key .. "Row"
    row.Size = UDim2.new(1, 0, 0, 49)
    row.BackgroundColor3 = Color3.fromRGB(24, 25, 33)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = options

    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

    local text = Instance.new("TextLabel")
    text.Position = UDim2.fromOffset(10, 0)
    text.Size = UDim2.new(1, -65, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = label
    text.TextColor3 = Color3.fromRGB(225, 226, 235)
    text.Font = Enum.Font.GothamMedium
    text.TextSize = 13
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Parent = row

    local check = Instance.new("TextButton")
    check.Name = "Checkbox"
    check.Size = UDim2.fromOffset(24, 24)
    check.Position = UDim2.new(1, -36, 0.5, -12)
    check.BackgroundColor3 = Color3.fromRGB(42, 44, 56)
    check.Text = ""
    check.BorderSizePixel = 0
    check.Parent = row

    Instance.new("UICorner", check).CornerRadius = UDim.new(0, 6)

    local function refresh()
        check.BackgroundColor3 = states[key]
            and Color3.fromRGB(44, 190, 120)
            or Color3.fromRGB(42, 44, 56)

        check.Text = states[key] and "✓" or ""
        check.TextColor3 = Color3.new(1, 1, 1)
        check.Font = Enum.Font.GothamBold
        check.TextSize = 16
    end

    check.Activated:Connect(function()
        states[key] = not states[key]
        refresh()

		if key =="AutoAura" then
			if states.AutoAura then
				task.spawn(function()
				    while states.AutoAura do
					    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AuraClick"):FireServer()
	                    task.wait(0.1)
				    end
			    end)
			end
		end

		if key == "AutoWin" then
			if states.AutoWin then
				task.spawn(function()
				    while states.AutoWin do
					  character:PivotTo(CFrame.new(-621.7509155273438, 7.34686279296875, 642.7279052734375))
					  task.wait(2)
                    end
                end)
			end
		end
		
		if key == "AutoAscend" then
			if states.AutoAscend then
				task.spawn(function()
				   while states.AutoAscend do 
					  game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AscendRequest"):FireServer()
                      task.wait(3)
				    end	
				end)	
			end
		end	

		if key == "AutoRebirth" then
			if states.AutoRebirth then
				task.spawn(function()
				    while states.AutoRebirth do 
					   game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RebirthRequest"):FireServer()
                       task.wait(1.5)
					end     
				end)
			end
		end		
    end)

    refresh()
end

makeCheckbox("AutoAura", "Auto Aura", 1)
makeCheckbox("AutoRebirth", "Auto Rebirth", 2)
makeCheckbox("AutoAscend", "Auto Ascend", 3)
makeCheckbox("AutoWin", "Auto Win", 4)

-- Footer
local footer = Instance.new("TextLabel")
footer.Position = UDim2.new(0, 0, 1, -28)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.BackgroundTransparency = 1
footer.Text = "Press Left Ctrl to toggle the hub"
footer.TextColor3 = Color3.fromRGB(115, 118, 135)
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextXAlignment = Enum.TextXAlignment.Left
footer.Parent = content

-- Toggle GUI visibility
local function toggleWindow()
    main.Visible = not main.Visible
end

icon.Activated:Connect(toggleWindow)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.LeftControl then
        toggleWindow()
    end
end)

-- Drag window by the top bar
local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
