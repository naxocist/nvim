-- vim.opt.clipboard = "unnamedplus" -- use system clipboard

vim.opt.cursorline = true
vim.opt.updatetime = 500

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true

-- set tab size to 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.ignorecase = true
vim.opt.wrap = false
vim.opt.incsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.modeline = false
vim.opt.conceallevel = 2

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.termguicolors = true


vim.opt.list = true -- show invisible characters
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  nbsp = "␣",
}

vim.opt.swapfile = false
vim.opt.winborder = "single"


-- Set up diagnostics
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false
})
