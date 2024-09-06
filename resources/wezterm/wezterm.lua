local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "powershell", "-NoLogo" }

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font("Fira Code")

config.window_background_image = "C:/Users/MuskoM/.config/wezterm/bg.jpg"
config.window_background_image_hsb = {
	brightness = 0.05,
	saturation = 0.7,
}

config.window_frame = {
	font_size = 13.0,

	active_titlebar_bg = "#24273a",
	inactive_titlebar_bg = "#1e2030",
}

config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#5b6078",
			fg_color = "#cad3f5",
		},
		inactive_tab = {
			bg_color = "#363a4f",
			fg_color = "#a5adcb",
			intensity = "Half",
		},
		new_tab = {
			bg_color = "#8aadf4",
			fg_color = "#1e2030",
		},
	},
}

return config
