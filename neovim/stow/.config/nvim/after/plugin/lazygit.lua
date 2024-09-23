require("telescope").load_extension("lazygit")
vim.keymap.set('n',"<leader>lg", function() require('telescope').extensions.lazygit.lazygit(); end, { desc = "[l]azy[g]it" })
-- Makes it so that lazygit works in submodules (after you open a buffer in a submodule)
vim.api.nvim_create_autocmd({"BufEnter"}, {
	callback = function()
		require('lazygit.utils').project_root_dir()
	end
})

