-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Laptop (a sane default; the script below owns the docked layout)
hl.monitor({ output = "eDP-1", mode = "3840x2400@59.99", position = "0x0", scale = 2 })

-- External monitors are NOT configured statically here on purpose:
--   * the dock shuffles DP-N connector names on every boot, and
--   * it exposes a phantom output cloning the FB4XR83 serial.
-- Static `monitor=DP-N,...` or `desc:` rules can't handle either reliably.
-- Instead, fix-dock-monitors.sh matches by serial at runtime, disables the
-- phantom, and places the two real externals. It also re-applies on hotplug.
hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/fix-dock-monitors.sh --watch")
end)

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
