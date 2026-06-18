# Complete Setup Guide for Roblox Brainrot Game

## 🚀 Quickest Way (Recommended)

### Step 1: Download the Place File
1. Go to your repo: https://github.com/thereishe/roblox-brainrot-game
2. Find and download `BrainrotGame.rbxl`
3. Double-click it to open in **Roblox Studio**
4. Click **Play** (F5)
5. **Done!** The game is ready

---

## 📝 Manual Setup (If Needed)

If you want to set it up from scratch:

### Step 1: Create a New Place in Studio
1. Open **Roblox Studio**
2. Click **Create** → **Baseplate** template
3. Save it as `BrainrotGame`

### Step 2: Add Server Scripts
1. In left panel, find **ServerScriptService**
2. Right-click → **Insert Object** → **Script**
3. Name it: `MainServer`
4. Delete the default code
5. Copy and paste ALL code from: `src/server/main.server.lua`
6. Save

### Step 3: Add Shared Modules
1. Right-click **ReplicatedStorage** → **Insert Object** → **ModuleScript**
2. For each file below, create a ModuleScript with that name:
   - `GameConfig` ← paste from `src/shared/GameConfig.lua`
   - `PlayerData` ← paste from `src/shared/PlayerData.lua`
   - `PlayerManager` ← paste from `src/server/PlayerManager.lua`
   - `CombatSystem` ← paste from `src/server/CombatSystem.lua`
   - `BaseSystem` ← paste from `src/server/BaseSystem.lua`
   - `ShopSystem` ← paste from `src/server/ShopSystem.lua`
   - `MapBuilder` ← paste from `src/server/MapBuilder.lua`
   - `EnvironmentEffects` ← paste from `src/server/EnvironmentEffects.lua`

### Step 4: Add Client Scripts
1. In left panel, expand **StarterPlayer** → **StarterCharacterScripts**
2. Right-click → **Insert Object** → **LocalScript**
3. Name it: `ClientStartup`
4. Paste code from: `src/client/startup.client.lua`
5. Create two more LocalScripts:
   - `EnemySelectorUI` ← paste from `src/client/EnemySelectorUI.lua`
   - `ShopUI` ← paste from `src/client/ShopUI.lua`

### Step 5: Update Require Paths
In **MainServer** script, find these lines:
```lua
local PlayerManager = require(script.Parent.PlayerManager)
local CombatSystem = require(script.Parent.CombatSystem)
-- etc...
```

Change them all to:
```lua
local PlayerManager = require(game.ReplicatedStorage.PlayerManager)
local CombatSystem = require(game.ReplicatedStorage.CombatSystem)
-- etc...
```

### Step 6: Do the Same for Client Scripts
In **ClientStartup**, update:
```lua
local EnemySelector = require(game.ReplicatedStorage.EnemySelectorUI)
local ShopUI = require(game.ReplicatedStorage.ShopUI)
local GameConfig = require(game.ReplicatedStorage.GameConfig)
```

### Step 7: Test!
1. Click **Play** (F5)
2. You should see:
   - Arena with trees, rocks, water
   - Enemy selector (bottom-left)
   - Shop UI (center)
   - Your base

---

## ✅ Troubleshooting

### "Module not found" error
→ Make sure all modules are in **ReplicatedStorage** with correct names

### UI doesn't appear
→ Check that client scripts are in **StarterCharacterScripts**

### Map doesn't load
→ Make sure `MapBuilder` module exists in ReplicatedStorage

### Game crashes on join
→ Check the **Output** panel for error messages

---

## 🎮 Playing the Game

Once everything works:

1. **Fight Enemies**: Click selector (bottom-left) to choose enemy
2. **Buy Swords**: Open shop (center) to upgrade weapons
3. **Earn Coins**: Defeat enemies to get money
4. **Raid Bases**: Enable stealing to raid other players
5. **Auto-Save**: Your data saves when you leave!

---

## 📦 Publishing to Roblox

When you're ready to publish:

1. In Studio: **File** → **Publish to Roblox**
2. Enter game name, description, icon
3. Click **Create**
4. Your game is now live on Roblox!

---

Need more help? Check the README.md or GitHub issues!
