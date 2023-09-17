require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
	  "bash",
	  "bitbake",
	  "c",
	  "cmake",
	  "cpp",
	  "dockerfile",
	  "doxygen",
	  "git_config",
	  "git_rebase",
	  "gitattributes",
	  "gitcommit",
          "gitignore",
	  "html",
	  "http",
	  "javascript",
	  "json",
	  "json5",
	  "jsonc",
	  "lua",
	  "make",
	  "markdown",
	  "markdown_inline",
	  "python",
	  "requirements",
	  "typescript",
	  "vim",
	  "vimdoc",
	  "query"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
