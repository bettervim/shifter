#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @shifter_theme "catppuccin"
tmux set -g @shifter_window_modules "#number"

"$current_dir"/src/main.sh
