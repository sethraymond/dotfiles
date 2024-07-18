local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local scheme = wezterm.color.get_builtin_schemes()['OneDark (Gogh)']
scheme.foreground = '#ABB2BF'
scheme.cursor_fg = scheme.foreground
scheme.cursor_bg = scheme.foreground
scheme.cursor_border = scheme.foreground

config.color_schemes = {
	['Updated OneDark'] = scheme
}

config.color_scheme = 'Updated OneDark'

config.font = wezterm.font(
	'FiraCode Nerd Font',
	{ weight = 'Medium' }
)
config.font_size = 10.0
config.freetype_load_flags = 'NO_HINTING'

config.window_close_confirmation = 'NeverPrompt'

wezterm.on('gui-startup', function()
	local _, _, window = wezterm.mux.spawn_window{}
	window:gui_window():maximize()
end)

return config
