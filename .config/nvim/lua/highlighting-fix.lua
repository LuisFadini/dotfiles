vim.filetype.add({
  extension = { rasi = "rasi" },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang"
  }
})
