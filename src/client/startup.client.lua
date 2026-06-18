local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for modules
while not ReplicatedStorage:FindFirstChild("GameConfig") do
    wait(0.1)
end

local EnemySelector = require(script.Parent.EnemySelectorUI)
local ShopUI = require(script.Parent.ShopUI)

-- Create UIs
EnemySelector:CreateUI()
ShopUI:CreateUI()

print("🧠 Brainrot Game Client Started!")
print("💬 Enemy Selector UI loaded (bottom-left)")
print("🏪 Shop UI loaded (center)")
