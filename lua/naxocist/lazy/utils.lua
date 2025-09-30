return {

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zK', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)

      require("ufo").setup {
        provider_selector = function()
          return { "lsp", "indent" }
        end
      }
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>"),
    vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>"),
    vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>"),
    vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>"),
  },

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        -- Defaults
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn"t work well in a specific filetype
      -- per_filetype = {
      --   ["html"] = {
      --     enable_close = false
      --   }
      -- }
    }
  },

  { 'nvim-mini/mini.icons',   version = false, opts = {} },
  { 'echasnovski/mini.pairs', version = '*',   opts = {} },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  }
}
