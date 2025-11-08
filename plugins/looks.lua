vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/tiesen243/vercel.nvim" },
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
vim.cmd("color vercel")

vim.o.guicursor = "i:block-MyInsertCursor"
vim.api.nvim_set_hl(0, "MyInsertCursor", { fg = "#000000", bg = "#FF0000" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000", fg = "#888888" })
