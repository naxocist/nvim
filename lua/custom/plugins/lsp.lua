return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({})
      vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
