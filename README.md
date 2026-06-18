# Roblox Brainrot Game 🧠

A multiplayer Roblox game where players battle AI brainrot enemies with swords, defend their bases, steal from other players, and upgrade their arsenal.

## ✅ Quick Start

### Option 1: Download Ready-to-Play Place (EASIEST)
1. Download `BrainrotGame.rbxl` from this repo
2. Open it in **Roblox Studio**
3. Click **Play** - game is ready to go!

### Option 2: Clone Repository
1. Open Roblox Studio
2. **File** → **Version Control** → **Clone Repository**
3. Paste: `https://github.com/thereishe/roblox-brainrot-game.git`
4. Click Clone

### Option 3: Manual Setup
Follow the detailed instructions in `SETUP.md`

---

## Features

### 🎮 Core Gameplay
- **RNG Combat System**: Fight brainrot enemies with randomized stats and difficulty
- **5 Enemy Types**: Skibidi, Sigma, Gyatt, Ohio, Mewing (legendary)
- **Sword Progression**: Upgrade from Wooden → Stone → Iron → Diamond → Legendary
- **Base System**: Each of 6 players gets their own customizable base
- **Raiding System**: Steal items from other bases (opt-in vulnerability)
- **Auto-Save**: Bases automatically save and load on rejoin

### 🗺️ Detailed Map
- Central arena with neon boundaries
- 6 spawn platforms for players
- 12 mystical pillars with glowing orbs
- 12 trees scattered around the perimeter
- 16 rocks for environmental cover
- 2 water pools with transparency effects
- Dynamic lighting with pulsing effects
- Floating particle effects
- Neon decorative signs

### 💰 Shop & Progression
- Buy better swords to fight stronger enemies
- Upgrade sword damage (affects RNG variance)
- Upgrade attack speed (reduces attack cooldown)
- Earn coins from defeating brainrot enemies
- Higher rarity enemies = higher rewards

### 👥 Multiplayer Features
- Server supports up to 6 players
- Each player has an assigned base location
- Opt-in stealing mechanic
- Real-time combat with enemy animations
- Persistent player data via DataStore

---

## Game Structure

```
roblox-brainrot-game/
├── BrainrotGame.rbxl          # 👈 READY-TO-PLAY PLACE FILE
├── README.md
├── SETUP.md
└── src/
    ├── server/
    │   ├── main.server.lua
    │   ├── MapBuilder.lua
    │   ├── EnvironmentEffects.lua
    │   ├── PlayerManager.lua
    │   ├── CombatSystem.lua
    │   ├── ShopSystem.lua
    │   └── BaseSystem.lua
    ├── client/
    │   ├── startup.client.lua
    │   ├── EnemySelectorUI.lua
    │   └── ShopUI.lua
    └── shared/
        ├── GameConfig.lua
        └── PlayerData.lua
```

---

## How to Play

### Spawning In
1. Join the game - you'll spawn on your assigned base platform
2. Your base is created automatically with walls and platform

### Fighting Enemies
1. Click the **Enemy Selector** UI (bottom-left)
2. Choose a brainrot type:
   - **Skibidi** (60% spawn) - Easy, 10-25 HP
   - **Sigma** (25% spawn) - Medium, 20-40 HP
   - **Gyatt** (10% spawn) - Hard, 30-60 HP
   - **Ohio** (4% spawn) - Very Hard, 50-100 HP
   - **Mewing** (1% spawn) - LEGENDARY, 80-150 HP
3. Combat is RNG-based - win to earn coins!

### Using the Shop
1. Open **Shop UI** (right side)
2. **Buy Swords**: Progress through better weapons
3. **Upgrade Damage**: Increases base damage
4. **Upgrade Speed**: Decreases attack cooldown

### Base Defense & Raiding
1. Your base is at a fixed location on the map
2. Enable stealing to allow others to raid you
3. Raid other bases that have stealing enabled

---

## Enemy Rarity & Rewards

| Enemy | HP Range | Damage Range | Rarity | Reward |
|-------|----------|--------------|--------|--------|
| Skibidi | 10-25 | 1-3 | 60% | 50 coins |
| Sigma | 20-40 | 2-5 | 25% | 100 coins |
| Gyatt | 30-60 | 3-7 | 10% | 250 coins |
| Ohio | 50-100 | 5-10 | 4% | 500 coins |
| Mewing | 80-150 | 7-15 | 1% | 1000 coins |

## Sword Progression

| Sword | Base Damage | Attack Speed | Cost | Starting? |
|-------|------------|--------------|------|----------|
| Wooden | 1 | 1.5s | Free | ✅ |
| Stone | 2 | 1.4s | 100 coins | |
| Iron | 4 | 1.3s | 300 coins | |
| Diamond | 7 | 1.2s | 800 coins | |
| Legendary | 12 | 1.0s | 2000 coins | |

---

## Need Help?

- **Setup Issues?** Check `SETUP.md`
- **Want to edit code?** All scripts are in `src/` folder
- **Having bugs?** Open an issue on GitHub

---

**Have fun battling brainrot! 🧠⚔️**
