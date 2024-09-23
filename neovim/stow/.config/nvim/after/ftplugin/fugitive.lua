vim.api.nvim_buf_set_keymap(0, "n", "gp", "<cmd> :G push<CR>", { desc = "[g]it [p]ush" })
vim.api.nvim_buf_set_keymap(0, "n", "sw", "<cmd> :G switch -<CR>", { desc = "[s][w]itch to last branch" })
