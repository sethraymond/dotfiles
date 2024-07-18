return {
	{
		"tpope/vim-fugitive",
	},
	{
		"rbong/vim-flog",
		lazy = false,
	},
	{
		"f-person/git-blame.nvim",
		lazy = false
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "[l]azy[g]it"}
		}
	}
}
