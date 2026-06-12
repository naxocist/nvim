return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
      })
      -- vim.cmd("colorscheme rose-pine-moon")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      no_italic = true,
      integrations = {
        blink_cmp = true,
        noice = true,
        mason = true,
        lualine = true,
        treesitter = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
  {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 500,
    config = function()
      require("vague").setup({
        bold = false,
        italic = false,
        transparent = true,
      })
      -- vim.cmd("color vague")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "filename",
            path = 4,
            file_status = true,
          },
        },
        lualine_c = { "branch", "diff", "diagnostics" },
        lualine_x = {},
        lualine_y = { "lsp_status" },
        lualine_z = {},
      },
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        refresh = {
          statusline = 100,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        cmdline = { enabled = false },
        messages = { enabled = false },
        popupmenu = { enabled = false },

        lsp = {
          progress = {
            enabled = false,
          },
          hover = { opts = { border = "single" } },
          signature = {
            opts = { border = "single" },
            auto_open = { enabled = false },
          },
        },

        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = { { fg = "#ffffff" } },
          chars = {
            left_top = "┌",
            left_bottom = "└",
          },
          delay = 0,
        },
      })
    end,
  },
}
