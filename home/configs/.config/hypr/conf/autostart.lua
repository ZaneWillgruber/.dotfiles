-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Replaces exec-once: the handler fires once, on compositor start.

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("discord")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep .5 && awww restore")
    hl.exec_cmd("swaync")
    hl.exec_cmd("swaync-client -df")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("nm-applet")
end)
