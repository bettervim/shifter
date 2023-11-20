#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @shifter_theme "nord"
tmux set -g @shifter_window_mode "number"
"$current_dir"/src/main.sh
