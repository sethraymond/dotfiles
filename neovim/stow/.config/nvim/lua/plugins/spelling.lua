return {
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    config = function()
        vim.opt.rtp:append(vim.fn.stdpath('data') .. "/site")
        vim.opt.spelllang = { "en", "programming" }
    end,
}
