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
		-- C++
		"clangd",
		-- Docker
		"dockerls",
		-- Rust
		"rust_analyzer"
	},
	handlers = {
		lsp.default_setup,
	},
})

require('lint').linters_by_ft = {
	python = {'flake8'},
}

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end
})

lsp.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.configure('pyright', { })


-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<Tab>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			local entry = cmp.get_selected_entry()
			if not entry then
				cmp.select_next_item({cmp_select})
			else
				cmp.confirm()
			end
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
lsp.set_sign_icons({
	error = "",
	warn = "",
	hint = "",
	info = "",
})

lsp.on_attach(function(_, bufnr)
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
