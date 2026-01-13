return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = {
          italic = false,
          transparency = true,
        },
        highlight_groups = {
          GitSignsAdd = { fg = "#b7ffa1", bg = "none" },
          GitSignsChange = { fg = "#f3ff85", bg = "none" },
          GitSignsDelete = { fg = "#ff6b6b", bg = "none" },

          SignColumn = { bg = "none" },
        },
      })
      vim.cmd("colorscheme rose-pine-moon")
    end,
  },
  {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({
        bold = true,
        italic = false,
        transparent = true,
      })
      -- vim.cmd("colorscheme vague")
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = { { fg = "#57ffff" } },
          chars = {
            left_top = "┌",
            left_bottom = "└",
          },
          delay = 100,
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 4,
            file_status = true,
          },
        },
        lualine_x = { "lsp_status" },
        lualine_y = { "fileformat" },
        lualine_z = { "filetype", "encoding" },
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
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
          hover = {
            opts = { border = "single" },
          },
          signature = {
            opts = { border = "single" },
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
}
