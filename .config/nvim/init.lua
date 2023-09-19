require("keymaps")

-- lazy.nvim boilerplate
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- And install plugins
require("lazy").setup({ import = "plugins" })

-- Set line numbering and relative numbering as default
vim.wo.number = true
vim.wo.relativenumber = true

-- Sync vim clipboard w/ system
vim.o.clipboard = 'unnamedplus'
