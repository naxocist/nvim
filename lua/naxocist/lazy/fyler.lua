return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  config = function()
    require("fyler").setup({
      default_explorer = true,
      -- Key mappings
      mappings = {
        ["q"] = "CloseView",
        ["<CR>"] = "Select",
        ["<C-t>"] = "SelectTab",
        ["|"] = "SelectVSplit",
        ["-"] = "SelectSplit",
        ["^"] = "GotoParent",
        ["="] = "GotoCwd",
        ["."] = "GotoNode",
        ["#"] = "CollapseAll",
        ["<BS>"] = "CollapseNode",
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Fyler kind=float<cr>", {})

    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        fyler_zoxide = {
          -- Extension configuration
        }
      }
    })

    telescope.load_extension("fyler_zoxide")
  end
}
