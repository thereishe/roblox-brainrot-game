local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GameConfig = require(game.ReplicatedStorage.GameConfig)

local EnemySelector = {}

-- Create UI for enemy selection
function EnemySelector:CreateUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EnemySelectorUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local selectorFrame = Instance.new("Frame")
    selectorFrame.Name = "SelectorFrame"
    selectorFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
    selectorFrame.Position = UDim2.new(0, 10, 0.5, -0.25)
    selectorFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    selectorFrame.BorderSizePixel = 0
    selectorFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = "SELECT ENEMY"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = selectorFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = selectorFrame
    
    -- Create buttons for each enemy type
    local yPos = 0.15
    for enemyType, config in pairs(GameConfig.BRAINROT_TYPES) do
        local button = Instance.new("TextButton")
        button.Name = enemyType
        button.Text = config.name .. " (" .. (config.rarityChance * 100) .. "%)"
        button.Size = UDim2.new(0.9, 0, 0.12, 0)
        button.Position = UDim2.new(0.05, 0, yPos, 0)
        button.BackgroundColor3 = config.color
        button.TextColor3 = Color3.fromRGB(0, 0, 0)
        button.TextScaled = true
        button.Font = Enum.Font.Gotham
        button.BorderSizePixel = 0
        button.Parent = selectorFrame
        
        button.MouseButton1Click:Connect(function()
            game.ReplicatedStorage:WaitForChild("CombatRemote"):InvokeServer("FIGHT", enemyType)
        end)
        
        yPos = yPos + 0.15
    end
    
    return screenGui
end

return EnemySelector
