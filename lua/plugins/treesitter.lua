return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua",
        "python",
        "javascript",
        "typescript",
        "bash",
        "json",
        "yaml",
        "c",
        "cpp",
        "go",
      })
    end,
  },
}
