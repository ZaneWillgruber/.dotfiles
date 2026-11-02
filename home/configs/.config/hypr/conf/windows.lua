-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.workspace_rule({ workspace = 1, monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = 2, monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = 3, monitor = "DP-1", default = true })

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	name = "ignoreMax",
	match = { class = ".*" },

	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "dragFix",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- special godot launcher view
hl.window_rule({
	name = "godot-launcher",
	match = {
		class = "Godot",
		title = "Godot Engine - Project Manager",
	},
	float = true,
})

-- workspace for steam, need a little more than the others because of the notifs
hl.window_rule({
	name = "steam1",
	match = { class = "^([Ss]team)$", title = "negative:[Ss]team.*" },

	float = true,
})

hl.window_rule({
	name = "steam2",
	match = { class = "^([Ss]team)$", title = "^([Ss]team)$" },

	workspace = "special:steam silent",
	tile = true,
})

-- special workspace for spotify
hl.window_rule({
	name = "spotify",
	match = { class = "^([Ss]potify)$" },

	workspace = "special:spotify",
})

-- always put discord on a specific workspace
hl.window_rule({
	name = "discord",
	match = { class = "^(discord)$" },

	workspace = 3,
})

-- for terminal
hl.window_rule({
	name = "terminal",
	match = { class = "^(com.mitchellh.ghostty)$" },

	no_blur = true,
	opacity = "1.25 1",
})

hl.window_rule({
	name = "jellyfin",
	match = { class = "^(org.jellyfin.JellyfinDesktop)$" },

	opacity = "2",
})

-- blur
hl.layer_rule({
	name = "defaultBlur",
	match = { namespace = "waybar" },

	blur = true,
	ignore_alpha = 0.5,
})

-- sway blur
hl.layer_rule({
	name = "swayNotif",
	match = { namespace = "swaync-control-center" },

	blur = true,
	ignore_alpha = 0.4,
})

hl.layer_rule({
	name = "swayControl",
	match = { namespace = "swaync-notification-window" },

	blur = true,
	ignore_alpha = 0,
})
