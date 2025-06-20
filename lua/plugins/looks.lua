return {
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function() vim.cmd.colorscheme "catppuccin" end },

  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
      on_highlights = function(hl, c)
        local prompt = "#292e42"
        hl.FloatBorder = { fg = prompt }
        hl.TelescopeNormal = { fg = c.fg_dark }
        hl.TelescopeBorder = { fg = prompt }
        hl.TelescopePromptBorder = { fg = prompt }
        hl.TelescopeResultsBorder = { fg = prompt }
        hl.TelescopePromptTitle = { fg = c.fg_dark }
        hl.TelescopeResultsTitle = { fg = c.fg_dark }
      end,
    },
    config = function() vim.cmd.colorscheme "unokai" end
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
