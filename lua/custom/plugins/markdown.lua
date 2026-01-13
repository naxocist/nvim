return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup()
      vim.keymap.set("n", "<leader>sm", "<cmd>RenderMarkdown toggle<cr>")
      vim.keymap.set("n", "<leader>pm", "<cmd>RenderMarkdown preview<cr>")
    end,
  },
  {
    "jghauser/follow-md-links.nvim",
    config = function()
      -- maps <cr> to hovered link by default
      -- <bs> to go back to previous buffer
      vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
    end,
  },
}
