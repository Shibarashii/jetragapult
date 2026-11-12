#!/usr/bin/env bash
# Thunar: default folder handler, "Open Terminal Here" (kitty), SMB bookmark.
# Packages: packages/base.txt (thunar, gvfs-smb, …). Theme: scripts/gtk.sh.
set -euo pipefail

cfg="${XDG_CONFIG_HOME:-$HOME/.config}"

# Open folders in Thunar instead of the CachyOS default (Dolphin).
xdg-mime default thunar.desktop inode/directory
echo "thunar: default for folders = $(xdg-mime query default inode/directory)"

# Custom action. Thunar rewrites uca.xml from its GUI, so it can't be a stow
# symlink: only add the action when it's missing, keeping a backup.
uca="$cfg/Thunar/uca.xml"
mkdir -p "$cfg/Thunar"
if [[ -f $uca ]] && grep -q 'kitty --directory' "$uca"; then
	echo "thunar: 'Open Terminal Here' already set"
else
	[[ -f $uca ]] && cp "$uca" "$uca.bak" && echo "thunar: backed up $uca.bak"
	cat > "$uca" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<actions>
<action>
	<icon>utilities-terminal</icon>
	<name>Open Terminal Here</name>
	<submenu></submenu>
	<unique-id>jetragapult-open-terminal</unique-id>
	<command>kitty --directory %f</command>
	<description>Open kitty in this folder</description>
	<range></range>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
</action>
</actions>
XML
	echo "thunar: wrote 'Open Terminal Here' (kitty)"
fi

# Sidebar bookmark for the home server's share.
bookmarks="$cfg/gtk-3.0/bookmarks"
bookmark="smb://192.168.1.18/shared/ Rotom"
mkdir -p "$cfg/gtk-3.0"
if grep -qF "${bookmark% *}" "$bookmarks" 2>/dev/null; then
	echo "thunar: bookmark already set"
else
	echo "$bookmark" >> "$bookmarks"
	echo "thunar: added bookmark $bookmark"
fi

# Restart the Thunar daemon so it picks up the changes.
thunar -q 2>/dev/null || true
