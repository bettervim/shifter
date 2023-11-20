#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @shifter_theme "catppuccin:latte"

"$current_dir"/src/main.sh
