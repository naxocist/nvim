return {
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    config = function()
      require("fyler").setup({
        default_explorer = true,
        mappings = {
          ["q"] = "CloseView",
          ["<CR>"] = "Select",
          ["<C-t>"] = "SelectTab",
          ["|"] = "SelectVSplit",
          -- ["-"] = "SelectSplit",
          ["-"] = "GotoParent",
          ["="] = "GotoCwd",
          ["."] = "GotoNode",
          ["#"] = "CollapseAll",
          ["<BS>"] = "CollapseNode",
        },
      })

      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          fyler_zoxide = {
          }
        }
      })
      telescope.load_extension("fyler_zoxide")

      vim.keymap.set("n", "<leader>e", "<cmd>Fyler kind=float<cr>")
    end
  }

  -- {
  -- 'stevearc/oil.nvim',
  -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- lazy = false,
  -- config = function()
  --   require("oil").setup {
  --     keymaps = {
  --       ["<C-p>"] = false,
  --       ["<C-s>"] = false,
  --       ["g?"] = { "actions.show_help", mode = "n" },
  --       ["pv"] = "actions.preview",
  --       ["q"] = { "actions.close", mode = "n" },
  --     },
  --
  --   }
  --
  --   vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  --   vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  -- end
  -- }
}
