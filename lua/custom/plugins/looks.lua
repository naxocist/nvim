return {
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
      vim.cmd("color vague")
    end,
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
        lualine_y = { "" },
        lualine_z = { "encoding" },
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = { { fg = "#333333" } },
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
