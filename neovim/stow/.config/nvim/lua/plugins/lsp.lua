return {
	{'neovim/nvim-lspconfig'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'L3MON4D3/LuaSnip'},
	{'mfussenegger/nvim-lint'},
	{'onsails/lspkind.nvim'},
	{'folke/neodev.nvim'},
	{
	  "linux-cultist/venv-selector.nvim",
	  dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	  },
	  lazy = false,
	  branch = "regexp", -- This is the regexp branch, use this for the new version
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
