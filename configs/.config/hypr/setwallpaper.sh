#!/usr/bin/env bash

sleep 2

WALLPAPER_DIR="$HOME/.config/hypr/conf/wallpapers/"
CURRENT_WALL=$(hyprctl hyperpaper listloaded)

WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

hyprctl hyprpaper reload ,"$WALLPAPER"
