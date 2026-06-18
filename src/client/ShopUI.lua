local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GameConfig = require(game.ReplicatedStorage.GameConfig)

local ShopUI = {}

-- Create shop UI
function ShopUI:CreateUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShopUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local shopFrame = Instance.new("Frame")
    shopFrame.Name = "ShopFrame"
    shopFrame.Size = UDim2.new(0.4, 0, 0.7, 0)
    shopFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
    shopFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    shopFrame.BorderSizePixel = 0
    shopFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = "⚔️ SWORD SHOP"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = shopFrame
    
    -- Coins display
    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Name = "CoinsLabel"
    coinsLabel.Text = "Coins: 0"
    coinsLabel.Size = UDim2.new(1, 0, 0.08, 0)
    coinsLabel.Position = UDim2.new(0, 0, 0.1, 0)
    coinsLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    coinsLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    coinsLabel.TextScaled = true
    coinsLabel.Font = Enum.Font.Gotham
    coinsLabel.Parent = shopFrame
    
    -- Swords section
    local swordsLabel = Instance.new("TextLabel")
    swordsLabel.Name = "SwordsLabel"
    swordsLabel.Text = "SWORDS"
    swordsLabel.Size = UDim2.new(1, 0, 0.08, 0)
    swordsLabel.Position = UDim2.new(0, 0, 0.18, 0)
    swordsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    swordsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    swordsLabel.TextScaled = true
    swordsLabel.Font = Enum.Font.GothamBold
    swordsLabel.Parent = shopFrame
    
    local yPos = 0.26
    for swordType, config in pairs(GameConfig.SWORDS) do
        local container = Instance.new("Frame")
        container.Size = UDim2.new(0.95, 0, 0.1, 0)
        container.Position = UDim2.new(0.025, 0, yPos, 0)
        container.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        container.BorderSizePixel = 0
        container.Parent = shopFrame
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Text = config.name .. " - " .. config.cost .. " coins"
        nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.Parent = container
        
        local buyButton = Instance.new("TextButton")
        buyButton.Text = "BUY"
        buyButton.Size = UDim2.new(0.35, 0, 1, 0)
        buyButton.Position = UDim2.new(0.65, 0, 0, 0)
        buyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyButton.TextScaled = true
        buyButton.Font = Enum.Font.GothamBold
        buyButton.BorderSizePixel = 0
        buyButton.Parent = container
        
        buyButton.MouseButton1Click:Connect(function()
            game.ReplicatedStorage:WaitForChild("ShopRemote"):InvokeServer("BUY_SWORD", swordType)
        end)
        
        yPos = yPos + 0.12
    end
    
    -- Upgrades section
    local upgradesLabel = Instance.new("TextLabel")
    upgradesLabel.Name = "UpgradesLabel"
    upgradesLabel.Text = "UPGRADES"
    upgradesLabel.Size = UDim2.new(1, 0, 0.08, 0)
    upgradesLabel.Position = UDim2.new(0, 0, 0.72, 0)
    upgradesLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    upgradesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    upgradesLabel.TextScaled = true
    upgradesLabel.Font = Enum.Font.GothamBold
    upgradesLabel.Parent = shopFrame
    
    local damageUpgradeButton = Instance.new("TextButton")
    damageUpgradeButton.Text = "Upgrade Damage (" .. GameConfig.UPGRADE_COSTS.damage .. ")"
    damageUpgradeButton.Size = UDim2.new(0.95, 0, 0.08, 0)
    damageUpgradeButton.Position = UDim2.new(0.025, 0, 0.8, 0)
    damageUpgradeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    damageUpgradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    damageUpgradeButton.TextScaled = true
    damageUpgradeButton.Font = Enum.Font.Gotham
    damageUpgradeButton.BorderSizePixel = 0
    damageUpgradeButton.Parent = shopFrame
    
    damageUpgradeButton.MouseButton1Click:Connect(function()
        game.ReplicatedStorage:WaitForChild("ShopRemote"):InvokeServer("UPGRADE_DAMAGE")
    end)
    
    local speedUpgradeButton = Instance.new("TextButton")
    speedUpgradeButton.Text = "Upgrade Speed (" .. GameConfig.UPGRADE_COSTS.speed .. ")"
    speedUpgradeButton.Size = UDim2.new(0.95, 0, 0.08, 0)
    speedUpgradeButton.Position = UDim2.new(0.025, 0, 0.89, 0)
    speedUpgradeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
    speedUpgradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedUpgradeButton.TextScaled = true
    speedUpgradeButton.Font = Enum.Font.Gotham
    speedUpgradeButton.BorderSizePixel = 0
    speedUpgradeButton.Parent = shopFrame
    
    speedUpgradeButton.MouseButton1Click:Connect(function()
        game.ReplicatedStorage:WaitForChild("ShopRemote"):InvokeServer("UPGRADE_SPEED")
    end)
    
    return screenGui
end

return ShopUI
