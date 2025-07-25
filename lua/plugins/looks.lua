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
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        styles = {
          italic = false
        }
      }
      -- vim.cmd "color rose-pine"
      vim.cmd "color sorbet"
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
