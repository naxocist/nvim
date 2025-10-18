return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      -- Smooth update to avoid flicker
      debounce = 100,

      -- Indent guide character
      indent = {
        tab_char = "▏",
        char = "|",
      },

      -- Highlight for whitespace at line ends and empty lines
      whitespace = {
        highlight = { "Whitespace", "NonText" },
      },

      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
    }
  },

  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({
        transparent = true,
        italic = false
      })
      -- vim.cmd("colorscheme vague")

      -- Active statusline (current window)
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#000000" })
      -- Inactive statusline (other windows)
      vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#888888", bg = "#000000" })
    end
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        styles = {
          transparency = true,
          italic = false,
        }
      }

      vim.cmd("colorscheme rose-pine")

      -- ## THEME LIKE GVIM default ##
      -- vim.cmd "color morning"
      -- -- Helper to preserve foreground color
      -- local function set_bg_white(group)
      --   local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
      --   if ok and hl.fg then
      --     vim.api.nvim_set_hl(0, group, { fg = hl.fg, bg = "#FFFFFF" })
      --   end
      -- end
      --
      -- -- List of highlight groups to patch
      -- local groups = {
      --   "Normal", "NormalNC", "String", "Comment", "Keyword", "Function",
      --   "Identifier", "Type", "Constant", "Statement", "PreProc",
      --   "Special", "Todo", "Number", "LineNr", "SignColumn"
      -- }
      --
      -- -- Set them all
      -- for _, group in ipairs(groups) do
      --   set_bg_white(group)
      -- end
    end
  },
}
