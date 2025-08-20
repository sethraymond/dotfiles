require("neotest").setup({
	adapters = {
		require("neotest-python")({
		})
	}
})

local dap, dapui = require("dap"), require("dapui")
dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/OpenDebugAD7'
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		setupCommands = {
			{
				text = '-enable-pretty-printing',
				description = 'enable pretty printing',
				ignoreFailures = false,
			},
		},
	},
}
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.keymap.set("n", "<leader>br", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle [b][r]eakpoint" })
vim.keymap.set("n", "<leader>dcc", ":lua require('dap').continue()<CR>", { desc = "[d]ebugger [c]ontinue" })
vim.keymap.set("n", "<leader>dsi", ":lua require('dap').step_into()<CR>", { desc = "[d]ebugger [s]tep [i]nto" })
vim.keymap.set("n", "<leader>dsv", ":lua require('dap').step_over()<CR>", { desc = "[d]ebugger [s]tep o[v]er" })
vim.keymap.set("n", "<leader>dso", ":lua require('dap').step_out()<CR>", { desc = "[d]ebugger [s]tep [o]ut" })
vim.keymap.set("n", "<leader>trn", ":lua require('neotest').run.run()<CR>", { desc = "[t]est [r]u[n]" })
vim.keymap.set("n", "<leader>tdb", ":lua require('neotest').run.run({vim.fn.expand('%'), strategy='dap'})<CR>", { desc = "[t]est [d]e[b]ug" })
vim.keymap.set("n", "<leader>tst", ":lua require('neotest').run.stop()<CR>", { desc = "[t]est [s][t]op" })
