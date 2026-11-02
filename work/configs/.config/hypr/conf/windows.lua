-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Bind by panel identity, not by connector name: the dock hands out different
-- DP-N numbers on every boot, so hardcoding them silently sends 2 and 3 to the
-- same monitor. See conf/monitor.lua for how the selector is built.
local monitors = require("conf.monitor")

hl.workspace_rule({ workspace = 1, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 2, monitor = monitors.desc_for(monitors.LEFT_SERIAL), default = true })
hl.workspace_rule({ workspace = 3, monitor = monitors.desc_for(monitors.RIGHT_SERIAL), default = true })

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

-- workspace for steam, need a little more than the others because of the notifs
hl.window_rule({
	name = "steam1",
	match = { class = "^([Ss]team)$", title = "^((?![Ss]team.*))$" },

	float = true,
})

hl.window_rule({
	name = "steam2",
	match = { class = "^([Ss]team)$", title = "^([Ss]team)$" },

	workspace = "special:steam silent",
	tile = true,
})

hl.window_rule({
	name = "steam3",
	match = { class = "^([Ss]team)$", title = "^([Ss]team)$" },

	tile = true,
})

-- special workspace for spotify
hl.window_rule({
	name = "spotify",
	match = { class = "^([Ss]potify)$" },

	workspace = "special:spotify silent",
})

-- special workspace for teams
hl.window_rule({
	name = "teams",
	match = { class = "^(teams-for-linux)$" },

	workspace = "special:teams",
})

-- special workspace for obsidian
hl.window_rule({
	name = "md.obsidian.Obsidian",
	match = { class = "^(obsidian)$" },

	workspace = "special:obsidian silent",
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

	no_blur = false,
	opacity = "1 1",
})

hl.window_rule({
	name = "jellyfin",
	match = { class = "^(org.jellyfin.JellyfinDesktop)$" },

	opacity = "2",
})
