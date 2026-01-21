return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    config = function()
      require("typst-preview").setup({ dependencies_bin = { ["tinymist"] = "tinymist" } })
      vim.keymap.set("n", "<leader>t", ":TypstPreview<CR>")
    end,
  },
  { "windwp/nvim-ts-autotag", opts = {} },
  { "nvim-mini/mini.pairs", opts = {} },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
}
