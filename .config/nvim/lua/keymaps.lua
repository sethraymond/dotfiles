vim.g.mapleader = " "

-- Normal mode keymaps
vim.keymap.set("n", "<CR>", "o<Esc>k") -- Enter adds new line below cursor
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ln", "<cmd> set nu! <CR>")
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>")

-- Insert mode keymaps
vim.keymap.set("i", "jk", "<Esc>") -- Insert -> Normal

-- Visual mode keymaps
vim.keymap.set("v", "<", "<gv") -- indent and stay in visual mode
vim.keymap.set("v", ">", ">gv") -- indent and stay in visual mode
