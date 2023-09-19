return {
	{
		"folke/which-key.nvim"
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"navarasu/onedark.nvim"
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"mbbill/undotree",
		lazy = false,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"tpope/vim-sleuth",
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"chentoast/marks.nvim",
		lazy = false,
		config = function ()
			require("marks").setup {
				builtin_marks = { ".", "<", ">", "^" },
			}
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = 'onedark',
				component_separators = "|",
				section_separators = '',
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = '|',
			show_trailing_blankline_indent = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {}
	},
}
