---@type vim.lsp.Config
return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "Cargo.lock", ".git" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { allFeatures = true },
    },
  },
}
