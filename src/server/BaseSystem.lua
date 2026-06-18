local GameConfig = require(script.Parent.Parent.shared.GameConfig)

local BaseSystem = {}

-- Create a player's base
function BaseSystem:CreatePlayerBase(baseFolder, baseIndex, player)
    local basePosition = GameConfig.BASE_POSITIONS[baseIndex]
    
    -- Create base container
    local baseModel = Instance.new("Model")
    baseModel.Name = "Base_" .. player.Name
    baseModel.Parent = baseFolder
    
    -- Create base platform
    local platform = Instance.new("Part")
    platform.Name = "Platform"
    platform.Size = Vector3.new(GameConfig.BASE_SIZE.X, 1, GameConfig.BASE_SIZE.Z)
    platform.Position = basePosition
    platform.Material = Enum.Material.Concrete
    platform.CanCollide = true
    platform.CFrame = CFrame.new(basePosition)
    platform.Parent = baseModel
    
    -- Create walls
    local wallHeight = GameConfig.BASE_SIZE.Y
    local walls = {}
    
    -- Front wall
    local frontWall = Instance.new("Part")
    frontWall.Name = "FrontWall"
    frontWall.Size = Vector3.new(GameConfig.BASE_SIZE.X, wallHeight, 1)
    frontWall.Position = basePosition + Vector3.new(0, wallHeight/2, GameConfig.BASE_SIZE.Z/2)
    frontWall.Material = Enum.Material.Brick
    frontWall.CanCollide = true
    frontWall.Parent = baseModel
    
    -- Back wall
    local backWall = Instance.new("Part")
    backWall.Name = "BackWall"
    backWall.Size = Vector3.new(GameConfig.BASE_SIZE.X, wallHeight, 1)
    backWall.Position = basePosition + Vector3.new(0, wallHeight/2, -GameConfig.BASE_SIZE.Z/2)
    backWall.Material = Enum.Material.Brick
    backWall.CanCollide = true
    backWall.Parent = baseModel
    
    -- Left wall
    local leftWall = Instance.new("Part")
    leftWall.Name = "LeftWall"
    leftWall.Size = Vector3.new(1, wallHeight, GameConfig.BASE_SIZE.Z)
    leftWall.Position = basePosition + Vector3.new(-GameConfig.BASE_SIZE.X/2, wallHeight/2, 0)
    leftWall.Material = Enum.Material.Brick
    leftWall.CanCollide = true
    leftWall.Parent = baseModel
    
    -- Right wall
    local rightWall = Instance.new("Part")
    rightWall.Name = "RightWall"
    rightWall.Size = Vector3.new(1, wallHeight, GameConfig.BASE_SIZE.Z)
    rightWall.Position = basePosition + Vector3.new(GameConfig.BASE_SIZE.X/2, wallHeight/2, 0)
    rightWall.Material = Enum.Material.Brick
    rightWall.CanCollide = true
    rightWall.Parent = baseModel
    
    -- Store base info
    local baseData = Instance.new("Folder")
    baseData.Name = "BaseData"
    baseData.Parent = baseModel
    
    local ownerValue = Instance.new("StringValue")
    ownerValue.Name = "Owner"
    ownerValue.Value = player.Name
    ownerValue.Parent = baseData
    
    return baseModel
end

-- Check if stealing is allowed for a base
function BaseSystem:CanStealFromBase(baseModel, attackingPlayer, attackerData)
    local baseData = baseModel:FindFirstChild("BaseData")
    if not baseData then return false end
    
    -- Check if attacker has stealing enabled
    if not attackerData.stealingEnabled then
        return false
    end
    
    -- Check if target has stealing defense enabled
    local stealValue = baseData:FindFirstChild("StealingEnabled")
    if stealValue and stealValue.Value == true then
        return true
    end
    
    return false
end

-- Get items from a base (with permission)
function BaseSystem:StealFromBase(baseModel, itemType)
    local baseData = baseModel:FindFirstChild("BaseData")
    if not baseData then return nil end
    
    local inventory = baseData:FindFirstChild("Inventory")
    if not inventory or #inventory:GetChildren() == 0 then
        return nil
    end
    
    local item = inventory:GetChildren()[1]
    item.Parent = nil
    return item
end

return BaseSystem
