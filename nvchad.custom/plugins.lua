-- local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "chentoast/marks.nvim",
    config = function ()
      require("marks").setup {
        builtin_marks = { ".", "<", ">", "^" },
      }
    end,
  },
  --{
  --  "gaborvecsei/memento.nvim",
  --  dependencies = { "nvim-lua/plenary.nvim" },
  --  lazy = false,
  --},
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}

return plugins
