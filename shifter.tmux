#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux set -g @shifter_theme "everforest"
tmux set -g @shifter_aside_modules "#session-name "

"$current_dir"/src/main.sh
