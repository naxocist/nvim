return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local need_hl = {
        "go",
        "cpp",
        "c",
        "bash",
        "javascript",
        "typescript",
        "python",
        "matlab",
        "typst",
        "make",
        "asm",
        "svelte",
        "tmux",
        "yaml",
        "html",
        "css",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = need_hl,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#20232b" })
    end,
  },
}
