return {
  {
    "Wansmer/treesj",
    keys = {
      "<space>m", -- toggle split/join
      "<space>j", -- join
      "<space>s", -- split
    },
    dependencies = {
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
            "rust",
            "java",
            "groovy",
          }
          vim.api.nvim_create_autocmd("FileType", {
            pattern = need_hl,
            callback = function()
              vim.treesitter.start()
            end,
          })
        end,
      },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      -- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#242424" })
    end,
  },
}
