#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @shifter_theme "catppuccin:frappe"
tmux set -g @shifter_window_modules "#number"
tmux set -g @shifter_left_separator ""

"$current_dir"/src/main.sh
