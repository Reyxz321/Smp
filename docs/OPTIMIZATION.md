# ⚡ Paper Optimization Reference (12GB / high player count)

These are the settings referenced in `docs/SETUP-GUIDE.md` Step 9.
**Never hand-write these YAML files from scratch** — boot the server once, let Paper
generate them, then edit the values below into the generated files (search for the key).

---

## 1. server.properties  →  already done in `server/server.properties`

| Setting | Value | Why |
|---|---|---|
| `view-distance` | `8` | chunks *rendered* to players |
| `simulation-distance` | `5` | chunks where redstone/mobs actually tick. **The #1 TPS saver.** |
| `spawn-protection` | `0` | no forced chunk ticking at spawn |
| `max-world-size` | `10000` | world border at ±5000 blocks — matches Chunky pregen |
| `sync-chunk-writes` | `true` | crash-safe world saves (keep on) |

---

## 2. `bukkit.yml`  (world root)

```yaml
settings:
  spawn-limits:
    monsters: 60          # default 70 — one player can't hog the whole cap
    animals: 10           # default 10 (keep)
    water-animals: 5
    water-ambient: 2
    water-underground-creature: 3
    axolotls: 5
    ambient: 1
  ticks-per:
    autosave: 6000        # every 5 min — keep
    monster-spawns: 1     # keep at 1 (hostiles need to spawn fast)
    animal-spawns: 400
    water-animal-spawns: 400
    water-ambient-spawns: 400
    water-underground-creature-spawns: 400
    axolotl-spawns: 400
    ambient-spawns: 400
  chunk-gc:
    period-in-ticks: 600
```

---

## 3. `spigot.yml`  (world-settings.default)

```yaml
world-settings:
  default:
    merge-radius:
      item: 3.5           # stack nearby drops — big lag saver on SMPs
      exp: 3.0
    mob-spawn-range: 4    # mobs spawn within simulation distance (4-6)
    item-despawn-rate: 6000
    max-tick-time:
      tile: 1000          # disable the watchdog timeouts
      entity: 1000
```

> `entity-activation-range` still exists in spigot.yml on old Paper, but on current
> Paper it lives in `config/paper-world-defaults.yml` (below). Edit it there.

---

## 4. `config/paper-world-defaults.yml`

```yaml
chunks:
  max-auto-save-chunks-per-tick: 6      # default 24 — spreads autosave load

collisions:
  max-entity-collisions: 2              # default 8 — less entity collision work

entities:
  behavior:
    entity-activation-range:            # mobs further away tick less often
      animals: 16
      monsters: 24
      raiders: 48
      misc: 8
      water: 16
      # newer builds split villagers/bees/flying into 'work'/'outer':
      # set 'outer' to 16, leave 'work' at default
  spawning:
    alt-item-despawn-rate:
      enabled: true                     # trash items vanish fast:
      items:
        cobblestone: 600                # 30 s
        netherrack: 600
        dirt: 600
        gravel: 600
        stone: 600
    per-player-mob-spawns: true         # fair mob distribution (default on 26.x)
    spawn-limits:                       # optional: -1 means "use bukkit.yml"
      monster: -1
      creature: -1

tick-rates:
  optimize-explosions: true             # faster TNT/explosion handling
```

---

## 5. `config/paper-global.yml` (optional extras)

```yaml
chunk-loading:
  max-concurrent-sends: 2               # default 2 — don't raise it
  autoconfig-send-distance: true        # server tells clients to match view distance

timings:
  enabled: false                        # Timings/V2 off = tiny perf gain; use Spark instead
```

---

## 6. Anti-Xray (free anti-cheat for ores)

In `config/paper-world-defaults.yml` → `anticheat.anti-xray`:

```yaml
anticheat:
  anti-xray:
    enabled: true
    engine-mode: 1        # replace ores with stone client-side
    max-block-height: 64  # only above Y=64 (no effect on deepslate ores)
```

---

## 7. Chunky — pre-generate the world (do this BEFORE opening to players)

```
chunky radius 5000          # generates a 10000x10000 area (matches world border)
chunky start                # run it overnight / while no one is playing
chunky pause                # to let the server breathe during the day
chunky continue             # pick up where it left off
chunky world world_nether
chunky world world_the_end
chunky cancel
chunky status
```

- Pregen on a 12GB Paper server roughly doubles chunk generation speed vs playing
  live — and players never hit a "generating world" lag spike again.
- `chunky start` causes some lag while running; schedule it for when the server is quiet.

---

## 8. Spark — find what's lagging

```
spark tps                          # current TPS (target 20)
spark tickmonitor                  # watch tick time live
spark profiler --timeout 300       # 5-minute CPU sample; prints a link when done
spark healthreport                 # full server health snapshot
spark heapdump                     # RAM dump (for deep memory issues)
```

Golden rule: only chase a problem when TPS is < 19.5 for a while. If it is:
1. `/spark tickmonitor` → which tick stage is slow?
2. `/spark profiler --timeout 300` → who uses CPU (plugin or entity)?
3. `/spark healthreport` → memory / GC / disk overview.

---

## 9. Bigger heap than 12G? (only if you raise `-Xmx` above 12G)

Per Aikar's flags, with `-Xmx` **> 12G** swap these in `run.bat`:

```
-XX:G1NewSizePercent=40
-XX:G1MaxNewSizePercent=50
-XX:G1HeapRegionSize=16M
-XX:G1ReservePercent=15
-XX:InitiatingHeapOccupancyPercent=20
```

Keep the rest identical. If old-generation GC pauses get worse, revert to the base set.
