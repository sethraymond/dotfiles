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
		lazy = false,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
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
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "[L]azy[G]it" },
		},
	},
	{
		"ThePrimeagen/git-worktree.nvim",
	},
}
