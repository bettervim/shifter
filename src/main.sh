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

replace_modules_by_key() {
    local original_string="$1"
    shift

    while (( "$#" )); do
        local key="$1"
        local value="$2"
        original_string="${original_string//$key/$value}"
        shift 2
    done

    echo "$original_string"
}

get_theme_name(){
  local raw_name=$(get_option "@shifter_theme" "catppuccin")
  local parsed_name="$(echo "$raw_name" | sed 's/:/-/')"
  echo "$parsed_name"
}

## -- Evaluating theme tokens -----------------------------
theme=$(get_theme_name)
source "$CURRENT_DIR/themes/$theme.sh"
# --------------------------------------------------------- 

get_current_window_layout(){
  # -- Window Mode -----------------------------------------
  local default_modules=" #number #name "
  local window_modules=$(get_option "@shifter_window_modules" "$default_modules")
  # ---------------------------------------------------------
  local layout=$(replace_modules_by_key "$window_modules" "#number" "$WINDOW_NUMBER" "#name" "$WINDOW_NAME")
  echo " $layout "
}

get_session_name_module() {
  local session_name_styles="#[fg=$theme_neutral_400 bg=$theme_primary bright]"
  local session_name_layout="$SESSION_NAME "
  local session_name_separator="#[fg=$theme_primary]$global_left_separator"
  local session_name_module="$session_name_separator$session_name_styles $session_name_layout"
  
  echo "$session_name_module"
}

get_clock_module() {
  local clock_styles="#[fg=$theme_neutral_100,bg=$theme_neutral_200]"
  local clock_separator="#[fg=$theme_neutral_200]$global_left_separator"
  local clock_layout=" %H:%M "
  local clock_module="$clock_separator$clock_styles$clock_layout"

  echo "$clock_module"
}

get_hostname_module() {
  local hostname_styles="#[fg=$theme_neutral_100,bg=$theme_neutral_200]"
  local hostname_separator="#[fg=$theme_neutral_200]$global_left_separator"
  local hostname_layout=" #H "
  local hostname_module="$hostname_separator$hostname_styles$hostname_layout"
  
  echo "$hostname_module"
}

get_aside_layout(){
  local default_modules=$(get_option "@shifter_aside_modules" "#clock#session-name")
  local session_name_module=$(get_session_name_module)
  local clock_module=$(get_clock_module)
  local hostname_module=$(get_hostname_module)
  
local layout=$(replace_modules_by_key \
  "$default_modules" \
  "#clock" "$clock_module" \
  "#session-name" "$session_name_module" \
  "#hostname" "$hostname_module" \
  )

  echo "$layout"
}

get_status_left_layout(){
  local default_modules=""
  local session_name_module=$(get_session_name_module)
  local layout=$(replace_modules_by_key \
    "$default_modules" \
    "#session-name" "$session_name_module" \
  )
  
  echo "$layout"
}

main() {
  local global_left_separator=$(get_option "@shifter_left_separator" "")
  local global_status_position=$(get_option "@shifter_status_position" "bottom")

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
  local aside_layout=$(get_aside_layout)
  tmux set -g status-right "$aside_layout"
  tmux set -g status-right-length 100
  # ---------------------------------------------------------------

  ## -- Left ------------------------------------------------------
  local status_left_layout=$(get_status_left_layout)
  tmux set -g status-left-length 100
  tmux set -g status-left "$status_left_layout"
  # ---------------------------------------------------------------

}

main "$@"
