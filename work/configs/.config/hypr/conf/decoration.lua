-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration

hl.config({
    decoration = {
        rounding       = 0,
        rounding_power = 2,

        active_opacity     = 1,
        inactive_opacity   = 0.95,
        fullscreen_opacity = 1,

        shadow = {
            enabled      = true,
            range        = 15,
            render_power = 5,
            color        = "rgba(0,0,0,0.5)",
        },

        blur = {
            enabled           = true,
            size              = 3,
            passes            = 5,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = false,
            popups            = true,
        },
    },
})

hl.layer_rule({
    name  = "blur_for_statusbar",
    match = { namespace = "quickshell" },

    blur = true,
})
