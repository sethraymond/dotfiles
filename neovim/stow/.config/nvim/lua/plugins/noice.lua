return {
	{

		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "MunifTanjim/nui.nvim" },
	{
		"rcarriga/nvim-notify",
		config = function()
			require("telescope").load_extension("notify")
		end,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
}
