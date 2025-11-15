vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/tiesen243/vercel.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("vague").setup({ italic = false, bold = false, transparent = true })
require("vercel").setup({
  theme = "dark",
  transparent = true,
  italics = {
    comments = true,
    keywords = false,
    functions = false,
    strings = false,
    variables = false,
    bufferline = false,
  },
})
vim.cmd("color vague")

-- vim.o.guicursor = "i:ver30-MyInsertCursor"
-- vim.api.nvim_set_hl(0, "MyInsertCursor", { fg = "#000000", bg = "#FF0000" })

vim.opt.showmode = false
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
    lualine_c = { "filename" },
    lualine_x = { "lsp_status" },
    lualine_y = { "fileformat" },
    lualine_z = { "encoding" },
  },
})
