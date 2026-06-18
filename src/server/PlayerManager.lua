local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

local PlayerManager = {}
local assignedBases = {}
local playerBaseIndex = {}

-- Find available base slot
function PlayerManager:GetAvailableBaseIndex()
    for i = 1, 6 do
        if not assignedBases[i] then
            return i
        end
    end
    return nil -- Server is full
end

-- Save player data to DataStore
function PlayerManager:SavePlayerData(player, playerData)
    local success, err = pcall(function()
        playerDataStore:SetAsync("Player_" .. player.UserId, playerData)
    end)
    
    if not success then
        warn("Failed to save player data for " .. player.Name .. ": " .. err)
    end
    return success
end

-- Load player data from DataStore
function PlayerManager:LoadPlayerData(player)
    local data
    local success, err = pcall(function()
        data = playerDataStore:GetAsync("Player_" .. player.UserId)
    end)
    
    if not success then
        warn("Failed to load player data for " .. player.Name .. ": " .. err)
        return nil
    end
    
    return data
end

-- Initialize player in game
function PlayerManager:InitializePlayer(player)
    local baseIndex = self:GetAvailableBaseIndex()
    
    if not baseIndex then
        player:Kick("Server is full (max 6 players)")
        return false
    end
    
    assignedBases[baseIndex] = player.UserId
    playerBaseIndex[player.UserId] = baseIndex
    
    return true, baseIndex
end

-- Clean up player on leave
function PlayerManager:RemovePlayer(player)
    local baseIndex = playerBaseIndex[player.UserId]
    if baseIndex then
        assignedBases[baseIndex] = nil
        playerBaseIndex[player.UserId] = nil
    end
end

-- Get player's assigned base
function PlayerManager:GetPlayerBaseIndex(player)
    return playerBaseIndex[player.UserId]
end

return PlayerManager
