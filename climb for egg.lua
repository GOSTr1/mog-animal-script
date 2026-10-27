--// R1YZ HUB - LocalScript GUI (Main + Settings) - EASY VERSION
--// Put in StarterPlayerScripts / run as a LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--// ===== CONFIG =====
local HUB_NAME = "R1YZ HUB"
local VERSION = "v1.0"
local LOGO_IMAGE = "" -- optional: rbxassetid://YOUR_ID (used if no GitHub download works)
local LOGO_URL = "https://raw.githubusercontent.com/GOSTr1/mog-animal-script/cad57b29311e510036c307f90b06d625fd31e295/FmxYi1CWACU32zB.jpg"
local toggleKey = Enum.KeyCode.LeftControl -- default keybind

--// ===== THEME =====
local Theme = {
	Background = Color3.fromRGB(16, 16, 20),
	Sidebar    = Color3.fromRGB(20, 20, 25),
	Row        = Color3.fromRGB(26, 26, 32),
	Accent     = Color3.fromRGB(104, 58, 124),
	Green      = Color3.fromRGB(46, 160, 110),
	Red        = Color3.fromRGB(178, 45, 45),
	Text       = Color3.fromRGB(235, 235, 240),
	SubText    = Color3.fromRGB(130, 130, 140),
	Off        = Color3.fromRGB(38, 38, 46),
}

--// ===== HELPERS =====
local function corner(obj, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = obj
	return c
end

local function label(parent, text, size, color, font)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextSize = size or 14
	l.TextColor3 = color or Theme.Text
	l.Font = font or Enum.Font.GothamMedium
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Parent = parent
	return l
end

local function makeDraggable(handle, target)
	local dragging, dragStart, startPos
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

--// ===== CLEAN OLD =====
local old = player.PlayerGui:FindFirstChild("R1YZHub")
if old then old:Destroy() end

--// ===== SCREEN GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "R1YZHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local connections = {}

--// ===== MAIN FRAME =====
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 620, 0, 400)
main.Position = UDim2.new(0.5, -310, 0.5, -200)
main.BackgroundColor3 = Theme.Background
main.BorderSizePixel = 0
main.Parent = gui
corner(main, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(40, 40, 50)
stroke.Thickness = 1
stroke.Parent = main

--// ===== TOP BAR =====
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 56)
topbar.BackgroundTransparency = 1
topbar.Parent = main

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 36, 0, 36)
logo.Position = UDim2.new(0, 14, 0, 10)
logo.BackgroundColor3 = Theme.Row
logo.Image = LOGO_IMAGE
logo.ScaleType = Enum.ScaleType.Crop
logo.Parent = topbar
corner(logo, 18)

-- Download the logo from GitHub (needs executor: writefile / getcustomasset / game:HttpGet)
local iconImage, icon -- filled in later when the floating icon is created
task.spawn(function()
	local ok, asset = pcall(function()
		writefile("r1yz_logo.jpg", game:HttpGet(LOGO_URL))
		return getcustomasset("r1yz_logo.jpg")
	end)
	if ok and asset then
		logo.Image = asset
		repeat task.wait() until iconImage
		iconImage.Image = asset
		iconImage.Visible = true
		icon.Text = ""
	end
end)

local title = label(topbar, HUB_NAME, 16, Theme.Text, Enum.Font.GothamBold)
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 58, 0, 0)

local versionPill = Instance.new("TextLabel")
versionPill.Size = UDim2.new(0, 66, 0, 30)
versionPill.Position = UDim2.new(1, -116, 0, 13)
versionPill.BackgroundColor3 = Theme.Row
versionPill.Text = VERSION
versionPill.TextColor3 = Theme.SubText
versionPill.TextSize = 13
versionPill.Font = Enum.Font.GothamMedium
versionPill.Parent = topbar
corner(versionPill, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 30)
closeBtn.Position = UDim2.new(1, -42, 0, 13)
closeBtn.BackgroundColor3 = Theme.Red
closeBtn.Text = "X"
closeBtn.TextColor3 = Theme.Text
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topbar
corner(closeBtn, 8)

makeDraggable(topbar, main)

--// ===== SIDEBAR =====
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, -66)
sidebar.Position = UDim2.new(0, 10, 0, 56)
sidebar.BackgroundColor3 = Theme.Sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = main
corner(sidebar, 10)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 6)
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 8)
sidePad.PaddingLeft = UDim.new(0, 8)
sidePad.PaddingRight = UDim.new(0, 8)
sidePad.Parent = sidebar

--// ===== CONTENT AREA =====
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -180, 1, -66)
content.Position = UDim2.new(0, 170, 0, 56)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}
local tabButtons = {}
local Holders = {} -- Holders["Main"] = the scrolling frame that holds that tab's rows

local function selectTab(name)
	for n, page in pairs(pages) do
		page.Visible = (n == name)
	end
	for n, btn in pairs(tabButtons) do
		btn.BackgroundColor3 = (n == name) and Theme.Accent or Theme.Sidebar
		btn.TextColor3 = (n == name) and Theme.Text or Theme.SubText
	end
end

-- CreateTab("Name", "subtitle")  -> makes the sidebar button AND the page
local function CreateTab(name, subtitle)
	-- sidebar button
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 38)
	b.BackgroundColor3 = Theme.Sidebar
	b.Text = "  " .. name
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.TextColor3 = Theme.SubText
	b.TextSize = 14
	b.Font = Enum.Font.GothamMedium
	b.AutoButtonColor = false
	b.Parent = sidebar
	corner(b, 8)
	tabButtons[name] = b
	b.MouseButton1Click:Connect(function()
		selectTab(name)
	end)

	-- page
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = content

	local t = label(page, name, 20, Theme.Text, Enum.Font.GothamBold)
	t.Size = UDim2.new(1, 0, 0, 26)
	t.Position = UDim2.new(0, 4, 0, 0)

	local s = label(page, subtitle or "", 12, Theme.SubText, Enum.Font.Gotham)
	s.Size = UDim2.new(1, 0, 0, 18)
	s.Position = UDim2.new(0, 4, 0, 28)

	local holder = Instance.new("ScrollingFrame")
	holder.Size = UDim2.new(1, 0, 1, -58)
	holder.Position = UDim2.new(0, 0, 0, 54)
	holder.BackgroundTransparency = 1
	holder.BorderSizePixel = 0
	holder.ScrollBarThickness = 3
	holder.AutomaticCanvasSize = Enum.AutomaticSize.Y
	holder.CanvasSize = UDim2.new(0, 0, 0, 0)
	holder.Parent = page

	local l = Instance.new("UIListLayout")
	l.Padding = UDim.new(0, 8)
	l.Parent = holder

	local p = Instance.new("UIPadding")
	p.PaddingRight = UDim.new(0, 6)
	p.Parent = holder

	pages[name] = page
	Holders[name] = holder
end

--// ===== EASY COMPONENTS (just pass the TAB NAME) =====
local function rowFrame(tabName, height)
	local r = Instance.new("Frame")
	r.Size = UDim2.new(1, 0, 0, height or 44)
	r.BackgroundColor3 = Theme.Row
	r.BorderSizePixel = 0
	r.ClipsDescendants = true
	r.Parent = Holders[tabName]
	corner(r, 8)
	return r
end

-- AddButton("Main", "Label", "ButtonText")
-- returns the button -> use  btn.MouseButton1Click:Connect(function() ... end)
local function AddButton(tabName, text, buttonText)
	local r = rowFrame(tabName)
	local l = label(r, text, 14)
	l.Size = UDim2.new(1, -120, 1, 0)
	l.Position = UDim2.new(0, 14, 0, 0)

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 90, 0, 28)
	b.Position = UDim2.new(1, -100, 0.5, -14)
	b.BackgroundColor3 = Theme.Accent
	b.Text = buttonText or "Click"
	b.TextColor3 = Theme.Text
	b.TextSize = 13
	b.Font = Enum.Font.GothamBold
	b.Parent = r
	corner(b, 6)
	return b
end

-- AddToggle("Main", "Label", defaultTrueFalse)
-- returns the toggle -> use  tog.MouseButton1Click:Connect(function() print(tog:GetAttribute("On")) end)
local function AddToggle(tabName, text, default)
	local state = default or false
	local r = rowFrame(tabName)
	local l = label(r, text, 14)
	l.Size = UDim2.new(1, -70, 1, 0)
	l.Position = UDim2.new(0, 14, 0, 0)

	local box = Instance.new("TextButton")
	box.Size = UDim2.new(0, 28, 0, 28)
	box.Position = UDim2.new(1, -42, 0.5, -14)
	box.Text = ""
	box.TextColor3 = Theme.Text
	box.TextSize = 16
	box.Font = Enum.Font.GothamBold
	box.AutoButtonColor = false
	box.Parent = r
	corner(box, 6)

	local function refresh()
		box.BackgroundColor3 = state and Theme.Green or Theme.Off
		box.Text = state and "✓" or ""
		box:SetAttribute("On", state)
	end
	refresh()

	box.MouseButton1Click:Connect(function()
		state = not state
		refresh()
	end)
	return box
end

-- AddDropdown("Main", "Label", {"A","B","C"})
-- returns dd -> use  dd.Changed:Connect(function(value) ... end)   and   dd.Get()
local function AddDropdown(tabName, text, options, default)
	local selected = default or options[1]
	local open = false
	local collapsed = 44
	local expanded = collapsed + (#options * 30) + 8

	local changed = Instance.new("BindableEvent")
	local r = rowFrame(tabName, collapsed)

	local l = label(r, text, 14)
	l.Size = UDim2.new(1, -170, 0, collapsed)
	l.Position = UDim2.new(0, 14, 0, 0)

	local header = Instance.new("TextButton")
	header.Size = UDim2.new(0, 140, 0, 28)
	header.Position = UDim2.new(1, -150, 0, 8)
	header.BackgroundColor3 = Theme.Off
	header.Text = selected .. "  ▾"
	header.TextColor3 = Theme.Text
	header.TextSize = 13
	header.Font = Enum.Font.GothamMedium
	header.Parent = r
	corner(header, 6)

	for i, opt in ipairs(options) do
		local ob = Instance.new("TextButton")
		ob.Size = UDim2.new(0, 140, 0, 26)
		ob.Position = UDim2.new(1, -150, 0, collapsed + (i - 1) * 30 - 2)
		ob.BackgroundColor3 = Theme.Off
		ob.Text = opt
		ob.TextColor3 = Theme.SubText
		ob.TextSize = 13
		ob.Font = Enum.Font.GothamMedium
		ob.Parent = r
		corner(ob, 6)

		ob.MouseButton1Click:Connect(function()
			selected = opt
			header.Text = selected .. "  ▾"
			open = false
			r.Size = UDim2.new(1, 0, 0, collapsed)
			changed:Fire(opt)
		end)
	end

	header.MouseButton1Click:Connect(function()
		open = not open
		r.Size = UDim2.new(1, 0, 0, open and expanded or collapsed)
	end)

	return {
		Changed = changed.Event,
		Get = function() return selected end,
	}
end

--// ===== TABS =====
CreateTab("HALLOWEN", "Main hub options.")
CreateTab("Settings", "Hub settings.")

--// ===== MAIN TAB (ADD YOUR STUFF HERE) =====
-- HOW TO USE:
--   1) Copy a block below (Button / Toggle / Dropdown) and change the names.
--   2) Write your code where it says "ADD YOUR FUNCTION BELOW".
-- Every block already has its callback, so you only add code inside it.

-- ===== BUTTON =====
local zone1B = AddButton("HALLOWEN", "zone1", "zone 1")
zone1B.MouseButton1Click:Connect(function()
	local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    char:PivotTo(CFrame.new(2164.13427734375, 459.2801208496094, 4553.05517578125)) -- X, Y, Z
    task.wait(0.5)
end)

local zone2B = AddButton("HALLOWEN", "zone2", "zone 2")
zone2B.MouseButton1Click:Connect(function()
	local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    char:PivotTo(CFrame.new(2164.13427734375, 459.2801208496094, 4553.05517578125)) -- X, Y, Z
    task.wait(0.5)
    char:PivotTo(CFrame.new(2164.189208984375, 1671.0390625, 4552.99462890625))
end)

local zone3B = AddButton("HALLOWEN", "zone3", "zone 3")
zone3B.MouseButton1Click:Connect(function()
	local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    char:PivotTo(CFrame.new(2164.13427734375, 459.2801208496094, 4553.05517578125)) -- X, Y, Z
    task.wait(1)

    char:PivotTo(CFrame.new(2215.18896484375, 1669.038818359375, 4502.49462890625)) -- X, Y, Z
    task.wait(1)


    char:PivotTo(CFrame.new(2210.173828125, 3742.257080078125, 4549.02099609375)) -- X, Y, Z
    task.wait(1)

end)

-- >>> PASTE NEW BUTTONS / TOGGLES / DROPDOWNS BELOW THIS LINE <<<

--// ===== FLOATING ICON =====
icon = Instance.new("TextButton")
icon.Name = "FloatingIcon"
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0, 20, 0.5, -25)
icon.BackgroundColor3 = Theme.Background
icon.Text = "R"
icon.TextColor3 = Theme.Text
icon.TextSize = 24
icon.Font = Enum.Font.GothamBold
icon.AutoButtonColor = true
icon.Parent = gui
corner(icon, 15) -- corner radius 15

iconImage = Instance.new("ImageLabel")
iconImage.Size = UDim2.new(1, 0, 1, 0)
iconImage.BackgroundTransparency = 1
iconImage.Image = LOGO_IMAGE
iconImage.ScaleType = Enum.ScaleType.Crop
iconImage.Visible = (LOGO_IMAGE ~= "")
iconImage.Active = false
iconImage.Parent = icon
corner(iconImage, 15) -- corner radius 15

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Theme.Accent
iconStroke.Thickness = 2
iconStroke.Parent = icon

-- Icon drag + click (click only fires if it wasn't dragged)
local iconDragging, iconMoved, iconStart, iconStartPos = false, false, nil, nil
icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		iconDragging = true
		iconMoved = false
		iconStart = input.Position
		iconStartPos = icon.Position
	end
end)
table.insert(connections, UserInputService.InputChanged:Connect(function(input)
	if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local d = input.Position - iconStart
		if d.Magnitude > 5 then iconMoved = true end
		icon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + d.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + d.Y)
	end
end))
table.insert(connections, UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		iconDragging = false
	end
end))

local function toggleGui()
	main.Visible = not main.Visible
end

icon.MouseButton1Click:Connect(function()
	if not iconMoved then
		toggleGui()
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
end)

--// ===== SETTINGS TAB =====
-- Keybind picker
local keyRow = rowFrame("Settings")
local keyLabel = label(keyRow, "Toggle Keybind", 14)
keyLabel.Size = UDim2.new(1, -150, 1, 0)
keyLabel.Position = UDim2.new(0, 14, 0, 0)

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0, 120, 0, 28)
keyBtn.Position = UDim2.new(1, -130, 0.5, -14)
keyBtn.BackgroundColor3 = Theme.Off
keyBtn.Text = toggleKey.Name
keyBtn.TextColor3 = Theme.Text
keyBtn.TextSize = 13
keyBtn.Font = Enum.Font.GothamBold
keyBtn.Parent = keyRow
corner(keyBtn, 6)

local listening = false
keyBtn.MouseButton1Click:Connect(function()
	listening = true
	keyBtn.Text = "Press a key..."
end)

table.insert(connections, UserInputService.InputBegan:Connect(function(input, processed)
	if listening then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode
			keyBtn.Text = toggleKey.Name
			listening = false
		end
		return
	end
	if not processed and input.KeyCode == toggleKey then
		toggleGui()
	end
end))

-- Destroy button (destroys GUI + floating icon)
local destroyBtn = AddButton("Settings", "Destroy GUI", "Destroy")
destroyBtn.BackgroundColor3 = Theme.Red
destroyBtn.MouseButton1Click:Connect(function()
	for _, c in ipairs(connections) do
		pcall(function() c:Disconnect() end)
	end
	gui:Destroy() -- removes main frame AND floating icon
end)

--// ===== START =====
selectTab("Main")