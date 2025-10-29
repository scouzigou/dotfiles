local wezterm = require("wezterm")

return {
	-- appearance
	color_scheme = "tokyonight_night",
	font = wezterm.font("MesloLGS Nerd Font"),
	font_size = 11,
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 1,
		bottom = 0,
	},
	use_fancy_tab_bar = false,
	default_cursor_style = "BlinkingBlock",
	animation_fps = 30,

	-- general
	check_for_updates = false,
	warn_about_missing_glyphs = false,
	enable_wayland = false,
	exit_behavior = "Close",
}
