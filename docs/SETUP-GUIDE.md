# 🏗️ Donut-Style SMP — Full Setup Guide (PaperMC, Windows, Cracked)

**Goal:** a highly-customizable, public, cracked-mode SMP inspired by Donut SMP —
lifesteal, custom GUIs, player-driven economy — running on your own PC with
12 GB RAM, protected by AuthMeReloaded + LuckPerms, reachable via playit.gg.

**Your machine:** Windows 10/11 · 32 GB RAM · non-premium (cracked) account.

**Time:** ~1.5–2 hours including download time.

---

## What's in this repo

| File | Purpose |
|---|---|
| `server/run.bat` | 12 GB launcher with Aikar's JVM flags + auto-restart |
| `server/server.properties` | Cracked-mode + optimized server settings |
| `server/plugins/AuthMe/config.yml` | **Hardened** AuthMe 6.0.0 config (drop-in) |
| `server/backup.bat` | One-click world backup script |
| `docs/PLUGIN-LIST.md` | The Donut SMP core plugin list (download links) |
| `docs/OPTIMIZATION.md` | Paper tuning reference + Chunky/Spark usage |

---

## Step 0 — The plan (read once)

```
1. Install Java 25 (Temurin)
2. Download Paper, accept EULA, first boot
3. Configure server.properties (cracked + optimized)
4. Create run.bat (12 GB)
5. Install foundation plugins (Tier 0–1)
6. Harden AuthMe (drop-in config) + PacketEvents
7. Set up LuckPerms (ranks + locked-down login group)
8. EssentialsX + economy basics
9. Donut SMP gameplay layer (Lifesteal, GUIs, shops)
10. Optimize: pregen with Chunky, tune Paper, profile with Spark
11. Go public through playit.gg
12. Go-live checklist + security rules
```

---

## Step 1 — Install Java 25 (Temurin)

Paper **26.x requires Java 25**; Paper 1.21.x requires Java 21. Install the newest
**Eclipse Temurin JDK** (Adoptium) for Windows x64:

👉 https://adoptium.net/temurin/releases/?version=25

1. Download the `.msi` (x64) and install with defaults.
2. **Uninstall/remove older Java versions** from *Apps & Features* if you have any —
   Windows may otherwise pick an old `java` and the server won't start.
3. Verify in a new Command Prompt:
   ```
   java -version
   ```
   You should see `openjdk version "25..."`.

---

## Step 2 — Download Paper & first boot

1. Create a clean folder, e.g. `C:\SMP\`.
2. Download the latest Paper build:
   👉 https://papermc.io/downloads/paper
3. Rename the downloaded file to **`paper.jar`** and put it in `C:\SMP\`.
4. Open a Command Prompt in `C:\SMP\` and run:
   ```
   java -Xmx2G -jar paper.jar --nogui
   ```
5. The first run **stops immediately** — that's normal. It created `eula.txt`.
6. Open `eula.txt` and change `eula=false` → `eula=true`. Save.
7. Run the same command again. Paper now generates `server.properties`,
   `bukkit.yml`, `spigot.yml`, and a `config/` folder. When you see
   `Done (Xs)!`, type `stop` and press Enter.

> 🛡️ **Windows Firewall:** when Windows asks to allow Java/network access,
> allow it on **Private networks** (your home network). Public players reach
> you through playit.gg, so you do **not** need to open any router ports.

---

## Step 3 — server.properties (cracked + optimized)

Copy the file **`server/server.properties`** from this repo into `C:\SMP\`
(overwrite the generated one), or edit the generated file to match these values:

```properties
online-mode=false              # CRACKED MODE - lets non-premium players join
enforce-secure-profile=false   # required for cracked since 1.19.1
server-port=25565
max-players=80
view-distance=8
simulation-distance=5          # big TPS saver on busy servers
spawn-protection=0
gamemode=survival
difficulty=hard
pvp=true
max-world-size=10000           # world border at ±5000, matches pregen
sync-chunk-writes=true
white-list=false               # AuthMe is your gatekeeper; keep open for now
```

> `enforce-secure-profile=false` is *non-negotiable* on a cracked server —
> without it every 1.19.1+ client gets kicked with a "secure profile" error.

---

## Step 4 — run.bat (12 GB launcher)

Copy **`server/run.bat`** into `C:\SMP\` and double-click it. What it does:

- Allocates **`-Xms12G -Xmx12G`** (12 GB heap, fixed — Aikar's flags want Xms = Xmx).
- Applies **Aikar's G1GC flags** (mcflags.emc.gs) — smoother, pause-free GC.
- Runs with `--nogui` and **auto-restarts** 5 s after a crash/stop.

On your 32 GB machine: 12 GB for Minecraft + ~1.5 GB JVM overhead + Windows +
browser + Discord easily fits, leaving ~15 GB free. If `java` isn't found or the
wrong version is used, uncomment the `set "JAVA=..."` line in run.bat and paste
your full `java.exe` path.

> ⚠️ If you ever raise RAM **above 12 G**, swap 5 flags (see
> `docs/OPTIMIZATION.md` §9). At exactly 12 G keep the base flags.

Start the server now and confirm it reaches `Done (Xs)!` with your new settings.

---

## Step 5 — Install foundation plugins

1. Stop the server.
2. Download **Tier 0 + Tier 1** from `docs/PLUGIN-LIST.md`:
   - LuckPerms, Vault, **AuthMe-6.0.0-Paper.jar**, PacketEvents, EssentialsX
     (+ EssentialsXChat, EssentialsXSpawn), PlaceholderAPI, CoreProtect,
     WorldGuard, WorldEdit, Chunky, Spark.
3. Drop every `.jar` into `C:\SMP\plugins\`.
4. Start the server, watch the console for errors (e.g. a plugin needing a
   different Minecraft version), then `stop` once it's up.
5. Each plugin created its own folder under `plugins\` — that's where configs live.

---

## Step 6 — Harden AuthMe (the important one)

1. **First**, copy `server/plugins/AuthMe/config.yml` over the generated
   `C:\SMP\plugins\AuthMe\config.yml`.
2. **Second**, create the locked-down group *before* anyone joins (AuthMe 6
   switches every unlogged player into it):
   ```
   lp creategroup authme-unlogged
   ```
   (this is a LuckPerms command — run it in-game as OP or in the console)
3. Restart the server. AuthMe 6 on Paper 1.21.11+ shows players a **login dialog
   before they fully join**.

What this config changes vs. the default, and why:

| Setting | Value | Why it's safer |
|---|---|---|
| `settings.security.passwordHash` | `BCRYPT2Y` | default is `SHA256`; bcrypt2y is slow & salted → brute-force-proof |
| `settings.security.minPasswordLength` | `10` | default 5 — no "12345" accounts |
| `settings.security.unsafePasswords` | +admin, password1, changeme… | blocks the most guessed passwords |
| `settings.restrictions.maxRegPerIp` | `1` | one account per IP (raise to 2–3 for families) |
| `settings.restrictions.ForceSingleSession` | `true` | account sharing kicks the other session |
| `settings.restrictions.kickOnWrongPassword` | `true` | no endless guessing |
| `settings.restrictions.allowMovement` | `false` | unlogged players are frozen |
| `settings.restrictions.allowChat` / `hideChat` | `false` / `true` | unlogged players can't chat or see chat |
| `settings.restrictions.DenyTabCompleteBeforeLogin` | `true` | no command tab-complete pre-login |
| `settings.restrictions.maxLoginPerIp` / `maxJoinPerIp` | `3` / `5` | limits per-IP abuse |
| `settings.restrictions.loginTimeout` | `20` | kick if no login within 20 s |
| `settings.GameMode.ForceSurvivalMode` | `true` | no creative tricks pre-login |
| `settings.applyBlindEffect` / `delayJoinMessage` | `true` | blind + invisible until logged in |
| `settings.preventOtherCase` | `true` | `Xephi` ≠ `XEPHI` — blocks case-swap account theft |
| `GroupOptions.enablePermissionCheck` | `true` | **unlogged players get ZERO permissions** |
| `GroupOptions.*PlayerGroup` | `authme-unlogged` | the no-permission group you just created |
| `Security.captcha.useCaptcha` | `true` | captcha after 5 wrong tries |
| `Security.tempban.enableTempban` | `true` | IP tempbanned 24 h after 5 failed logins |
| `Security.SQLProblem.stopServer` | `true` | fail-closed: no DB → no server |
| `settings.sessions.enabled` | `false` | every join needs `/login` (no session files to steal) |

**Player experience on your server:**
```
Join → login dialog / "Please register with: /register <password> <password>"
/register mypassword123 mypassword123   (first time)
/login mypassword123                   (every join after)
```

> If `ProtectInventoryBeforeLogIn` doesn't seem to work, make sure **PacketEvents 2.x**
> is installed — AuthMe 6 uses it (ProtocolLib is no longer used).

---

## Step 7 — LuckPerms (ranks & permissions)

LuckPerms stores data in `plugins/LuckPerms/` (H2 file DB by default — fine for one server).

Create your rank ladder in-game (as OP):

```
lp creategroup member
lp group member setprimary
lp group default setprimary          # 'default' group stays for weird cases

# Member = everything EssentialsX + core
lp group member permission set essentials.* true
lp group member permission set essentials.protect false          # carve out dangerous bits
lp group member permission set essentials.give false
lp group member permission set essentials.gamemode false
lp group member permission set essentials.socialspy false
lp group member permission set chunky.* false
lp group member permission set coreprotect.inspect false
lp group member permission set worldedit.* false

# Kits are per-kit permissions:
lp group member permission set essentials.kit.starter true
lp group member permission set essentials.kit.claim true

# Staff:
lp creategroup admin
lp group admin permission set * true
lp user <yourname> parent add admin

# Locked-down login group (already created in Step 6):
lp creategroup authme-unlogged     # ← no permissions = nothing to abuse pre-login
```

Helpers:
```
lp user <name> parent add member        # promote a player
lp user <name> parent remove member     # demote
lp group member permission set <node> true/false
lp verbose on                           # see every permission check live
lp editor                               # full web editor (paste the code back)
```

**Golden rule:** give `*` only to admins. Everyone else gets explicit nodes.

---

## Step 8 — EssentialsX + economy

Edit `plugins/Essentials/config.yml`:

```yaml
teleport-delay: 3              # warmup on /tpa (DonutTPA feel)
teleport-cooldown: 5
sethome-multiple: 3            # 3 homes per player
spawn-join: true               # new players land at spawn
# economy (in Essentials config, under 'economy'):
starting-balance: 100.0
```

Then reload: `ess reload`.

EssentialsX provides the **Vault economy** the whole server runs on:
`/bal`, `/pay <player> <amount>`, `/baltop`, `/balance`.

---

## Step 9 — Donut SMP gameplay layer

Install **Tier 2** from `docs/PLUGIN-LIST.md`. Quick-start for each:

### LifestealZ (the heart/life system)
- Config: `plugins/LifestealZ/config.yml` — set starting hearts, max hearts,
  craftable heart item, revive crystal recipe, disable totems if you want.
- PlaceholderAPI hooks: `%lifestealz_health%`, `%lifestealz_maxhearts%`,
  `%lifestealz_eliminated%` → use in scoreboards/GUIs.
- WorldGuard flags: `lifestealz:maxhearts` per-region if you want safe zones.

### DeluxeMenus (custom GUIs)
- Example menu — `plugins/DeluxeMenus/menus/menu.yml`:

```yaml
menu_title: '&8&lSMP Menu'
open_command:
  - menu
  - smp
size: 27
items:
  kit:
    material: CHEST
    slot: 11
    display_name: '&b&lStarter Kit'
    lore:
      - '&7Claim your starter kit'
    left_click_commands:
      - '[kit] starter'
  shop:
    material: EMERALD
    slot: 13
    display_name: '&a&lShop'
    lore:
      - '&7Open the server shop'
    left_click_commands:
      - '[open] shop.yml'
  tpa:
    material: ENDER_PEARL
    slot: 15
    display_name: '&d&lPlayer Menu'
    lore:
      - '&7Teleport requests, warps, homes'
    left_click_commands:
      - '[player] warp'
```

### QuickShop-Hikari (player-driven economy)
- Player: place a chest → click chest with item → type a price → done.
- Shop sign appears; buyers right-click to buy. Money flows through Vault/EssentialsX.

### AuctionHouse (Donut /ah)
- `/ah` opens the auction GUI, `/ah sell <price>` to auction the held item.

### CombatLogX (no combat logging)
- Default config punishes logouts during combat (damage + effects). Works with
  WorldGuard for safe-zone checks.

### BetterRTP
- `/rtp` → random teleport, respects WorldGuard and world border.

---

## Step 10 — Optimize (do this BEFORE going public)

1. **Pre-generate the world** with Chunky (run overnight, while nobody plays):
   ```
   chunky radius 5000
   chunky start
   chunky status
   ```
   Also pregen nether (`chunky world world_nether`) and end
   (`chunky world world_the_end`) with a smaller radius (2000 / 500).
2. Apply the tuning in `docs/OPTIMIZATION.md` (bukkit.yml spawn-limits,
   spigot.yml merge-radius, paper-world-defaults.yml auto-save/activation-range/
   item-despawn). Restart.
3. Optional: enable **Anti-Xray** (§6 of the optimization doc) to stop X-ray
   texture packs.
4. Profile with Spark whenever you suspect lag: `/spark tps` → `/spark tickmonitor`
   → `/spark profiler --timeout 300`.

---

## Step 11 — Go public with playit.gg (no port forwarding)

1. Create a free account at 👉 **https://playit.gg**
2. Download the **Windows agent** and run `playit.exe` — it opens a browser,
   logs you in, and claims the agent to your account.
3. In the playit.gg dashboard → **Tunnels → Add Tunnel**:
   - Type: **Minecraft Java**
   - Local address: **127.0.0.1:25565**
   - **Proxy Protocol: OFF / None** (you're not running a proxy — if it's on,
     players get disconnected immediately)
4. Save. playit.gg gives you a public address, e.g. `your-smp-abc123.joinmc.link`.
5. Share that address. Players join it exactly like a normal server IP —
   **your router needs nothing**.

> Keep `playit.exe` running the whole time the server is up (add it to the
> startup of the batch, or just run it in another window).
> The free tier is fine for a friends-sized SMP.

---

## Step 12 — Go-live checklist & security rules

- [ ] `run.bat` starts clean, TPS = 20 (`spark tps`)
- [ ] World pre-generated; `chunky status` shows 100%
- [ ] Tested registration: `authme register <me> <pass> <pass>` on a test account
- [ ] `authme-unlogged` group exists in LuckPerms
- [ ] `lp user <you> parent add admin` done; nobody else has admin
- [ ] WorldGuard: spawn region claimed & flagged (`/rg claim spawn`,
      `/rg flag spawn pvp deny`, `/rg flag spawn mob-spawning deny`)
- [ ] CoreProtect working: `/co inspect` on a block shows history
- [ ] Windows Firewall: Java allowed on **private** network
- [ ] Backup routine: run `backup.bat` weekly (server stopped)

**House rules you should enforce (cracked servers attract trouble):**
- Never share the server console / `playit.toml` (that file = control of your tunnel).
- Never give out OP. Promote via LuckPerms only.
- Ban griefers hard; CoreProtect makes rollbacks trivial, so be proactive.
- Update Paper + plugins monthly (Paper builds ship constantly).
- Watch `plugins/AuthMe/` logs for repeated failed logins — tempbans handle it,
  but a look costs nothing.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| `Error: A JNI error has occurred` / wrong Java | Install Java 25 Temurin; uninstall old Java; check `java -version` |
| `Unable to access jarfile paper.jar` | run.bat `JAR` name ≠ your jar file |
| Players kicked: `secure profile` / `Outdated client` | `enforce-secure-profile=false`; matching versions |
| Players can't connect through playit | agent running? tunnel local port = 25565? Proxy Protocol **OFF**? |
| AuthMe not prompting login | `online-mode=false`? plugin version = Paper build? PacketEvents installed? |
| Unlogged players have permissions | `authme-unlogged` group missing in LuckPerms → create it, restart |
| TPS < 20 | `/spark profiler --timeout 300`; check `simulation-distance`; pregen done? |
| Plugin "incompatible" / won't load | wrong build for your MC version — download the newest build |
| Server OOM / crash | 12 GB heap + ~1.5 GB overhead fits 32 GB; check `logs/latest.log` for `OutOfMemoryError` |

---

*Versions verified August 2026: Paper 26.2 (build 112) · Java 25 · AuthMeReloaded 6.0.0 ·
LuckPerms 5.5.x · EssentialsX 2.22.0. If newer builds exist, take the newest.*
