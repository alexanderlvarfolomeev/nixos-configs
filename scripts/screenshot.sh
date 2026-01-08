#!/usr/bin/env bash
# from https://github.com/basecamp/omarchy/blob/master/bin/omarchy-cmd-screenshot

OUTPUT_DIR="${GRIM_DEFAULT_DIR:-${XDG_PICTURES_DIR:-$HOME/Pictures}}"

if [[ ! -d "$OUTPUT_DIR" ]]; then
  notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000
  exit 1
fi

pkill slurp && exit 0

MODE="${1:-fullscreen}"
PROCESSING="${2:-satty}"

get_rectangles() {
  local active_workspace=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
  hyprctl monitors -j | jq -r --arg ws "$active_workspace" '.[] | select(.activeWorkspace.id == ($ws | tonumber)) | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"'
  hyprctl clients -j | jq -r --arg ws "$active_workspace" '.[] | select(.workspace.id == ($ws | tonumber)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

# Select based on mode
case "$MODE" in
  region)
    wayfreeze & PID=$!
    sleep .1
    SELECTION=$(slurp 2>/dev/null)
    kill $PID 2>/dev/null
    ;;
  windows)
    wayfreeze & PID=$!
    sleep .1
    SELECTION=$(get_rectangles | slurp -r 2>/dev/null)
    kill $PID 2>/dev/null
    ;;
  fullscreen|*)
    SELECTION=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"')
    ;;
esac

[ -z "$SELECTION" ] && exit 0

if [[ $PROCESSING == "satty" ]]; then
grim -g "$SELECTION" - |
  satty --filename - \
    --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
    --early-exit \
    --actions-on-enter save-to-clipboard \
    --save-after-copy \
    --copy-command 'wl-copy'
else
  grim -g "$SELECTION" - | wl-copy
fi