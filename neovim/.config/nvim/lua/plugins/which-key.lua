return {
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", '"', "'", "`", "c", "v",  "g" },
		config = function ()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup { }
		end
	},
}
