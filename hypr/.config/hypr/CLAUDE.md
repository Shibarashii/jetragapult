# Hyprland config (Lua)

Hyprland **0.57+ Lua config** (CachyOS base), not the classic `hyprland.conf` syntax.
`~/.config/hypr` is a stow symlink to this dir, so edits apply live on reload.

## Layout

```
hyprland.lua            ← entrypoint; only require()s config.* modules (order matters)
xdph.conf               ← xdg-desktop-portal-hyprland (classic syntax, not Lua)
config/
  device.lua            ← hostname → device table (type, monitor_count, has_touchpad, has_battery)
  variables.lua         ← GLOBALS: TERMINAL, FILE_MANAGER, BROWSER, EDITOR, MONITOR1..3, PRIMARY_MONITOR, NUM_WPM
  colors.lua            ← color globals (e.g. CACHYLGREEN)
  binds.lua             ← all keybinds; workspace binds generated per device
  monitors.lua          ← hl.monitor(); reads MONITOR* globals
  workspaces.lua        ← hl.workspace_rule()
  windowrules.lua       ← hl.window_rule()
  autostart.lua         ← hl.on("hyprland.start", …)
  environment.lua       ← hl.env() (unused under UWSM: env lives in ~/.config/uwsm/env)
  animations / decorations / inputs / misc.lua ← hl.config({...}) sections
```

## API patterns (copy these, don't invent new ones)

```lua
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true })
hl.config({ misc = { vrr = 3 } })
hl.window_rule({ match = { class = "^(steam)$" }, float = true })
hl.workspace_rule({ workspace = "1", monitor = MONITOR1, default = true, persistent = true })
```

Dispatcher names (`hl.dsp.*`) and option keys follow the Lua API. If unsure one
exists, check https://wiki.hypr.land before using it. Don't guess.

## Conventions

- **Machine differences**: branch on `require("config.device")` (`device.type == "desktop"` / `"laptop"`). Never hardcode outputs outside `variables.lua`.
- **Monitors**: change output names in `variables.lua`, not `monitors.lua`.
- **Number-row binds use keycodes** via `digitCode(d)` in `binds.lua` (AZERTY layout). Don't bind `"SUPER + 1"`.
- **Apps launch through UWSM**: prefix with `launchPrefix` (`"uwsm app -- "`). Shell actions go through `noctCall` (`"noctalia msg "`).
- Keep disabled-but-kept binds as commented lines in the same style (the file uses this a lot).
- Indentation: match the file you're editing (`binds.lua` uses tabs; others use spaces).

## Verify after editing

```bash
hyprctl reload          # Lua config applies on reload
hyprctl configerrors    # must print nothing
hyprctl binds | grep -i <key>   # confirm a bind registered
hyprctl monitors / workspaces / clients   # inspect live state
```

## Gotchas

- `variables.lua` and `colors.lua` set **globals**, so modules that read them must load after them in `hyprland.lua`.
- `workspaces.lua` pins 1–5 to MONITOR1, and `binds.lua` also generates per-monitor workspace logic on desktop. Check both when touching workspaces.
- `autostart.lua` runs `sudo tee` for USB wakeup (device path `3-2.4`, which depends on the machine).
- The `plugins/` dir is gitignored.
