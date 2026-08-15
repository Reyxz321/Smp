# 🧩 Donut SMP — Core Plugin List (install order)

All plugins go in the `plugins/` folder. Download the **Paper**/**latest** build of each
and **always match the Minecraft version of your server** (Paper 26.x or 1.21.x).

---

## 🟢 Tier 0 — Foundation (install these FIRST, in this order)

| # | Plugin | What it does for you | Download |
|---|--------|----------------------|----------|
| 1 | **Paper** (server jar) | The engine — best performance + plugin support | https://papermc.io/downloads/paper |
| 2 | **LuckPerms** | Permissions manager (ranks, groups, per-user perms) | https://modrinth.com/plugin/luckperms |
| 3 | **Vault** | API bridge so economy/shop plugins can talk to each other | https://www.spigotmc.org/resources/vault.34315/ |
| 4 | **AuthMeReloaded** | Registration/login for cracked mode. Use **AuthMe-6.0.0-Paper.jar** | https://github.com/AuthMe/AuthMeReloaded/releases |
| 5 | **PacketEvents 2.x** | Required by AuthMe 6 for inventory protection + tab-complete blocking | https://modrinth.com/plugin/packetevents |
| 6 | **EssentialsX** (core jar) | Homes, `/sethome`, `/warp`, `/tpa` (DonutTPA stand-in), kits, mail, `/bal /pay` economy, `/spawn` | https://github.com/EssentialsX/Essentials/releases |
| 7 | **EssentialsXChat** | Chat formatting (`[rank] name: message`) | same release page (separate jar) |
| 8 | **EssentialsXSpawn** | `/spawn` handling (pair with AuthMe spawn priority) | same release page (separate jar) |
| 9 | **PlaceholderAPI** | Placeholder engine — almost every GUI/scoreboard plugin needs it | https://modrinth.com/plugin/placeholderapi |

> EssentialsX GitHub release = one download page, multiple jars. Grab at minimum
> `EssentialsX-<version>.jar`, `EssentialsXChat-<version>.jar`, `EssentialsXSpawn-<version>.jar`.

---

## 🟡 Tier 1 — Protection, Admin & Performance

| # | Plugin | What it does for you | Download |
|---|--------|----------------------|----------|
| 10 | **CoreProtect** | Block/container logging + rollback — repair grief in minutes | https://modrinth.com/plugin/coreprotect |
| 11 | **WorldGuard** | Claim regions, protect spawn, deny pvp/grief in areas | https://enginehub.org/worldguard |
| 12 | **WorldEdit** | Build/terrain tool (WorldGuard's required companion) | https://enginehub.org/worldedit |
| 13 | **Chunky** | Pre-generate the world before opening (kills lag from chunk gen) | https://modrinth.com/plugin/chunky |
| 14 | **Spark** | TPS monitor + profiler (`/spark tps`, `/spark profiler`) | https://modrinth.com/plugin/spark |

---

## 🔴 Tier 2 — Donut SMP gameplay features

| # | Plugin | Donut SMP feature it replicates | Download |
|---|--------|--------------------------------|----------|
| 15 | **LifestealZ** | The **DonutCore** lifesteal system: steal hearts on kill, craft heart items, withdraw hearts, revive crystal, eliminate at 0 hearts, WorldGuard flags, PlaceholderAPI placeholders | https://hangar.papermc.io/KartoffelChipss/LifestealZ |
| 16 | **DeluxeMenus** | **Custom GUIs** — `/shop`, `/kits`, `/menu`, any GUI you can imagine (free; the paid alternative is ItemsAdder) | https://modrinth.com/plugin/deluxemenus |
| 17 | **QuickShop-Hikari** | **Player-driven economy** — chest shops: place a chest, click with the item, set price, done | https://modrinth.com/plugin/quickshop-hikari |
| 18 | **AuctionHouse** | The Donut **/ah** auction house — players auction items for money | https://modrinth.com/plugin/auctionhouse |
| 19 | **CombatLogX** | **Combat tag** — no logging out mid-fight (Donut SMP's anti-combat-log rule) | https://modrinth.com/plugin/combatlogx |
| 20 | **BetterRTP** | `/rtp` random teleport to explore new land | https://www.spigotmc.org/resources/betterrtp.36081/ |

---

## 🟣 Tier 3 — Optional extras (add after the core works)

| Plugin | Feature | Download |
|--------|---------|----------|
| **AnimatedScoreboard** (or Scoreboard) | **Life counter sidebar** using LifestealZ placeholders (`%lifestealz_health%`, `%lifestealz_maxhearts%`) | https://www.spigotmc.org/resources/animated-scoreboard.28360/ |
| **Bountiful** | **Bounty system** — players put heart/coin bounties on other players' heads | search "Bountiful" on SpigotMC |
| **EcoEnchants** | Custom enchantments | https://modrinth.com/plugin/ecoenchants |
| **Jobs Reborn** | Jobs you earn money from (miner, farmer, hunter…) | https://www.spigotmc.org/resources/jobs-reborn.4216/ |
| **mcMMO** | RPG skills (Donut-adjacent) | https://www.spigotmc.org/resources/mcmmo.2445/ |
| **SkinRestorer** | Cracked players get skins (offline-mode hides them) | https://www.spigotmc.org/resources/skinrestorer.2124/ |
| **DiscordSRV** | Chat bridge to a Discord server | https://modrinth.com/plugin/discordsrv |

---

## ⚠️ Version-matching rules

- Every plugin must support your **exact Minecraft version** (check its "Supported versions").
- After Paper 26.x came out, all major plugins (LuckPerms, EssentialsX, PlaceholderAPI…)
  publish builds for it — pick the newest one.
- **Vault note:** the classic Vault (1.7.x) still works on modern Paper. If it ever refuses
  to load, use the maintained fork **VaultUnlocked**.
- Don't install two plugins that do the same job (e.g. two shop plugins) — they will fight
  over Vault and commands.
