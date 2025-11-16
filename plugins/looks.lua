vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/RRethy/base16-nvim" },
  { src = "https://github.com/maxmx03/dracula.nvim" }
})

require("vague").setup({ italic = false, bold = false, transparent = true })
require("rose-pine").setup({
  styles = {
    bold = false,
    italic = false,
    transparency = true,
  },
})
local dracula = require "dracula"
dracula.setup {
  transparent = true
}
vim.cmd("color dracula")

---- Remove italics from all highlight groups
for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
  local hl = vim.api.nvim_get_hl(0, { name = group })
  if hl.italic then
    hl.italic = nil
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_set_hl(0, group, hl)
  end
end

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
