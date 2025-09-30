return {

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      -- Smooth update to avoid flicker
      debounce = 100,

      -- Indent guide character
      indent = {
        char = "▏",
        tab_char = "|",
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
    "projekt0n/github-nvim-theme",
    name = "github-theme",

    config = function()
      require("github-theme").setup({
        options = {
          transparent = false
        }
      })
      vim.cmd "color github_dark_default"
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    }
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        styles = {
          transparency = false,
          italic = false,
        }
      }

      -- vim.cmd "color rose-pine"

      -- Set background to black for everything
      local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "MsgArea",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
        "TelescopeResultsNormal",
        "TelescopeResultsBorder",
        "TelescopePreviewNormal",
        "TelescopePreviewBorder",
        "Pmenu",
        "FloatBorder",
        "StatusLine",
        "StatusLineNC",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "WinSeparator",
      }

      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "#000000" })
      end

      -- blink.cmp highlight overrides
      vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "black", fg = "white" })
      vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "black", fg = "white" })

      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "black", fg = "white" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuSel", { bg = "#333333", fg = "white" })

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
