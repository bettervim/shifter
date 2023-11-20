#!/usr/bin/env bash
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

## -- tmux components aliases ----------------------
WINDOW_NAME="#W"
WINDOW_NUMBER="#I"
SESSION_NAME="#S"
## ------------------------------------------------

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

## -- Evaluating theme tokens -----------------------------
theme=$(get_option "@bettervim_theme" "catppuccin")
source "$CURRENT_DIR/$theme.sh"
# --------------------------------------------------------- 

get_current_window_layout(){
  # -- Window Mode -----------------------------------------
  # options: 'number' | 'name' | 'name-and-number'
  local window_mode=$(get_option "@bettervim_window_mode" "name")
  # ---------------------------------------------------------

  if [ "$window_mode" = "name" ]; then
    layout="$WINDOW_NAME"
  elif [ "$window_mode" = "number" ]; then
    layout="$WINDOW_NUMBER"
  else
    layout="$WINDOW_NUMBER $WINDOW_NAME"
  fi

  echo " $layout "
}

main() {
  local global_left_separator=$(get_option "@bettervim_left_separator" "")
  local global_status_position=$(get_option "@bettervim_status_position" "bottom")

  ## -- General -------------------------------------
  tmux set -g status-position "$global_status_position"
  tmux set -g status-justify left
  tmux set -g status-bg "$theme_neutral_400"
  tmux set -g status-fg "$theme_neutral_100"
  ## -----------------------------------------------
  
  ## UI
  ## -- Current Window ---------------------------------------------
  local current_window_styles="fg=$theme_neutral_400 bg=$theme_primary bright"
  local current_window_layout=$(get_current_window_layout)

  tmux set -g window-status-current-style "$current_window_styles"
  tmux set -g window-status-current-format "$current_window_layout"
  # ----------------------------------------------------------------
  
  # -- Windows -----------------------------------------------------
  local window_layout=$(get_current_window_layout)
  local window_styles="bg=$theme_neutral_200,fg=$theme_neutral_100,bright"
  ## -- The separator that lives between the windows
  tmux set -g window-status-separator ""
  tmux set -g window-status-style "$window_styles"
  tmux set -g window-status-format "$window_layout"
  # ---------------------------------------------------------------

  ## -- Right -----------------------------------------------------
  local session_name_styles="#[fg=$theme_neutral_400 bg=$theme_primary bright]"
  local session_name_layout="$SESSION_NAME "
  local session_name_separator="#[fg=$theme_primary]$global_left_separator"
  local session_name="$session_name_separator$session_name_styles $session_name_layout"
  local clock_styles="#[fg=$theme_neutral_100,bg=$theme_neutral_200]"
  local clock_layout="%H:%M"
  local clock_module="$clock_styles $clock_layout"
  local date_module=""
  tmux set -g status-right "$clock_module$session_name"
  tmux set -g status-right-length 100

  # ---------------------------------------------------------------

  ## -- Left ------------------------------------------------------
  tmux set -g status-left-length 100
  tmux set -g status-left ''
  # ---------------------------------------------------------------

}

main "$@"
