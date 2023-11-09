#!/usr/bin/env bash
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# get_option: (option_name: string, default_value: string) -> string
get_option() {
  local option_name option_value default_value
  option_name="$1"
  default_value="$2"
  option_value=$(tmux show-option -gqv "$option_name")

  if [ -n "$option_value" ]
  then
    if [ "$option_value" = "null" ]
    then
      echo ""
    else
      echo "$option_value"
    fi
  else
    echo "$default_value"
  fi
}

main() {
  local theme=$(get_option "@bettervim_theme" "catppuccin")
  
  # Evaluating theme tokens (e.g src/nord.theme)
  while IFS='=' read -r key val; do
    [ "${key##\#*}" ] || continue
    eval "local theme_$key"="$val"
  done < "$CURRENT_DIR/$theme.theme"

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

main "$@"
