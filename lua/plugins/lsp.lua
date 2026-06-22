return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup(opts)

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              diagnosticMode = "openFilesOnly",
              indexing = false,
            },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local m = function(k, v)
            vim.keymap.set("n", k, v, { buffer = ev.buf, silent = true })
          end
          m("gd", vim.lsp.buf.definition)
          m("gr", vim.lsp.buf.references)
          m("K", vim.lsp.buf.hover)
          m("<leader>rn", vim.lsp.buf.rename)
          m("<leader>ca", vim.lsp.buf.code_action)
          m("<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end)
          m("[d", function()
            vim.diagnostic.jump({ count = -1 })
          end)
          m("]d", function()
            vim.diagnostic.jump({ count = 1 })
          end)
          m("<leader>d", vim.diagnostic.open_float)
        end,
      })
    end,
  },
}
