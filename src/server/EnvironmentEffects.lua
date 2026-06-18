local EnvironmentEffects = {}

-- Add dynamic particle effects to the map
function EnvironmentEffects:AddParticleEffects(parent)
    local particleFolder = Instance.new("Folder")
    particleFolder.Name = "ParticleEffects"
    particleFolder.Parent = parent
    
    -- Create floating debris particles around the arena
    for i = 1, 20 do
        local particle = Instance.new("Part")
        particle.Name = "Particle_" .. i
        particle.Shape = Enum.PartType.Block
        particle.Size = Vector3.new(0.5, 0.5, 0.5)
        particle.Position = Vector3.new(
            (math.random() - 0.5) * 200,
            math.random(10, 50),
            (math.random() - 0.5) * 200
        )
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(math.random(100, 255), math.random(0, 100), math.random(100, 255))
        particle.CanCollide = false
        particle.CastShadow = false
        particle.Transparency = 0.5
        particle.Parent = particleFolder
        
        -- Animate particle
        local offset = 0
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            offset = offset + 0.02
            particle.Position = particle.Position + Vector3.new(
                math.sin(offset) * 0.1,
                math.cos(offset * 0.5) * 0.1,
                math.cos(offset) * 0.1
            )
            
            -- Reset if too far
            if particle.Parent == nil then
                connection:Disconnect()
            end
        end)
    end
end

-- Add dynamic lighting effects
function EnvironmentEffects:AddDynamicLighting(parent)
    local lightingFolder = Instance.new("Folder")
    lightingFolder.Name = "DynamicLighting"
    lightingFolder.Parent = parent
    
    -- Create pulsing lights around arena
    for i = 1, 4 do
        local light = Instance.new("Part")
        light.Name = "PulseLight_" .. i
        light.Shape = Enum.PartType.Ball
        light.Size = Vector3.new(8, 8, 8)
        light.CanCollide = false
        light.CastShadow = false
        light.Transparency = 0.7
        light.Material = Enum.Material.Neon
        
        if i == 1 then
            light.Position = Vector3.new(60, 20, 60)
            light.Color = Color3.fromRGB(255, 0, 0)
        elseif i == 2 then
            light.Position = Vector3.new(-60, 20, 60)
            light.Color = Color3.fromRGB(0, 255, 0)
        elseif i == 3 then
            light.Position = Vector3.new(-60, 20, -60)
            light.Color = Color3.fromRGB(0, 0, 255)
        else
            light.Position = Vector3.new(60, 20, -60)
            light.Color = Color3.fromRGB(255, 255, 0)
        end
        
        light.Parent = lightingFolder
        
        -- Animate light pulse
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            local pulse = 0.5 + math.sin(tick() * 2) * 0.3
            light.Transparency = 0.7 - pulse * 0.3
            
            if light.Parent == nil then
                connection:Disconnect()
            end
        end)
    end
end

return EnvironmentEffects
