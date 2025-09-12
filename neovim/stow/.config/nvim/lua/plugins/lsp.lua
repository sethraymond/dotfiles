return {
	{
		'mason-org/mason-lspconfig.nvim',
		opts = {},
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'neovim/nvim-lspconfig',
		},
	},
	{'L3MON4D3/LuaSnip'},
	{'mfussenegger/nvim-lint'},
	{'onsails/lspkind.nvim'},
	{
		'folke/lazydev.nvim',
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		'hrsh7th/nvim-cmp',
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0,
			})
		end,
	},
	{'hrsh7th/cmp-nvim-lsp'},
	{
	  "linux-cultist/venv-selector.nvim",
	  dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	  },
	  lazy = false,
	  keys = {
		{ ",v", "<cmd>VenvSelect<cr>" },
	  },
	  ---@type venv-selector.Config
	  opts = {
		search = {
			my_venvs = {
				command = "fd python$ /opt/venv/"
			}
		}
	  },
	},
}
