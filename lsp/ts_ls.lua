---@type vim.lsp.Config
return {
  cmd = { "typescript-language-server", "--stdio" },
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
      format = {
        indentSize = vim.o.shiftwidth,
        convertTabsToSpaces = vim.o.expandtab,
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
    javascript = {
      format = {
        indentSize = vim.o.shiftwidth,
        convertTabsToSpaces = vim.o.expandtab,
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
  },
}
