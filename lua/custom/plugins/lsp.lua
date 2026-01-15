return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>sf", vim.lsp.buf.document_symbol, opts)
          vim.keymap.set("n", "<leader>wf", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        end,
      })

      -- Disable remote provider detection
      vim.g.loaded_python3_provider = 0
      vim.g.loaded_ruby_provider = 0
      vim.g.loaded_perl_provider = 0
      vim.g.loaded_node_provider = 0
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
