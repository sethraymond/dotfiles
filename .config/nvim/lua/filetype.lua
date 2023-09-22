vim.filetype.add({
  filename = {
    [".flake8"] = "config",
  },
  pattern = {
    ["req.*.txt"] = "config",
  }
})
