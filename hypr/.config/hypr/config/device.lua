-- config/device.lua
-- Detects the current machine once, and exposes it as a reusable table
-- for any other config file to branch on. This avoids re-running the
-- hostname lookup (and re-typing the same if/elseif chain) in every file.

local handle = io.popen("hostname")
local hostname = handle:read("*a"):gsub("%s+$", "")
handle:close()

local devices = {
  jetragon = {
    type = "desktop",
    monitor_count = 2,
    has_touchpad = false,
    has_battery = false,
  },
  dragapult = {
    type = "laptop",
    monitor_count = 1,
    has_touchpad = true,
    has_battery = true,
  },
}

-- Fallback for any unrecognized machine, so nothing crashes on a fresh
-- install/VM/clone before you've hardcoded that machine's hostname above.
local current = devices[hostname] or {
  type = "unknown",
  monitor_count = 1,
  has_touchpad = false,
  has_battery = false,
}

current.hostname = hostname

return current
