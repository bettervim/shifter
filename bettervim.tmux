#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @bettervim_status_position "bottom"
tmux set -g @bettervim_theme "everforest"
tmux set -g @bettervim_window_mode "name"
"$current_dir"/src/bettervim.sh
