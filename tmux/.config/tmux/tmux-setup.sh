#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm tmux git

git clone https://github.com/tmux-plugins/tpm ~/Jetragapult/tmux/.config/tmux/plugins/tpm
