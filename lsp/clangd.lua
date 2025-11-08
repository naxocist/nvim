---@type vim.lsp.Config
return {
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  cmd = {
    "clangd",
    "--header-insertion=never",
  },
}
