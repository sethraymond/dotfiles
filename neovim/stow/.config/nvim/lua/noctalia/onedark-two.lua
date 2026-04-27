local M = {}

function M.setup()
	require("onedark").setup({
		colors = {
			black = "#0e1013",
			bg0 = "#21252b",
			bg1 = "#282c34",
			bg2 = "#313640",
			bg3 = "#666e7e",
			bg_d = "#1d1f23",
			bg_blue = "#393e47",
			bg_yellow = "#e8c88c",
			fg = "#c9ccd3",
			fg_dark = "#78c4ce",
			fg_light = "#e6e6e6",

			purple = "#d3a2e2",
			green = "#a8cc8e",
			orange = "#cc9057",
			blue = "#71b9f4",
			yellow = "#eac786",
			cyan = "#78c4ce",
			red = "#e68991",
			grey = "#535965",

			light_grey = "#7a818e",
			dark_cyan = "#62bac6",
			dark_red = "#e27881",
			dark_yellow = "#eac786",
			dark_purple = "#c88bda",
			diff_add = "#272e23",
			diff_delete = "#2d2223",
			diff_change = "#172a3a",
			diff_text = "#274964",

			comment = "#666e7e",
		},
	})

	require("onedark").load()
end

return M
