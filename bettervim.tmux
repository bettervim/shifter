#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @bettervim_theme "everforest"
"$current_dir"/src/bettervim.sh
