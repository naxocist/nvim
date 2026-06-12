return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup({
        winopts = {
          border = "single",
          ---@diagnostic disable-next-line: missing-fields
          preview = {
            border = "single",
          },
        },
        keymap = {
          builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<M-w>"] = "toggle-preview-wrap", -- toggle wrap; when off, use <M-h>/<M-l> to scroll horizontally
          },
          fzf = {
            ["ctrl-u"] = "half-page-up",
            ["ctrl-d"] = "half-page-down",
          },
        },
      })

      vim.keymap.set("n", "<leader>co", fzf_lua.colorschemes)
      vim.keymap.set("n", "<C-f>", fzf_lua.global)
      vim.keymap.set("n", "<C-p>", fzf_lua.files)
      vim.keymap.set("n", "<C-g>", fzf_lua.live_grep)
    end,
  },

  -- {
  --   "A7Lavinraj/fyler.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   lazy = false,
  --   config = function()
  --     local fyler = require("fyler")
  --     fyler.setup({
  --       integrations = {
  --         icon = "nvim_web_devicons",
  --       },
  --       views = {
  --         ---@diagnostic disable-next-line: missing-fields
  --         finder = {
  --           default_explorer = true,
  --           confirm_simple = true,
  --           ---@diagnostic disable-next-line: missing-fields
  --           win = {
  --             win_opts = {
  --               number = true,
  --               relativenumber = true,
  --             },
  --           },
  --         },
  --       },
  --     })
  --
  --     vim.keymap.set("n", "<leader>e", function()
  --       fyler.toggle({ kind = "float" })
  --     end)
  --   end,
  -- },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        keymaps = {
          ["<C-s>"] = false,
          ["gd"] = { "actions.select", opts = { vertical = true } },
        },
        view_options = {
          show_hidden = true,
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        local oil = require("oil")
        if vim.bo.filetype == "oil" then
          oil.close()
        else
          oil.open()
        end
      end)
    end,
  },
}
