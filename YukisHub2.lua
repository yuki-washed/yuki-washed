if not game:IsLoaded() then game.Loaded:Wait() end

-- GUI Library (we're using "Simple GUI")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Window Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Ghous_Yuki Hub"
titleLabel.Font = Enum.Font.Gotham
titleLabel.TextSize = 20
titleLabel.TextCentered = true
titleLabel.Parent = mainFrame

-- Toggle Variables
local godModeEnabled = false
local autoFarmEnabled = false
local autoRetryEnabled = false
local killAllEnabled = false
local fastHoverEnabled = false

-- Function to toggle GodMode
local function enableGodMode()
    if godModeEnabled then
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = math.huge
        end
    end
end

-- Function for AutoFarm
local function autoFarm()
    if autoFarmEnabled then
        for _, titan in pairs(workspace:GetChildren()) do
            if titan.Name == "Titan" and titan:FindFirstChild("Humanoid") then
                firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, titan.PrimaryPart, 0)
                wait(0.1)
                firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, titan.PrimaryPart, 1)
            end
        end
    end
end

-- Function to Auto Retry (if knocked out)
local function autoRetry()
    if autoRetryEnabled then
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health == 0 then
            wait(2)
            game.ReplicatedStorage:WaitForChild("Respawn"):FireServer()
        end
    end
end

-- Function to Kill All Enemies
local function killAll()
    if killAllEnabled then
        for _, target in pairs(workspace:GetChildren()) do
            if target:IsA("Model") and target:FindFirstChild("Humanoid") then
                firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, target.PrimaryPart, 0)
                wait(0.1)
                firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, target.PrimaryPart, 1)
            end
        end
    end
end

-- Super-fast Hover Function
local function fastHover()
    if fastHoverEnabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 500, 0)
        bodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    end
end

-- GUI Elements (Toggle Buttons)
local function createToggleButton(name, position, toggleVar)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 250, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.Gotham
    button.TextSize = 18
    button.Parent = mainFrame
    
    button.MouseButton1Click:Connect(function()
        toggleVar = not toggleVar
        if toggleVar then
            button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)
end

-- Create GUI Buttons
createToggleButton("GodMode", UDim2.new(0, 25, 0, 60), godModeEnabled)
createToggleButton("AutoFarm", UDim2.new(0, 25, 0, 120), autoFarmEnabled)
createToggleButton("Auto Retry", UDim2.new(0, 25, 0, 180), autoRetryEnabled)
createToggleButton("Kill All", UDim2.new(0, 25, 0, 240), killAllEnabled)
createToggleButton("Fast Hover", UDim2.new(0, 25, 0, 300), fastHoverEnabled)

-- Main Execution Loop
while true do
    wait(1) -- Main loop delay to reduce lag

    enableGodMode() -- Check GodMode status
    autoFarm() -- Perform Auto Farming
    autoRetry() -- Check AutoRetry (respawn if knocked out)
    killAll() -- Kill All Enemies (Titan, Raid Boss)
    fastHover() -- Perform Fast Hover movement
end
