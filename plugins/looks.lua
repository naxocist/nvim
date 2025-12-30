vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/rose-pine/neovim" },

  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("vague").setup({ italic = false, bold = false, transparent = true })
require("rose-pine").setup({ styles = { bold = false, italic = false, transparency = true } })

vim.cmd("color vague")
vim.o.showmode = false

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { {
      "filename",
      path = 1,
      file_status = true,
    } },
    lualine_x = { "lsp_status" },
    lualine_y = { "filetype", "encoding" },
    lualine_z = { "fileformat" },
  },
})
