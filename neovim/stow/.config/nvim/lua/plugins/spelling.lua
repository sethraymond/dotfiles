return {
	-- "psliwka/vim-dirtytalk",
	"sak96/vim-dirtytalk",
	build = ":DirtytalkUpdate",
	config = function()
		vim.opt.spelllang = { "en", "programming" }
	end,
}
