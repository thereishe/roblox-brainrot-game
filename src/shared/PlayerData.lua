local PlayerData = {}

-- Default player stats when they first join
local DEFAULT_PLAYER_DATA = {
    coins = 200,
    sword = "WOODEN",
    swordUpgrades = {
        damage = 0,
        speed = 0
    },
    baseIndex = nil, -- Will be assigned on spawn
    stealingEnabled = false,
    baseLocked = false,
    defeatedEnemies = {}, -- Table of defeated brainrot enemies in their base
    lastSave = os.time()
}

function PlayerData:CreateNewPlayer()
    return table.clone(DEFAULT_PLAYER_DATA)
end

function PlayerData:GetDefaultData()
    return DEFAULT_PLAYER_DATA
end

-- Validate player data structure
function PlayerData:Validate(data)
    if not data then return false end
    if not data.coins or not data.sword or not data.swordUpgrades then
        return false
    end
    return true
end

return PlayerData
