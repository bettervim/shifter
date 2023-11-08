#!/usr/bin/env bash
main() {
  local theme_neutral_100="white"
  local theme_neutral_200="#4E5668"
  local theme_neutral_400="#3C4251"
  local theme_primary="#94BECE"

  tmux set -g status-position bottom
  tmux set -g status-justify left
  tmux set -g status-left ''
  tmux set -g status-bg "$theme_neutral_400"
  tmux set -g status-fg "$theme_neutral_100"

  ## Right
  tmux set -g status-right "#[fg=$theme_neutral_100,bg=$theme_neutral_200 bold] #S "

  ## Current window
  tmux setw -g window-status-current-style "fg=$theme_neutral_400 bg=$theme_primary bold"
  tmux setw -g window-status-current-format " #I#[fg=$theme_neutral_400] "

  ## Other windows
  tmux setw -g window-status-style "fg=$theme_neutral_100 "
  tmux setw -g window-status-format " #I#[fg=$theme_neutral_100] "
}

main
