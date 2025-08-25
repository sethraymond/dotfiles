local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function() builtin.find_files(); end, { desc = "[p]roject [f]ind files" })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Search git project" })
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("🔍 "), hidden = true }); end, { desc = "[p]roject [s]earch string" })
vim.keymap.set('v', '<leader>ps', function() builtin.grep_string(); end, { desc = "[p]roject [s]earch string" })
vim.keymap.set('n', '<leader>gr', function() builtin.live_grep(); end, { desc = "[g][r]ep" })
vim.keymap.set('n', '<leader>fM', builtin.marks, { desc = "[f]ind [m]ark" })
