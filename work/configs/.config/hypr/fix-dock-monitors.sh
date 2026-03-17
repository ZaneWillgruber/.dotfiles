#!/usr/bin/env bash
set -euo pipefail

LEFT_SERIAL="4C4XR83"
RIGHT_SERIAL="FB4XR83"

# Positioning for two 4K monitors side-by-side (0..7680 wide)
LEFT_POS="1920x0"
RIGHT_POS="5760x0"

# Laptop centered below (logical width = 3840/2 = 1920; center = (7680-1920)/2 = 2880)
LAPTOP_POS="0x0"

get_monitors_json() {
  hyprctl monitors -j
}

apply_layout() {
  local j
  j="$(get_monitors_json)"

  # Find all outputs that have these serials
  mapfile -t left_names  < <(printf '%s' "$j" | jq -r --arg s "$LEFT_SERIAL"  '.[] | select(.serial==$s) | .name')
  mapfile -t right_names < <(printf '%s' "$j" | jq -r --arg s "$RIGHT_SERIAL" '.[] | select(.serial==$s) | .name')

  # Pick the "best" name per serial: prefer 60Hz if available
  pick_best() {
    local serial="$1"
    printf '%s' "$j" | jq -r --arg s "$serial" '
      [.[] | select(.serial==$s)] 
      | sort_by(.refreshRate) 
      | last 
      | .name // empty
    '
  }

  local left_best right_best
  left_best="$(pick_best "$LEFT_SERIAL")"
  right_best="$(pick_best "$RIGHT_SERIAL")"

  # Disable duplicates for each serial (anything not best)
  for n in "${left_names[@]}"; do
    [[ "$n" == "$left_best" ]] || hyprctl keyword monitor "$n,disable" >/dev/null
  done
  for n in "${right_names[@]}"; do
    [[ "$n" == "$right_best" ]] || hyprctl keyword monitor "$n,disable" >/dev/null
  done

  # If we have both unique externals, set them explicitly
  if [[ -n "$left_best" && -n "$right_best" ]]; then
    hyprctl keyword monitor "$left_best,3840x2160@60,$LEFT_POS,1"  >/dev/null
    hyprctl keyword monitor "$right_best,3840x2160@60,$RIGHT_POS,1" >/dev/null

    # Laptop below (or comment this out and disable eDP-1 if you prefer)
    hyprctl keyword monitor "eDP-1,3840x2400@60,$LAPTOP_POS,2" >/dev/null
    # If you'd rather disable laptop when docked, use this instead:
    # hyprctl keyword monitor "eDP-1,disable" >/dev/null
  else
    # Undocked (or partially docked): keep laptop sane
    hyprctl keyword monitor "eDP-1,3840x2400@60,0x0,2" >/dev/null
  fi
}

if [[ "${1:-}" == "--watch" ]]; then
  apply_layout
  sock="/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
  socat -u UNIX-CONNECT:"$sock" - | while read -r line; do
    case "$line" in
      monitoradded*|monitorremoved*|configreloaded*)
        apply_layout
        ;;
    esac
  done
else
  apply_layout
fi
