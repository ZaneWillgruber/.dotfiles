#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Robust monitor layout for a dock that:
#   * shuffles DP-N connector names on every boot, and
#   * exposes a PHANTOM 3rd output cloning one monitor's serial (FB4XR83),
#     which shows up as a degraded (e.g. 30Hz) duplicate.
#
# Strategy: ignore connector names entirely. Match monitors by EDID serial,
# keep the best (highest-refresh) real output per serial, disable the rest
# (this kills the phantom), then place them deterministically.
# ---------------------------------------------------------------------------

# Physical arrangement (left -> right). Swap these two if the sides are wrong.
LEFT_SERIAL="4C4XR83"    # left external
RIGHT_SERIAL="FB4XR83"   # right external (the one with a phantom twin)

# Scale + mode for the externals (4K panels; 1.25 => 3072x1728 logical)
EXT_MODE="3840x2160@60"
EXT_SCALE="1.25"

# Laptop panel (stays on, top-left). scale 2 => 1920x1200 logical.
LAPTOP_MODE="3840x2400@59.99"
LAPTOP_SCALE="2"
LAPTOP_POS="0x0"

# Logical widths at the scales above:
#   laptop  = 3840/2    = 1920  -> occupies x 0..1920
#   left    = 3840/1.25 = 3072  -> place at 1920 -> x 1920..4992
#   right   = 3840/1.25 = 3072  -> place at 4992 -> x 4992..8064
LEFT_POS="1920x0"
RIGHT_POS="4992x0"

get_monitors_json() { hyprctl monitors -j; }

# Best output name for a serial = highest refresh rate among its outputs.
pick_best() {
  local serial="$1" j="$2"
  printf '%s' "$j" | jq -r --arg s "$serial" '
    [.[] | select(.serial==$s)]
    | sort_by(.refreshRate)
    | last
    | .name // empty
  '
}

apply_layout() {
  local j; j="$(get_monitors_json)"

  mapfile -t left_names  < <(printf '%s' "$j" | jq -r --arg s "$LEFT_SERIAL"  '.[] | select(.serial==$s) | .name')
  mapfile -t right_names < <(printf '%s' "$j" | jq -r --arg s "$RIGHT_SERIAL" '.[] | select(.serial==$s) | .name')

  local left_best right_best
  left_best="$(pick_best "$LEFT_SERIAL"  "$j")"
  right_best="$(pick_best "$RIGHT_SERIAL" "$j")"

  # Disable every duplicate/phantom (any output for these serials that isn't best).
  for n in "${left_names[@]}";  do [[ "$n" == "$left_best"  ]] || hyprctl keyword monitor "$n,disable" >/dev/null; done
  for n in "${right_names[@]}"; do [[ "$n" == "$right_best" ]] || hyprctl keyword monitor "$n,disable" >/dev/null; done

  if [[ -n "$left_best" && -n "$right_best" ]]; then
    # Docked with both externals: apply the full layout atomically.
    hyprctl --batch "\
      keyword monitor eDP-1,$LAPTOP_MODE,$LAPTOP_POS,$LAPTOP_SCALE ; \
      keyword monitor $left_best,$EXT_MODE,$LEFT_POS,$EXT_SCALE ; \
      keyword monitor $right_best,$EXT_MODE,$RIGHT_POS,$EXT_SCALE" >/dev/null
  else
    # Undocked / partially docked: just keep the laptop sane.
    hyprctl keyword monitor "eDP-1,$LAPTOP_MODE,0x0,$LAPTOP_SCALE" >/dev/null
  fi
}

if [[ "${1:-}" == "--watch" ]]; then
  apply_layout
  # Hyprland >=0.42 keeps sockets under $XDG_RUNTIME_DIR/hypr, not /tmp/hypr.
  runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
  sig="${HYPRLAND_INSTANCE_SIGNATURE:-}"
  sock=""
  for cand in "$runtime_dir/hypr/$sig/.socket2.sock" "/tmp/hypr/$sig/.socket2.sock"; do
    [[ -S "$cand" ]] && sock="$cand" && break
  done
  if [[ -z "$sock" ]]; then
    echo "fix-dock-monitors: could not find Hyprland event socket" >&2
    exit 1
  fi
  socat -u UNIX-CONNECT:"$sock" - | while read -r line; do
    case "$line" in
      monitoradded*|monitorremoved*|configreloaded*) apply_layout ;;
    esac
  done
else
  apply_layout
fi
