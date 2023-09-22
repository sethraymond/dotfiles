vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[g]it [s]tatus" })
vim.keymap.set("n", "<leader>gl", vim.cmd.Flogsplit, { desc = "[g]it [l]og" })
vim.keymap.set("n", "<leader>gp", "<cmd> Git push<CR>", { desc = "[g]it [p]ush" })
