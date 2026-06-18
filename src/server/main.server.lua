local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

local PlayerManager = require(script.Parent.PlayerManager)
local CombatSystem = require(script.Parent.CombatSystem)
local ShopSystem = require(script.Parent.ShopSystem)
local BaseSystem = require(script.Parent.BaseSystem)
local MapBuilder = require(script.Parent.MapBuilder)
local GameConfig = require(script.Parent.Parent.shared.GameConfig)
local PlayerData = require(script.Parent.Parent.shared.PlayerData)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Build the map
MapBuilder:BuildMap()

-- Create RemoteFunctions/Events for client-server communication
local combatRemote = Instance.new("RemoteFunction")
combatRemote.Name = "CombatRemote"
combatRemote.Parent = ReplicatedStorage

local shopRemote = Instance.new("RemoteFunction")
shopRemote.Name = "ShopRemote"
shopRemote.Parent = ReplicatedStorage

local dataRemote = Instance.new("RemoteFunction")
dataRemote.Name = "DataRemote"
dataRemote.Parent = ReplicatedStorage

-- Store player data in memory
local playerDataCache = {}

local basesFolder = Instance.new("Folder")
basesFolder.Name = "PlayerBases"
basesFolder.Parent = workspace

-- Handle player joining
Players.PlayerAdded:Connect(function(player)
    print("Player joined: " .. player.Name)
    
    -- Initialize player
    local success, baseIndex = PlayerManager:InitializePlayer(player)
    
    if not success then
        return
    end
    
    -- Load or create player data
    local data = PlayerManager:LoadPlayerData(player)
    if not data then
        data = PlayerData:CreateNewPlayer()
    end
    
    data.baseIndex = baseIndex
    playerDataCache[player.UserId] = data
    
    -- Create player base
    local baseModel = BaseSystem:CreatePlayerBase(basesFolder, baseIndex, player)
    
    print("Base created for " .. player.Name .. " at index " .. baseIndex)
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
    print("Player left: " .. player.Name)
    
    -- Save player data
    local data = playerDataCache[player.UserId]
    if data then
        PlayerManager:SavePlayerData(player, data)
    end
    
    -- Clean up
    PlayerManager:RemovePlayer(player)
    playerDataCache[player.UserId] = nil
end)

-- Combat system
function combatRemote:InvokeServer(action, ...)
    local player = Players:FindFirstChild(self)
    if not player then return false end
    
    local data = playerDataCache[player.UserId]
    if not data then return false end
    
    if action == "FIGHT" then
        local enemyType = ...
        local success, enemy = CombatSystem:FightEnemy(player, data, enemyType)
        
        if success then
            print(player.Name .. " defeated " .. enemy.name .. "! Earned " .. enemy.reward .. " coins")
            return true, enemy.name, enemy.reward
        else
            print(player.Name .. " lost to " .. enemy.name)
            return false, "You were defeated!"
        end
    end
    
    return false
end

-- Shop system
function shopRemote:InvokeServer(action, ...)
    local player = Players:FindFirstChild(self)
    if not player then return false end
    
    local data = playerDataCache[player.UserId]
    if not data then return false end
    
    if action == "BUY_SWORD" then
        local swordType = ...
        local success, message = ShopSystem:BuySword(data, swordType)
        return success, message
    elseif action == "UPGRADE_DAMAGE" then
        local success, message = ShopSystem:UpgradeDamage(data)
        return success, message
    elseif action == "UPGRADE_SPEED" then
        local success, message = ShopSystem:UpgradeSpeed(data)
        return success, message
    end
    
    return false
end

-- Data retrieval
function dataRemote:InvokeServer(action, ...)
    local player = Players:FindFirstChild(self)
    if not player then return end
    
    local data = playerDataCache[player.UserId]
    if not data then return end
    
    if action == "GET_DATA" then
        return {
            coins = data.coins,
            sword = data.sword,
            upgrades = data.swordUpgrades,
            baseIndex = data.baseIndex
        }
    end
end

print("🧠 Brainrot Game Server Started!")
print("📍 Map loaded with arena, spawn areas, trees, rocks, water, and decorations!")
print("⚔️ Combat system ready")
print("🏪 Shop system ready")
print("🏠 Base system ready for 6 players")
