return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          go = { "goimports-reviser" },
          default_format_opts = {
            lsp_format = "fallback",
          },
        },

        notify_no_formatters = true,

        formatters = {
          ["goimports-reviser"] = {
            prepend_args = { "-rm-unused" },
          },
        },
      })

      local conform = require("conform")
      vim.keymap.set("n", "<leader>f", conform.format)
    end,
  },
}
