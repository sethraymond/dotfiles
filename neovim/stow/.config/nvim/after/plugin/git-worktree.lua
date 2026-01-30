require("git-worktree").setup()
require("telescope").load_extension("git_worktree")

vim.keymap.set(
	"n",
	"<leader>gw",
	require("telescope").extensions.git_worktree.git_worktrees,
	{ desc = "[g]it [w]orktree" }
)
vim.keymap.set(
	"n",
	"<leader>gW",
	require("telescope").extensions.git_worktree.create_git_worktree,
	{ desc = "create [g]it [W]orktree" }
)
