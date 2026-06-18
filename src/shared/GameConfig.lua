local GameConfig = {}

-- Player base configuration
GameConfig.MAX_PLAYERS = 6
GameConfig.BASE_SIZE = Vector3.new(50, 30, 50)

-- Brainrot enemy types with RNG stats
GameConfig.BRAINROT_TYPES = {
    SKIBIDI = {
        name = "Skibidi",
        healthRange = {10, 25},
        damageRange = {1, 3},
        rarityChance = 0.6, -- 60% spawn rate
        reward = 50,
        color = Color3.fromRGB(255, 0, 0)
    },
    SIGMA = {
        name = "Sigma",
        healthRange = {20, 40},
        damageRange = {2, 5},
        rarityChance = 0.25, -- 25% spawn rate
        reward = 100,
        color = Color3.fromRGB(255, 165, 0)
    },
    GYATT = {
        name = "Gyatt",
        healthRange = {30, 60},
        damageRange = {3, 7},
        rarityChance = 0.1, -- 10% spawn rate
        reward = 250,
        color = Color3.fromRGB(255, 255, 0)
    },
    OHIO = {
        name = "Ohio",
        healthRange = {50, 100},
        damageRange = {5, 10},
        rarityChance = 0.04, -- 4% spawn rate
        reward = 500,
        color = Color3.fromRGB(0, 255, 0)
    },
    MEWING = {
        name = "Mewing",
        healthRange = {80, 150},
        damageRange = {7, 15},
        rarityChance = 0.01, -- 1% spawn rate (LEGENDARY)
        reward = 1000,
        color = Color3.fromRGB(0, 0, 255)
    }
}

-- Sword progression
GameConfig.SWORDS = {
    WOODEN = {
        name = "Wooden Sword",
        damageBase = 1,
        attackSpeed = 1.5,
        cost = 0, -- Starting sword
        color = Color3.fromRGB(139, 69, 19)
    },
    STONE = {
        name = "Stone Sword",
        damageBase = 2,
        attackSpeed = 1.4,
        cost = 100
    },
    IRON = {
        name = "Iron Sword",
        damageBase = 4,
        attackSpeed = 1.3,
        cost = 300
    },
    DIAMOND = {
        name = "Diamond Sword",
        damageBase = 7,
        attackSpeed = 1.2,
        cost = 800
    },
    LEGENDARY = {
        name = "Legendary Sword",
        damageBase = 12,
        attackSpeed = 1.0,
        cost = 2000
    }
}

-- Upgrade costs
GameConfig.UPGRADE_COSTS = {
    damage = 50,
    speed = 75
}

-- Base positions (arranged in a circle)
GameConfig.BASE_POSITIONS = {
    Vector3.new(0, 0, -100),
    Vector3.new(100, 0, -50),
    Vector3.new(100, 0, 50),
    Vector3.new(0, 0, 100),
    Vector3.new(-100, 0, 50),
    Vector3.new(-100, 0, -50)
}

return GameConfig
