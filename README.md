# Roblox Brainrot Game 🧠

A multiplayer Roblox game where players battle AI brainrot enemies with swords, defend their bases, steal from other players, and upgrade their arsenal.

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

## Game Structure

```
roblox-brainrot-game/
├── README.md
├── src/
│   ├── server/
│   │   ├── main.server.lua           # Main server entry point
│   │   ├── MapBuilder.lua            # Generates the game map
│   │   ├── EnvironmentEffects.lua    # Particles, lighting, sounds
│   │   ├── PlayerManager.lua         # Player data & base assignment
│   │   ├── CombatSystem.lua          # RNG combat mechanics
│   │   ├── ShopSystem.lua            # Shop & upgrades
│   │   └── BaseSystem.lua            # Base creation & raiding
│   ├── client/
│   │   ├── startup.client.lua        # Client initialization
│   │   ├── EnemySelectorUI.lua       # Enemy selection interface
│   │   └── ShopUI.lua                # Shop interface
│   └── shared/
│       ├── GameConfig.lua            # Game constants & balance
│       └── PlayerData.lua            # Player data structure
```

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
3. Combat is RNG-based:
   - Your damage varies ±20% per hit
   - Enemy damage is randomized
   - Win = earn coins + add enemy to your base
   - Lose = take damage, try again with better sword

### Using the Shop
1. Open **Shop UI** (right side)
2. **Buy Swords**: Progress through better weapons for more damage
3. **Upgrade Damage**: Increases base damage (costs 50 coins per level)
4. **Upgrade Speed**: Decreases attack cooldown (costs 75 coins per level)

### Base Defense & Raiding
1. Your base is at a fixed location on the map
2. Enable stealing to allow others to raid you (high risk, high reward)
3. Raid other bases that have stealing enabled
4. Steal items to grow your wealth
5. Collect defeated enemies in your base

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

## Technical Details

### Data Persistence
- Uses Roblox DataStore for saving player data
- Auto-saves on player leave
- Loads on player rejoin
- Stores: coins, current sword, upgrades, base index, defeated enemies

### RNG System
- Enemy stats generated on spawn
- Damage rolls vary ±20% each turn
- Rarity chances weight which enemies appear
- Combat continues until one side is defeated

### Base System
- 6 fixed base positions around the map center
- Each player assigned one base on join
- Base is released when player leaves
- Server capacity: 6 players max

## Development Setup

1. **Install Roblox Studio**
2. **Create new Place**
3. **Copy all scripts** from `src/` folders into game hierarchy:
   - Server scripts → ServerScriptService
   - Client scripts → StarterPlayer > StarterCharacterScripts
   - Shared modules → ReplicatedStorage
4. **Copy GameConfig & PlayerData** to ReplicatedStorage
5. **Run the game!**

## Future Enhancements

- [ ] Enemy animations
- [ ] Combat animations for swords
- [ ] Sound effects
- [ ] Leaderboard system
- [ ] Team-based raids
- [ ] Boss battles
- [ ] Custom base decorations
- [ ] Pet system (captured brainrot)
- [ ] Daily quests
- [ ] Battle pass system

## Credits

Built with Lua and Roblox Studio

---

**Have fun battling brainrot! 🧠⚔️**
