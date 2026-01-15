return {
  {
    "Wansmer/treesj",
    keys = {
      "<leader>m", -- toggle split/join
      "<leader>j", -- join
      "<leader>s", -- split
    },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true, build = ":TSUpdate", branch = "main" },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#242424" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
        },
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      vim.keymap.set({ "x", "o" }, "af", function()
        select("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        select("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        select("@class.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "as", function()
        select("@local.scope", "locals")
      end)
    end,
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "cpp",
        "c",
        "html",
        "css",
        "javascript",
        "typescript",
        "python",
        "go",
      },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss",
          node_incremental = "<leader>si",
          node_decremental = "<leader>sd",
        },
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
