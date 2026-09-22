-- Hyprland default apps
local device = require("config.device")

TERMINAL     = "kitty"
FILE_MANAGER = "dolphin"
BROWSER      = "brave-bin"
EDITOR       = "nvim"
CALCULATOR   = "gnome-calculator"

-- Monitors
if device.type == "desktop" then
  MONITOR1 = "DP-2"
  MONITOR2 = "DP-1"
  MONITOR3 = ""
else
  MONITOR1 = "eDP-1"
  MONITOR2 = ""
  MONITOR3 = ""
end
PRIMARY_MONITOR = MONITOR1

-- Workspaces
NUM_WPM = 5 -- Number of workspaces per monitor (Max 10)
