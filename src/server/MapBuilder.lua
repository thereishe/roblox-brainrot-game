local MapBuilder = {}

-- Create the main game map
function MapBuilder:BuildMap()
    local map = Instance.new("Folder")
    map.Name = "GameMap"
    map.Parent = workspace
    
    -- Create terrain
    self:CreateTerrain(map)
    
    -- Create arena
    self:CreateArena(map)
    
    -- Create spawn area
    self:CreateSpawnArea(map)
    
    -- Create environmental features
    self:CreateEnvironment(map)
    
    -- Create decorations
    self:CreateDecorations(map)
    
    -- Set up lighting
    self:SetupLighting()
    
    return map
end

function MapBuilder:CreateTerrain(parent)
    local terrain = Instance.new("Folder")
    terrain.Name = "Terrain"
    terrain.Parent = parent
    
    -- Base ground platform
    local groundPlane = Instance.new("Part")
    groundPlane.Name = "GroundPlane"
    groundPlane.Shape = Enum.PartType.Block
    groundPlane.Size = Vector3.new(300, 1, 300)
    groundPlane.Position = Vector3.new(0, 0, 0)
    groundPlane.Material = Enum.Material.Grass
    groundPlane.TopSurface = Enum.SurfaceType.Smooth
    groundPlane.BottomSurface = Enum.SurfaceType.Smooth
    groundPlane.CanCollide = true
    groundPlane.CFrame = CFrame.new(0, -1, 0)
    groundPlane.Parent = terrain
    
    -- Create ground variations with grass and dirt patches
    for i = 1, 8 do
        local angle = (i / 8) * math.pi * 2
        local x = math.cos(angle) * 80
        local z = math.sin(angle) * 80
        
        local dirtPatch = Instance.new("Part")
        dirtPatch.Name = "DirtPatch_" .. i
        dirtPatch.Shape = Enum.PartType.Block
        dirtPatch.Size = Vector3.new(40, 0.5, 40)
        dirtPatch.Position = Vector3.new(x, 0.25, z)
        dirtPatch.Material = Enum.Material.Ground
        dirtPatch.TopSurface = Enum.SurfaceType.Smooth
        dirtPatch.BottomSurface = Enum.SurfaceType.Smooth
        dirtPatch.CanCollide = false
        dirtPatch.Parent = terrain
    end
end

function MapBuilder:CreateArena(parent)
    local arena = Instance.new("Folder")
    arena.Name = "Arena"
    arena.Parent = parent
    
    -- Central arena platform where combat happens
    local arenaPlatform = Instance.new("Part")
    arenaPlatform.Name = "ArenaPlatform"
    arenaPlatform.Shape = Enum.PartType.Block
    arenaPlatform.Size = Vector3.new(80, 1, 80)
    arenaPlatform.Position = Vector3.new(0, 1, 0)
    arenaPlatform.Material = Enum.Material.Concrete
    arenaPlatform.Color = Color3.fromRGB(100, 100, 100)
    arenaPlatform.TopSurface = Enum.SurfaceType.Smooth
    arenaPlatform.BottomSurface = Enum.SurfaceType.Smooth
    arenaPlatform.CanCollide = true
    arenaPlatform.Parent = arena
    
    -- Arena boundary walls
    local boundarySize = 90
    for i = 1, 4 do
        local wallPart = Instance.new("Part")
        wallPart.Name = "ArenaBoundary_" .. i
        wallPart.Shape = Enum.PartType.Block
        wallPart.Size = Vector3.new(boundarySize, 5, 2)
        wallPart.Material = Enum.Material.Neon
        wallPart.CanCollide = true
        wallPart.TopSurface = Enum.SurfaceType.Smooth
        wallPart.BottomSurface = Enum.SurfaceType.Smooth
        
        if i == 1 then
            wallPart.Color = Color3.fromRGB(255, 0, 0)
            wallPart.Position = Vector3.new(0, 3, boundarySize/2)
        elseif i == 2 then
            wallPart.Color = Color3.fromRGB(0, 255, 0)
            wallPart.Position = Vector3.new(0, 3, -boundarySize/2)
        elseif i == 3 then
            wallPart.Color = Color3.fromRGB(0, 0, 255)
            wallPart.Position = Vector3.new(boundarySize/2, 3, 0)
            wallPart.Size = Vector3.new(2, 5, boundarySize)
        else
            wallPart.Color = Color3.fromRGB(255, 255, 0)
            wallPart.Position = Vector3.new(-boundarySize/2, 3, 0)
            wallPart.Size = Vector3.new(2, 5, boundarySize)
        end
        
        wallPart.Parent = arena
    end
end

function MapBuilder:CreateSpawnArea(parent)
    local spawnArea = Instance.new("Folder")
    spawnArea.Name = "SpawnArea"
    spawnArea.Parent = parent
    
    -- Create spawn platforms for players
    local spawnPositions = {
        Vector3.new(-120, 2, -120),
        Vector3.new(120, 2, -120),
        Vector3.new(120, 2, 120),
        Vector3.new(-120, 2, 120),
        Vector3.new(0, 2, -150),
        Vector3.new(0, 2, 150)
    }
    
    for i, pos in ipairs(spawnPositions) do
        local spawnPlatform = Instance.new("Part")
        spawnPlatform.Name = "SpawnPlatform_" .. i
        spawnPlatform.Shape = Enum.PartType.Block
        spawnPlatform.Size = Vector3.new(30, 1, 30)
        spawnPlatform.Position = pos
        spawnPlatform.Material = Enum.Material.Neon
        spawnPlatform.Color = Color3.fromRGB(150, 150, 255)
        spawnPlatform.TopSurface = Enum.SurfaceType.Smooth
        spawnPlatform.BottomSurface = Enum.SurfaceType.Smooth
        spawnPlatform.CanCollide = true
        spawnPlatform.Parent = spawnArea
        
        -- Add spawn marker
        local marker = Instance.new("Part")
        marker.Name = "Marker"
        marker.Shape = Enum.PartType.Ball
        marker.Size = Vector3.new(2, 2, 2)
        marker.Position = pos + Vector3.new(0, 2, 0)
        marker.Material = Enum.Material.Neon
        marker.Color = Color3.fromRGB(0, 255, 0)
        marker.CanCollide = false
        marker.TopSurface = Enum.SurfaceType.Smooth
        marker.BottomSurface = Enum.SurfaceType.Smooth
        marker.Parent = spawnArea
    end
end

function MapBuilder:CreateEnvironment(parent)
    local environment = Instance.new("Folder")
    environment.Name = "Environment"
    environment.Parent = parent
    
    -- Create trees around the map
    for i = 1, 12 do
        local angle = (i / 12) * math.pi * 2
        local x = math.cos(angle) * 160
        local z = math.sin(angle) * 160
        
        -- Tree trunk
        local trunk = Instance.new("Part")
        trunk.Name = "TreeTrunk_" .. i
        trunk.Shape = Enum.PartType.Cylinder
        trunk.Size = Vector3.new(4, 20, 4)
        trunk.Position = Vector3.new(x, 10, z)
        trunk.Material = Enum.Material.Wood
        trunk.Color = Color3.fromRGB(139, 69, 19)
        trunk.CanCollide = true
        trunk.Rotation = Vector3.new(90, 0, 0)
        trunk.Parent = environment
        
        -- Tree foliage
        local foliage = Instance.new("Part")
        foliage.Name = "Foliage_" .. i
        foliage.Shape = Enum.PartType.Ball
        foliage.Size = Vector3.new(25, 25, 25)
        foliage.Position = Vector3.new(x, 25, z)
        foliage.Material = Enum.Material.Neon
        foliage.Color = Color3.fromRGB(34, 139, 34)
        foliage.CanCollide = false
        foliage.Parent = environment
    end
    
    -- Create rocks scattered around
    for i = 1, 16 do
        local x = (math.random() - 0.5) * 250
        local z = (math.random() - 0.5) * 250
        
        -- Skip center area
        if math.sqrt(x*x + z*z) > 120 then
            local rock = Instance.new("Part")
            rock.Name = "Rock_" .. i
            rock.Shape = Enum.PartType.Block
            rock.Size = Vector3.new(math.random(5, 15), math.random(5, 15), math.random(5, 15))
            rock.Position = Vector3.new(x, 2, z)
            rock.Material = Enum.Material.Rock
            rock.Color = Color3.fromRGB(128, 128, 128)
            rock.CanCollide = true
            rock.Rotation = Vector3.new(math.random(0, 360), math.random(0, 360), math.random(0, 360))
            rock.Parent = environment
        end
    end
    
    -- Create water feature
    local waterPool = Instance.new("Part")
    waterPool.Name = "WaterPool"
    waterPool.Shape = Enum.PartType.Block
    waterPool.Size = Vector3.new(60, 2, 60)
    waterPool.Position = Vector3.new(140, 0.5, 0)
    waterPool.Material = Enum.Material.Neon
    waterPool.Color = Color3.fromRGB(0, 100, 200)
    waterPool.CanCollide = true
    waterPool.TopSurface = Enum.SurfaceType.Smooth
    waterPool.BottomSurface = Enum.SurfaceType.Smooth
    waterPool.Transparency = 0.3
    waterPool.Parent = environment
    
    -- Create another water feature on opposite side
    local waterPool2 = Instance.new("Part")
    waterPool2.Name = "WaterPool2"
    waterPool2.Shape = Enum.PartType.Block
    waterPool2.Size = Vector3.new(60, 2, 60)
    waterPool2.Position = Vector3.new(-140, 0.5, 0)
    waterPool2.Material = Enum.Material.Neon
    waterPool2.Color = Color3.fromRGB(0, 100, 200)
    waterPool2.CanCollide = true
    waterPool2.TopSurface = Enum.SurfaceType.Smooth
    waterPool2.BottomSurface = Enum.SurfaceType.Smooth
    waterPool2.Transparency = 0.3
    waterPool2.Parent = environment
end

function MapBuilder:CreateDecorations(parent)
    local decorations = Instance.new("Folder")
    decorations.Name = "Decorations"
    decorations.Parent = parent
    
    -- Create mystical pillars around arena
    for i = 1, 8 do
        local angle = (i / 8) * math.pi * 2
        local x = math.cos(angle) * 100
        local z = math.sin(angle) * 100
        
        local pillar = Instance.new("Part")
        pillar.Name = "Pillar_" .. i
        pillar.Shape = Enum.PartType.Cylinder
        pillar.Size = Vector3.new(6, 25, 6)
        pillar.Position = Vector3.new(x, 12.5, z)
        pillar.Material = Enum.Material.Neon
        pillar.Color = Color3.fromRGB(255, 0, 255)
        pillar.CanCollide = true
        pillar.Rotation = Vector3.new(90, 0, 0)
        pillar.Parent = decorations
        
        -- Add glow orb on top
        local orb = Instance.new("Part")
        orb.Name = "OrbGlow_" .. i
        orb.Shape = Enum.PartType.Ball
        orb.Size = Vector3.new(4, 4, 4)
        orb.Position = Vector3.new(x, 27, z)
        orb.Material = Enum.Material.Neon
        orb.Color = Color3.fromRGB(100, 0, 255)
        orb.CanCollide = false
        orb.Parent = decorations
        
        -- Animate orb
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            orb.Position = orb.Position + Vector3.new(0, math.sin(tick()) * 0.05, 0)
        end)
    end
    
    -- Create neon signs/walls for visual interest
    local signWall1 = Instance.new("Part")
    signWall1.Name = "SignWall1"
    signWall1.Shape = Enum.PartType.Block
    signWall1.Size = Vector3.new(40, 15, 1)
    signWall1.Position = Vector3.new(0, 8, -180)
    signWall1.Material = Enum.Material.Neon
    signWall1.Color = Color3.fromRGB(255, 0, 255)
    signWall1.CanCollide = false
    signWall1.Transparency = 0.5
    signWall1.Parent = decorations
    
    local signWall2 = Instance.new("Part")
    signWall2.Name = "SignWall2"
    signWall2.Shape = Enum.PartType.Block
    signWall2.Size = Vector3.new(40, 15, 1)
    signWall2.Position = Vector3.new(0, 8, 180)
    signWall2.Material = Enum.Material.Neon
    signWall2.Color = Color3.fromRGB(0, 255, 255)
    signWall2.CanCollide = false
    signWall2.Transparency = 0.5
    signWall2.Parent = decorations
end

function MapBuilder:SetupLighting()
    local lighting = game:GetService("Lighting")
    
    -- Set up atmosphere
    lighting.Ambient = Color3.fromRGB(200, 200, 200)
    lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
    lighting.ClockTime = 14 -- Afternoon
end

return MapBuilder
