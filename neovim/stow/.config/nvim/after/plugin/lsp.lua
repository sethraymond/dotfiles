require("neoconf").setup({})

-- require('lint').linters_by_ft = {
-- 	python = {'flake8'},
-- }

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end
})

local lspkind = require('lspkind')
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
	sources = {
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp" },
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	formatting = {
		expandable_indicator = true,
		fields = cmp.ItemField.menu,
		format = lspkind.cmp_format({
			mode = "symbol",
			max_width = 50,
			symbol_map = { Copilot = "" }
		})
	},
	mapping = {
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ cmp_select })
			else
				fallback()
			end
		end, { "i", "s" }),
		['<CR>'] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
		}),
		['<C-Space>'] = cmp.mapping.complete(),
	}
}

require('mason').setup()
require('mason-lspconfig').setup({
	automatic_installation = true,
	automatic_enable = true,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
			[vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
			[vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.HINT] = '',
			[vim.diagnostic.severity.INFO] = '',
		}
	},
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my_lsp_keymaps', {}),
	callback = function()
		local bufmap = function(mode, lhs, rhs, desc)
			local opts = { buffer = true, remap = false, desc = desc }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		bufmap("n", "gd", function() vim.lsp.buf.definition() end, "LSP [g]et [d]efinition")
		bufmap("n", "H", function() vim.lsp.buf.hover() end, "LSP [H]over")
		bufmap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, "[v]iew [w]orkspace [s]ymbol")
		bufmap("n", "<leader>vd", function() vim.diagnostic.open_float() end, "[v]iew [d]iagnostic")
		bufmap("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next [d]iagnostic")
		bufmap("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev [d]iagnostic")
		bufmap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, "[v]iew [c]ode [a]ction")
		bufmap("n", "<leader>vrr", function() vim.lsp.buf.references() end, "[v]iew code [r]eferences")
		bufmap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, "[r]e[n]ame")
		bufmap("i", "<leader>hs", function() vim.lsp.buf.signature_help() end, "[h]elp [s]ignature")
	end
})
