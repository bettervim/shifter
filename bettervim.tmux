#!/usr/bin/env bash
main() {
  display "$1"
  # Everforest
  # theme_neutral_100="#FAFAFA"
  # theme_neutral_400="#3D484D"
  # theme_primary="#A7C080"

  # Nord
  theme_neutral_100="white"
  theme_neutral_200="#4E5668"
  theme_neutral_400="#3C4251"
  theme_primary="#94BECE"

  set -g status-position bottom
  set -g status-justify left
  set -g status-left ''
  set -g status-bg "$theme_neutral_400"
  set -g status-fg "$theme_neutral_100"

  ## Right
  set -g status-right "#[fg=$theme_neutral_100,bg=$theme_neutral_200 bold] #S "

  ## Current window
  setw -g window-status-current-style "fg=$theme_neutral_400 bg=$theme_primary bold"
  setw -g window-status-current-format " #I#[fg=$theme_neutral_400] "

  ## Features

  ## Other windows
  setw -g window-status-style "fg=$theme_neutral_100 "
  setw -g window-status-format " #I#[fg=$theme_neutral_100] "
}

display "BetterVim"
main "$@"
