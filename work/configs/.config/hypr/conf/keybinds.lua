-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("conf.programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd("swaync-client -t sw"))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + G",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(programs.menu))
-- hl.bind(mainMod .. " + P",   hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd("~/.config/hypr/wallpaper.sh"))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + X",   hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd([[cliphist list | wofi --dmenu --pre-display-cmd "echo '%s' | cut -f 2" | cliphist decode | wl-copy]]))

-- Other shit
hl.bind("ALT + r", hl.dsp.exec_cmd("~/.config/swaync/refresh.sh"))
hl.bind("ALT + B", hl.dsp.exec_cmd("~/.config/waybar/scripts/select.sh"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- HyprShot
-- Screenshot a window
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot a monitor
hl.bind("PRINT",               hl.dsp.exec_cmd("hyprshot -m output"))
-- Screenshot a region
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
-- Record a region
hl.bind(mainMod .. " + equal",         hl.dsp.exec_cmd([[LIBVA_DRIVER_NAME=iHD wl-screenrec -g "$(slurp)" -f "$HOME/Videos/recording-$(date +%F-%H%M%S).mp4"]]))
-- Stop recording
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.exec_cmd("pkill -INT -x wl-screenrec"))

-- Special workspaces (scratchpads)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("steam"))
hl.bind(mainMod .. " + Y",         hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mainMod .. " + T",         hl.dsp.workspace.toggle_special("teams"))
hl.bind(mainMod .. " + O",         hl.dsp.workspace.toggle_special("obsidian"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
