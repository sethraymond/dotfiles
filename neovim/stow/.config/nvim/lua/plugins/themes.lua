return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000, -- load before most UI stuff
	},
	{
		"RRethy/base16-nvim",
		config = function()
			require("noctalia.matugen").setup()
		end,
	},
}
