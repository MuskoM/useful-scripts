local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
	config.keys = {
		-- Command palette
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action.ActivateCommandPalette,
		},
		-- Splits/Panes
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
		{
			key = "q",
			mods = "LEADER",
			action = wezterm.action.PaneSelect,
		},
		{
			key = "h",
			mods = "ALT|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "ALT|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "ALT|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "ALT|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		-- ToggleFullScreen
		{
			key = "F",
			mods = "LEADER",
			action = wezterm.action.ToggleFullScreen,
		},
	}
end
return module
