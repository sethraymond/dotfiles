vim.g.mapleader = " "

-- Normal mode keymaps
vim.keymap.set("n", "<CR>", "o<Esc>k", { desc = "Add new line below cursor" })
vim.keymap.set("n", "<leader>ln", "<cmd> set nu! <CR>", { desc = "Set line numbers" })
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Set relative line numbers" })
vim.keymap.set("n", "<Esc>", vim.cmd.noh, { desc = "Clear search highlighting" })

-- Insert mode keymaps
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Visual mode keymaps
vim.keymap.set("v", "<", "<gv", { desc = "Indent and stay in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and stay in visual mode" })
