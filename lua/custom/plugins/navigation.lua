return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup({
        winopts = {
          border = "single",
          preview = {
            border = "single",
          },
        },
      })

      vim.keymap.set("n", "<leader>co", fzf_lua.colorschemes)
      vim.keymap.set("n", "<C-f>", fzf_lua.global)
      vim.keymap.set("n", "<C-p>", fzf_lua.files)
      vim.keymap.set("n", "<C-g>", fzf_lua.live_grep)
    end,
  },

  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      local fyler = require("fyler")
      fyler.setup({
        integrations = {
          icon = "nvim_web_devicons",
        },
        views = {
          finder = {
            default_explorer = true,
            confirm_simple = true,
            win = {
              win_opts = {
                number = true,
                relativenumber = true,
              },
            },
          },
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        fyler.toggle({ kind = "float" })
      end)
    end,
  },
}
