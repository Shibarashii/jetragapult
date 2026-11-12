#!/usr/bin/env bash
# Noctalia: let the theme post_hook recolor Papirus folders without a password.
# noctalia/.config/noctalia/scripts/papirus-folders-sync.py runs
# `sudo -n papirus-folders`, which needs a NOPASSWD rule for that one binary.
# Packages: packages/noctalia.txt (papirus-icon-theme, papirus-folders).
set -euo pipefail

rule=/etc/sudoers.d/papirus-folders
bin="$(command -v papirus-folders)" || {
	echo "error: papirus-folders not installed (./install.sh noctalia)" >&2
	exit 1
}

if sudo -n -l "$bin" >/dev/null 2>&1; then
	echo "noctalia: sudo -n $bin already allowed"
	exit 0
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
printf '%s ALL=(root) NOPASSWD: %s\n' "$(id -un)" "$bin" > "$tmp"

# Validate before installing: a broken sudoers file can lock up sudo.
visudo -cqf "$tmp"
sudo install -m 440 -o root -g root "$tmp" "$rule"
if ! sudo visudo -cq; then
	sudo rm -f "$rule"
	echo "error: sudoers check failed; removed $rule" >&2
	exit 1
fi
echo "noctalia: added $rule ($(id -un) may run $bin without a password)"
echo "noctalia: change the wallpaper or theme once to re-run the folder color sync"
