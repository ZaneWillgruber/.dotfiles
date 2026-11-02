#!/usr/bin/env bash
# Toggle power-saver <-> balanced via power-profiles-daemon.
# Use the system python (the linuxbrew python3 on PATH lacks the gi module).
export PATH=/usr/bin:$PATH
ppc() { /usr/bin/python3 /usr/bin/powerprofilesctl "$@"; }

if [[ $1 = "-t" ]]; then
  if [[ $(ppc get) = power-saver ]]; then
    ppc set balanced
    notify-send "Power" "Balanced mode" -i battery
  else
    ppc set power-saver
    notify-send "Power" "Power saver ON" -i battery-caution
  fi
  pkill -RTMIN+9 waybar
  exit
fi

profile=$(ppc get)
case $profile in
  power-saver) echo "{\"text\":\"󰌪\",\"class\":\"saver\",\"tooltip\":\"Power saver (click for balanced)\"}" ;;
  performance) echo "{\"text\":\"󱐋\",\"class\":\"performance\",\"tooltip\":\"Performance (click for power saver)\"}" ;;
  *)           echo "{\"text\":\"󰾅\",\"class\":\"balanced\",\"tooltip\":\"Balanced (click for power saver)\"}" ;;
esac
