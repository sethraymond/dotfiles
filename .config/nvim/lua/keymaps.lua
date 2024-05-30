vim.g.mapleader = " "

-- Normal mode keymaps
vim.keymap.set("n", "<leader>ln", "<cmd> set nu! <CR>", { desc = "Set line numbers" })
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Set relative line numbers" })
vim.keymap.set("n", "<Esc>", vim.cmd.noh, { desc = "Clear search highlighting" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines leaves cursor at beginning of line" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Moving down leaves cursor in column" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Moving up leaves cursor in column" })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

-- Insert mode keymaps
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Visual mode keymaps
vim.keymap.set("v", "<", "<gv", { desc = "Indent and stay in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and stay in visual mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted block up a line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted block down a line" })

-- Other great remaps
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without clobbering other registers" })
