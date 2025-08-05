local api = require("nvim-tree.api")
vim.keymap.set("n", "<C-n>", api.tree.toggle)

local function on_attach(bufnr)
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set("n", "<C-n>", api.tree.toggle, opts("toggle"))
end

require("nvim-tree").setup({
	filters = {
		dotfiles = false,
		exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
		custom = { "^.git$"}
	},
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		adaptive_size = false,
		side = "right",
		width = 50,
		preserve_window_proportions = true,
		number = true,
		relativenumber = true,
	},
	git = {
		enable = true,
		ignore = false,
	},
	filesystem_watchers = {
		enable = false,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		root_folder_label = false,
		highlight_git = true,
		highlight_opened_files = "none",
		add_trailing = true,

		indent_markers = {
			enable = false,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},

			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "±",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "✗",
					ignored = "◌",
				},
			},
		},
	},
	on_attach = on_attach,
})
