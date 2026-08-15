# SMP — Donut-Style PaperMC Server Kit

A complete, verified setup kit for a **cracked-mode Donut SMP-style server** on
Windows (PaperMC · 12 GB RAM · AuthMeReloaded + LuckPerms · playit.gg).

> Versions verified **August 2026**: Paper 26.2 · Java 25 · AuthMeReloaded 6.0.0 ·
> LuckPerms 5.5.x · EssentialsX 2.22.0

## 📖 Start here

➡️ **`docs/SETUP-GUIDE.md`** — the full step-by-step walkthrough (12 steps).

## 📦 Files

| File | What it is |
|---|---|
| `docs/SETUP-GUIDE.md` | Full step-by-step guide (install → go live) |
| `docs/PLUGIN-LIST.md` | Donut SMP core plugin list, tiered, with download links |
| `docs/OPTIMIZATION.md` | Paper/spigot/bukkit tuning + Chunky & Spark usage |
| `server/run.bat` | 12 GB launcher (Aikar's flags, auto-restart) |
| `server/server.properties` | Cracked-mode + optimized server settings |
| `server/plugins/AuthMe/config.yml` | Hardened AuthMe 6.0.0 config (drop-in) |
| `server/backup.bat` | One-click world backup script |

## ⚡ 60-second summary

1. Install **Java 25 (Temurin)** → https://adoptium.net
2. Download **Paper 26.2** → https://papermc.io/downloads/paper → rename `paper.jar`
3. Accept `eula.txt`, first boot, `stop`
4. Copy `server/server.properties` + `server/run.bat` into the server folder
5. Drop Tier 0–2 plugins from `docs/PLUGIN-LIST.md` into `plugins/`
6. Replace `plugins/AuthMe/config.yml` with the hardened one
7. Run: `lp creategroup authme-unlogged` (before players join)
8. Pregen: `chunky radius 5000` → `chunky start`
9. playit.gg: Minecraft Java tunnel → `127.0.0.1:25565`, Proxy Protocol **OFF**
10. Share your `*.joinmc.link` address
