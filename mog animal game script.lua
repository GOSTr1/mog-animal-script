
-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI state
local enabled = false
local destroyed = false

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AppealGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main frame
local background = Instance.new("Frame")
background.Name = "MainFrame"
background.Size = UDim2.new(0, 440, 0, 300)
background.Position = UDim2.new(0, 20, 0.5, -150)
background.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
background.BorderSizePixel = 0
background.Active = true
background.Parent = screenGui

local backgroundCorner = Instance.new("UICorner")
backgroundCorner.CornerRadius = UDim.new(0, 10)
backgroundCorner.Parent = background

-- Title bar
local titleBar = Instance.new("TextLabel")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
titleBar.BorderSizePixel = 0
titleBar.Text = "  APPEAL MENU"
titleBar.TextColor3 = Color3.new(1, 1, 1)
titleBar.TextSize = 16
titleBar.Font = Enum.Font.GothamBold
titleBar.TextXAlignment = Enum.TextXAlignment.Left
titleBar.Active = true
titleBar.Parent = background

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.Size = UDim2.new(0, 110, 1, -35)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 36, 53)
sidebar.BorderSizePixel = 0
sidebar.Parent = background

local function createButton(parent, name, text, size, position, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    return button
end

-- Sidebar navigation buttons
local mainNav = createButton(
    sidebar, "MainNavigation", "Main",
    UDim2.new(1, -16, 0, 35),
    UDim2.new(0, 8, 0, 15),
    Color3.fromRGB(50, 100, 170)
)

local exitNav = createButton(
    sidebar, "ExitNavigation", "Exit",
    UDim2.new(1, -16, 0, 35),
    UDim2.new(0, 8, 0, 58),
    Color3.fromRGB(130, 55, 65)
)

-- Content area
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 110, 0, 35)
content.Size = UDim2.new(1, -110, 1, -35)
content.BackgroundTransparency = 1
content.Parent = background

-- Main page
local mainPage = Instance.new("Frame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, 0, 1, 0)
mainPage.BackgroundTransparency = 1
mainPage.Parent = content

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, -20, 0, 30)
mainTitle.Position = UDim2.new(0, 10, 0, 10)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "Main Menu"
mainTitle.TextColor3 = Color3.new(1, 1, 1)
mainTitle.TextSize = 20
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.Parent = mainPage

-- Auto Appeal button
local autoAppeal = createButton(
    mainPage, "AutoAppeal", "Auto Appeal: OFF",
    UDim2.new(0, 275, 0, 40),
    UDim2.new(0, 15, 0, 55),
    Color3.fromRGB(55, 65, 100)
)

-- Auto Rebirth button
local autoRebirth = createButton(
    mainPage,
    "AutoRebirth",
    "Auto Rebirth: OFF",
    UDim2.new(0, 275, 0, 40),
    UDim2.new(0, 15, 0, 115),
    Color3.fromRGB(55, 65, 100)
)

local rebirthEnabled = false

-- Five individually created buttons
local button5 = createButton(
    mainPage, "Button5", "+500m wins OF",
    UDim2.new(0, 100, 0, 30),
    UDim2.new(0, 110, 0, 165),
    Color3.fromRGB(55, 65, 100)
)
local button5Enabled = false

-- Individual button functions
button5.Activated:Connect(function()
    if destroyed then
      return
    end
    button5Enabled = not button5Enabled

    if button5Enabled then
        button5.Text = "+500m wins: ON"
        

        task.spawn(function()
            while button5Enabled and not destroyed do
                local character = player.Character or player.CharacterAdded:Wait()
                local root = character:WaitForChild("HumanoidRootPart")
                root.CFrame = CFrame.new(20.4961834, 18.3256912, 491.234436)
                task.wait(1)
            end
        end)
    else
        button5.Text = "+500m wins OF"
        
    end
end)

-- Auto Appeal ON/OFF toggle
autoAppeal.Activated:Connect(function()
    if destroyed then
        return
    end

    enabled = not enabled

    if enabled then
        autoAppeal.Text = "Auto Appeal: ON"
        autoAppeal.BackgroundColor3 = Color3.fromRGB(35, 150, 95)

        task.spawn(function()
            while enabled and not destroyed do
                local args = {
                 "ManualClick",
                 {}
               }

                game:GetService("ReplicatedStorage")
                  :WaitForChild("MogUIAction")
                  :FireServer(unpack(args))

                task.wait(0.1)
            end
        end)
    else
        autoAppeal.Text = "Auto Appeal: OFF"
        autoAppeal.BackgroundColor3 = Color3.fromRGB(55, 65, 100)
    end
end)

autoRebirth.Activated:Connect(function()
    if destroyed then
        return
    end

    rebirthEnabled = not rebirthEnabled

    if rebirthEnabled then
        autoRebirth.Text = "Auto Rebirth: ON"
        autoRebirth.BackgroundColor3 = Color3.fromRGB(35, 150, 95)

        task.spawn(function()
            while rebirthEnabled and not destroyed do
                local args = {
	              "Rebirth",
	                {}
                }  
                 game:GetService("ReplicatedStorage")
                   :WaitForChild("MogUIAction")
                   :FireServer(unpack(args))
                 task.wait(1)
            end
        end)
    else
        autoRebirth.Text = "Auto Rebirth: OFF"
        autoRebirth.BackgroundColor3 = Color3.fromRGB(55, 65, 100)
    end
end)

-- Exit page
local exitPage = Instance.new("Frame")
exitPage.Name = "ExitPage"
exitPage.Size = UDim2.new(1, 0, 1, 0)
exitPage.BackgroundTransparency = 1
exitPage.Visible = false
exitPage.Parent = content

local exitTitle = Instance.new("TextLabel")
exitTitle.Size = UDim2.new(1, -20, 0, 35)
exitTitle.Position = UDim2.new(0, 10, 0, 15)
exitTitle.BackgroundTransparency = 1
exitTitle.Text = "Exit Menu"
exitTitle.TextColor3 = Color3.new(1, 1, 1)
exitTitle.TextSize = 20
exitTitle.Font = Enum.Font.GothamBold
exitTitle.TextXAlignment = Enum.TextXAlignment.Left
exitTitle.Parent = exitPage

local closeButton = createButton(
    exitPage, "CloseGUI", "Close GUI",
    UDim2.new(0, 180, 0, 40),
    UDim2.new(0, 15, 0, 65),
    Color3.fromRGB(170, 55, 65)
)

local backButton = createButton(
    exitPage, "BackToMain", "Back to Main",
    UDim2.new(0, 180, 0, 40),
    UDim2.new(0, 15, 0, 115),
    Color3.fromRGB(50, 100, 170)
)

-- Page navigation
local function showMain()
    mainPage.Visible = true
    exitPage.Visible = false
end

local function showExit()
    mainPage.Visible = false
    exitPage.Visible = true
end

mainNav.Activated:Connect(showMain)
exitNav.Activated:Connect(showExit)
backButton.Activated:Connect(showMain)

-- Close GUI and stop any running loop
closeButton.Activated:Connect(function()
    destroyed = true
    enabled = false
    screenGui:Destroy()
end)

-- Drag the GUI by its title bar
local dragging = false
local dragStart
local startPosition
local dragInput

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = background.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input == dragInput
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart

        background.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)
