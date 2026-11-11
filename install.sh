#!/usr/bin/env bash
# Install the packages listed in packages/*.txt (install only; never removes).
#
#   ./install.sh            base.txt + every packages/*.txt
#   ./install.sh hypr kitty only packages/hypr.txt and packages/kitty.txt
#
# Safe to re-run: yay --needed skips anything already installed.
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/packages"

command -v yay >/dev/null || { echo "error: yay not found" >&2; exit 1; }

if (($#)); then
	lists=()
	for name in "$@"; do
		f="$dir/${name%.txt}.txt"
		[[ -f $f ]] || { echo "error: no list for '$name' ($f)" >&2; exit 1; }
		lists+=("$f")
	done
else
	shopt -s nullglob
	lists=("$dir"/*.txt)
	((${#lists[@]})) || { echo "error: no lists in $dir" >&2; exit 1; }
fi

# Strip comments and whitespace, drop blank lines, dedupe.
mapfile -t pkgs < <(sed -e 's/#.*//' -e 's/[[:space:]]//g' "${lists[@]}" | grep -v '^$' | sort -u)

((${#pkgs[@]})) || { echo "nothing to install"; exit 0; }

echo "lists: ${lists[*]##*/}"
echo "packages: ${pkgs[*]}"
yay -S --needed -- "${pkgs[@]}"
