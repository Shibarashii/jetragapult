#!/usr/bin/env bash
# Run the per-app setup scripts in scripts/ (settings that live outside stow).
#
#   ./setup.sh              every scripts/*.sh, in name order
#   ./setup.sh gtk thunar   only scripts/gtk.sh and scripts/thunar.sh
#
# Each script is safe to re-run. Packages come first: ./install.sh
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"

if (($#)); then
	scripts=()
	for name in "$@"; do
		f="$dir/${name%.sh}.sh"
		[[ -f $f ]] || { echo "error: no script for '$name' ($f)" >&2; exit 1; }
		scripts+=("$f")
	done
else
	shopt -s nullglob
	scripts=("$dir"/*.sh)
	((${#scripts[@]})) || { echo "error: no scripts in $dir" >&2; exit 1; }
fi

for s in "${scripts[@]}"; do
	echo "==> ${s##*/}"
	bash "$s"
done
