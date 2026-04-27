local dap, dapui = require("dap"), require("dapui")

-- Session-local defaults (persist while Neovim is open)
local defaults = {
	sysroot = "",
	gdb = "gdb-multiarch",
	prog = "",
	gdbport = "localhost:2345",
}

local function ui_prompt(key, opts)
	return function()
		local co = coroutine.running()
		vim.ui.input({
			prompt = opts.prompt,
			default = defaults[key] or "",
		}, function(input)
			input = input and vim.trim(input) or ""
			if input ~= "" then
				defaults[key] = input
			end
			coroutine.resume(co, defaults[key])
		end)
		return coroutine.yield()
	end
end

local function setup_commands()
	-- NOTE: if you want sysroot to *always* prompt, make it a function too.
	local sysroot = ui_prompt("sysroot", { prompt = "Target sysroot path: " })
	local solib = table.concat({ sysroot .. "/lib", sysroot .. "/usr/lib" }, ":")
	return {
		{ text = "set sysroot " .. sysroot },
		{ text = "set solib-search-path " .. solib },
	}
end

require("neotest").setup({
	adapters = {
		require("neotest-python")({}),
	},
})

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
	{
		name = "Remote (launch) – prompted",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		program = ui_prompt("prog", { prompt = "Program (with symbols): " }),
		cwd = "${workspaceFolder}",
		miDebuggerPath = ui_prompt("gdb", { prompt = "GDB path: " }),
		miDebuggerServerAddress = ui_prompt("gdbport", { prompt = "gdbserver addr (host:port): " }),
		setupCommands = setup_commands,
	},

	{
		name = "Remote (attach PID) – prompted",
		type = "cppdbg",
		request = "attach",
		MIMode = "gdb",

		-- cpptools uses different fields depending on mode; this is the common MI attach style:
		program = ui_prompt("prog", { prompt = "Local program (symbols) path: " }),
		processId = ui_prompt("pid", { prompt = "PID on target: " }),

		miDebuggerPath = ui_prompt("gdb", { prompt = "GDB path: " }),
		miDebuggerServerAddress = ui_prompt("gdbport", { prompt = "gdbserver addr (host:port): " }),
		setupCommands = setup_commands,
	},
}

dap.configurations.c = dap.configurations.cpp

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
vim.keymap.set(
	"n",
	"<leader>tdb",
	":lua require('neotest').run.run({vim.fn.expand('%'), strategy='dap'})<CR>",
	{ desc = "[t]est [d]e[b]ug" }
)
vim.keymap.set("n", "<leader>tst", ":lua require('neotest').run.stop()<CR>", { desc = "[t]est [s][t]op" })
