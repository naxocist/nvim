return {
  {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({
        bold = true,
        italic = false,
        transparent = false,
      })
      vim.cmd("colorscheme vague")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = false,
        theme = "tomorrow_night",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { {
          "filename",
          path = 4,
          file_status = true,
        } },
        lualine_x = { "lsp_status" },
        lualine_y = { "fileformat" },
        lualine_z = { "filetype", "encoding" },
      },
    },
  },
}
