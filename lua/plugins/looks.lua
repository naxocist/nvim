return {
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function() vim.cmd.colorscheme "catppuccin" end },

  -- {
  --   "ofirgall/ofirkai.nvim",
  --   -- already ran vim.cmd.colorscheme
  --   opts = {
  --     -- theme = "dark_blue",
  --     remove_italics = true
  --   },
  -- },

  {
    "vague2k/vague.nvim",
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup {
        italic = false
      }

      vim.cmd "color vague"
    end
  },

  {
    "andweeb/presence.nvim",
    opts = {
      neovim_image_text = "go checkout love live!",
      editing_text        = "Yapping in ****",
      file_explorer_text  = "Searching in a void",
    }
  }
}
