#!/bin/bash
# Clone tpm (tmux plugin manager). Packages: ~/Jetragapult/install.sh tmux
# Then start tmux and press prefix + I to install the plugins in tmux.conf.
set -euo pipefail

tpm="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm"

if [[ -d $tpm ]]; then
	echo "tpm already installed: $tpm"
else
	git clone https://github.com/tmux-plugins/tpm "$tpm"
fi
