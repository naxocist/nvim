return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup({
        render_modes = true,
        completions = { lsp = { enabled = true } },
      })
      vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<cr>")
      vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown preview<cr>")
    end,
  },
}
