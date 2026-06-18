local GameConfig = require(script.Parent.Parent.shared.GameConfig)

local CombatSystem = {}

-- Generate RNG enemy stats
function CombatSystem:GenerateEnemy(enemyType)
    local config = GameConfig.BRAINROT_TYPES[enemyType]
    
    if not config then
        error("Unknown enemy type: " .. enemyType)
    end
    
    local healthRange = config.healthRange
    local damageRange = config.damageRange
    
    return {
        type = enemyType,
        name = config.name,
        health = math.random(healthRange[1], healthRange[2]),
        maxHealth = math.random(healthRange[1], healthRange[2]),
        damage = math.random(damageRange[1], damageRange[2]),
        reward = config.reward,
        color = config.color
    }
end

-- Calculate damage based on sword and upgrades
function CombatSystem:CalculateDamage(swordType, upgrades)
    local swordConfig = GameConfig.SWORDS[swordType]
    if not swordConfig then return 1 end
    
    local baseDamage = swordConfig.damageBase
    local upgradedDamage = baseDamage + upgrades.damage
    
    -- Add RNG variance (±20%)
    local variance = math.random(-20, 20) / 100
    return math.max(1, math.floor(upgradedDamage * (1 + variance)))
end

-- Calculate attack speed
function CombatSystem:GetAttackSpeed(swordType, upgrades)
    local swordConfig = GameConfig.SWORDS[swordType]
    if not swordConfig then return 1 end
    
    local baseSpeed = swordConfig.attackSpeed
    local speedBonus = upgrades.speed * 0.05 -- 5% per upgrade
    
    return math.max(0.2, baseSpeed - speedBonus)
end

-- Execute one attack
function CombatSystem:DealDamage(enemy, damage)
    enemy.health = enemy.health - damage
    return enemy.health <= 0
end

-- Process full combat encounter
function CombatSystem:FightEnemy(player, playerData, enemyType)
    local enemy = self:GenerateEnemy(enemyType)
    local attackSpeed = self:GetAttackSpeed(playerData.sword, playerData.swordUpgrades)
    local isDefeated = false
    local turns = 0
    local maxTurns = 100 -- Prevent infinite loops
    
    while enemy.health > 0 and turns < maxTurns do
        -- Player attacks
        local damage = self:CalculateDamage(playerData.sword, playerData.swordUpgrades)
        isDefeated = self:DealDamage(enemy, damage)
        
        if isDefeated then
            break
        end
        
        -- Enemy attacks back
        local enemyDamage = math.random(1, enemy.damage)
        playerData.health = (playerData.health or 100) - enemyDamage
        
        if playerData.health <= 0 then
            return false, enemy -- Player lost
        end
        
        turns = turns + 1
    end
    
    if isDefeated then
        playerData.coins = playerData.coins + enemy.reward
        table.insert(playerData.defeatedEnemies, {
            type = enemy.type,
            name = enemy.name,
            timestamp = os.time()
        })
        return true, enemy
    else
        return false, nil
    end
end

return CombatSystem
