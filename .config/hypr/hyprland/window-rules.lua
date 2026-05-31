hl.window_rule({
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
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

hl.window_rule({
	match = {
		class = "(?i)(xarchiver|org.gnome.calculator|org.pulseaudio.pavucontrol|blueman-manager)",
	},
	float = true,
	center = true,
})
