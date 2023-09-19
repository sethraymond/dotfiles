return {
	{
		"chentoast/marks.nvim",
		lazy = false,
		config = function ()
			require("marks").setup {
				builtin_marks = { ".", "<", ">", "^" },
			}
		end,
	},
}
