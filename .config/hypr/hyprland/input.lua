hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
			disable_while_typing = false,
		},
	},
})

hl.device({
	name = "sscypl-wireless-receiver",
	accel_profile = "flat",
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
