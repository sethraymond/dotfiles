local lsp = require('lsp-zero').preset({})

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		-- lua
		"lua_ls",
		-- web dev
		"angularls",
		"cssls",
		"html",
		"tsserver",
		--python
		"pyright",
		"pylsp",
		-- C++
		"clangd",
		-- Docker
		"dockerls",
	},
	handlers = {
		lsp.default_setup,
	},
})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

local function tab_merge(t1, t2)
	for i = 1, #t2 do
		t1[#t1+1] = t2[i]
	end
	return t1
end

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, tab_merge(opts, { desc = "LSP [g]et [d]efinition" }))
	vim.keymap.set("n", "H", function() vim.lsp.buf.hover() end, tab_merge(opts, { desc = "LSP [H]over" }))
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, tab_merge(opts, { desc = "[v]iew [w]orkspace [s]ymbol" }))
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, tab_merge(opts, { desc = "[v]iew [d]iagnostic" }))
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, tab_merge(opts, { desc = "Next [d]iagnostic" }))
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, tab_merge(opts, { desc = "Prev [d]iagnostic" }))
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, tab_merge(opts, { desc = "[v]iew [c]ode [a]ction" }))
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, tab_merge(opts, { desc = "[v]iew code [r]eferences" }))
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, tab_merge(opts, { desc = "[r]e[n]ame" }))
	vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, tab_merge(opts, { desc = "LSP [f]or[m]at" }))
	vim.keymap.set("i", "<leader>hs", function() vim.lsp.buf.signature_help() end, tab_merge(opts, { desc = "[h]elp [s]ignature" }))
end)

lsp.setup()
