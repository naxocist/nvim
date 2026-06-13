---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        variableTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        variableTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
      },
    },
  },
}
