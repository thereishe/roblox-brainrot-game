local GameConfig = require(script.Parent.Parent.shared.GameConfig)

local ShopSystem = {}

-- Check if player can afford sword
function ShopSystem:CanAffordSword(playerData, swordType)
    local swordConfig = GameConfig.SWORDS[swordType]
    if not swordConfig then return false end
    
    return playerData.coins >= swordConfig.cost
end

-- Purchase a sword
function ShopSystem:BuySword(playerData, swordType)
    if not self:CanAffordSword(playerData, swordType) then
        return false, "Not enough coins"
    end
    
    local swordConfig = GameConfig.SWORDS[swordType]
    playerData.coins = playerData.coins - swordConfig.cost
    playerData.sword = swordType
    
    return true, "Purchased " .. swordConfig.name
end

-- Upgrade sword damage
function ShopSystem:UpgradeDamage(playerData)
    if playerData.coins < GameConfig.UPGRADE_COSTS.damage then
        return false, "Not enough coins for damage upgrade"
    end
    
    playerData.coins = playerData.coins - GameConfig.UPGRADE_COSTS.damage
    playerData.swordUpgrades.damage = playerData.swordUpgrades.damage + 1
    
    return true, "Upgraded damage! Level: " .. playerData.swordUpgrades.damage
end

-- Upgrade sword speed
function ShopSystem:UpgradeSpeed(playerData)
    if playerData.coins < GameConfig.UPGRADE_COSTS.speed then
        return false, "Not enough coins for speed upgrade"
    end
    
    playerData.coins = playerData.coins - GameConfig.UPGRADE_COSTS.speed
    playerData.swordUpgrades.speed = playerData.swordUpgrades.speed + 1
    
    return true, "Upgraded speed! Level: " .. playerData.swordUpgrades.speed
end

-- Get shop menu data
function ShopSystem:GetShopMenu()
    return GameConfig.SWORDS
end

return ShopSystem
