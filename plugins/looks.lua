vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/RRethy/base16-nvim" },
  { src = "https://github.com/maxmx03/dracula.nvim" },

  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("vague").setup({ italic = false, bold = false, transparent = false })
require("rose-pine").setup({
  styles = {
    bold = false,
    italic = false,
    transparency = false,
  },
})
require("dracula").setup({
  transparent = true,
})
vim.cmd("color vague")

-- vim.o.guicursor = "i:ver30-MyInsertCursor"
-- vim.api.nvim_set_hl(0, "MyInsertCursor", { fg = "#000000", bg = "#FF0000" })

vim.opt.showmode = false
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "auto",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""}
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "lsp_status" },
    lualine_y = { "fileformat" },
    lualine_z = { "encoding" },
  },
})
