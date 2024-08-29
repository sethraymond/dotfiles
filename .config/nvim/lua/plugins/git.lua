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
			"nvim-telescope/telescope.nvim"
		},
	}
}
