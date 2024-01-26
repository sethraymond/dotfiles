vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[g]it [s]tatus" })
vim.keymap.set("n", "<leader>gl", vim.cmd.Flogsplit, { desc = "[g]it [l]og" })
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.cmd("EnableBlameLine")
	end,
})
vim.keymap.set("n", "<leader>gb", "<cmd> ToggleBlameLine<CR>", { desc = "Toggle [g]it [b]lame" })
