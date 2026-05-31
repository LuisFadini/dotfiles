local colors = require("colors")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,

		col = { active_border = colors.primary, inactive_border = colors.tertiary_fixed_dim },

		resize_on_border = true,

		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 3,

		active_opacity = 1.0,
		inactive_opacity = 0.9,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = colors.shadow,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,

			vibrancy = 0.1696,
		},
	},

	cursor = {
		zoom_detached_camera = false,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	xwayland = {
		force_zero_scaling = true,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},

	misc = {
		disable_hyprland_logo = true,
	},
})
