#!/usr/bin/env bash
# GTK theme, icons, cursor and dark mode for GTK apps (Thunar, file-roller, …).
# On Wayland GTK reads these from GSettings (dconf), not settings.ini.
# Packages: adw-gtk-theme (CachyOS base), papirus-icon-theme (packages/noctalia.txt).
# Colors on top of this come from Noctalia's gtk3/gtk4 templates (gtk.css).
set -euo pipefail

gtk_theme="adw-gtk3-dark"
icon_theme="Papirus-Dark"
cursor_theme="Bibata-Modern-Ice"   # also set in ~/.config/uwsm/env
cursor_size=24

warn_missing() { # $1 = name, $2.. = dirs to look in
	local name=$1; shift
	for d in "$@"; do [[ -d $d/$name ]] && return; done
	echo "warning: '$name' not installed; GTK will fall back to the default" >&2
}
warn_missing "${gtk_theme%-dark}" /usr/share/themes ~/.local/share/themes ~/.themes
warn_missing "$icon_theme" /usr/share/icons ~/.local/share/icons ~/.icons
warn_missing "$cursor_theme" /usr/share/icons ~/.local/share/icons ~/.icons

s=org.gnome.desktop.interface
gsettings set $s gtk-theme "$gtk_theme"
gsettings set $s icon-theme "$icon_theme"
gsettings set $s cursor-theme "$cursor_theme"
gsettings set $s cursor-size "$cursor_size"
gsettings set $s color-scheme prefer-dark

echo "gtk: theme=$gtk_theme icons=$icon_theme cursor=$cursor_theme dark=on"
