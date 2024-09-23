require('osc52').setup({
	tmux_passthrough = true,
})

vim.keymap.set('n', '<leader>y', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>Y', '<leader>y_', {remap = true})
vim.keymap.set('v', '<leader>y', require('osc52').copy_visual)
