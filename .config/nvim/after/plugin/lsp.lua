require("neoconf").setup({})
local lspconfig = require('lspconfig')

require('lint').linters_by_ft = {
	python = {'flake8'},
}

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
		{ name = "nvim_lsp"},
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
		  mode = "symbol",

		  max_width = 50,
		  symbol_map = { Copilot = "" }
		})
	},
	mapping = {
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({cmp_select})
			else
				fallback()
			end
		end, {"i", "s"}),
		['<CR>'] = cmp.mapping({
			i = function (fallback)
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
	ensure_installed = {
		-- lua
		"lua_ls",
		-- web dev
		"cssls",
		"html",
		"tsserver",
		"volar",
		--python
		"pyright",
		-- C++
		"clangd",
		-- Docker
		"dockerls",
		-- Rust
		"rust_analyzer"
	},
})

local lsp_defaults = {
	capabilities = require('cmp_nvim_lsp').default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
	end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
	"force",
	lspconfig.util.default_config,
	lsp_defaults
)

local sign = function (opts)
	vim.fn.sign_define(opts.name, {
		texth1 = opts.name,
		text = opts.text,
		numhl = '',
	})
end
sign({name = 'DiagnosticSignError', text = ""})
sign({name = 'DiagnosticSignWarn', text = ""})
sign({name = 'DiagnosticSignHint', text = ""})
sign({name = 'DiagnosticSignInfo', text = ""})

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})
vim.api.nvim_create_autocmd('User', {
	pattern = 'LspAttached',
	group = group,
	callback = function()
		local bufmap = function(mode, lhs, rhs, desc)
			local opts = {buffer = true, remap = false, desc = desc}
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		bufmap("n", "gd", function() vim.lsp.buf.definition() end, "LSP [g]et [d]efinition")
		bufmap("n", "H", function() vim.lsp.buf.hover() end, "LSP [H]over")
		bufmap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, "[v]iew [w]orkspace [s]ymbol")
		bufmap("n", "<leader>vd", function() vim.diagnostic.open_float() end, "[v]iew [d]iagnostic")
		bufmap("n", "[d", function() vim.diagnostic.goto_next() end, "Next [d]iagnostic")
		bufmap("n", "]d", function() vim.diagnostic.goto_prev() end, "Prev [d]iagnostic")
		bufmap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, "[v]iew [c]ode [a]ction")
		bufmap("n", "<leader>vrr", function() vim.lsp.buf.references() end, "[v]iew code [r]eferences")
		bufmap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, "[r]e[n]ame")
		bufmap("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, "LSP [f]or[m]at")
		bufmap("i", "<leader>hs", function() vim.lsp.buf.signature_help() end, "[h]elp [s]ignature")
	end
})

local default_handler = function(server)
	local server_config = {}
	if require('neoconf').get(server .. ".disable") then
		return
	end
	if server == "volar" then
		server_config.filetypes = { 'vue', 'typescript', 'javascript' }
	end
	if server == 'lua_ls' then
		server_config.on_init = function (client)
			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
					}
				}
			})
		end
		server_config.settings.Lua = {}
	end
	lspconfig[server].setup(server_config)
end

require('mason-lspconfig').setup_handlers({
	default_handler,
	['tsserver'] = function()
		lspconfig.tsserver.setup({
			settings = {
				completions = {
					completeFunctionCalls = true
				}
			}
		})
	end
})
