vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.winborder = "single"
vim.o.scrolloff = 10

vim.o.wrap = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.inccommand = "split"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.conceallevel = 0
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.list = true
vim.o.listchars = "tab: ,trail:·,nbsp:+"

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = true,
})
