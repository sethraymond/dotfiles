---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<CR>"] = { "o<Esc>k", "Add new line below cursor", opts = { nowait = true }},
    ["<Leader>mm"] = { "<cmd>lua require('memento').toggle()<CR>", opts = {nowait = true }},
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "window up" },
  },
  i = {
    ["jk"] = { "<esc>", "Insert -> Normal", opts = { nowait = true }},
  },
  v = {
    ["<"] = { "<gv", "Indent and stay in visual mode", opts = { nowait = true }},
    [">"] = { ">gv", "Indent and stay in visual mode", opts = { nowait = true }},
  },
}

return M
