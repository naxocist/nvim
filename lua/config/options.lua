-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- sync with system clipboard 
opt.clipboard = "unnamedplus" 

opt.completeopt = "menu,menuone,noselect"
opt.cursorline = false -- enable highlighting of the current line
opt.scrolloff = 10
opt.signcolumn = "yes" -- always show the signcolumn, otherwise it would shift the text each time
opt.number = true
opt.relativenumber = true

opt.expandtab = true -- use spaces instead of tabs
opt.tabstop = 2 -- number of spaces tabs count for
opt.shiftwidth = 2 -- size of an indent
opt.softtabstop = 2

-- Disable modelines (e.g., things like `# vim: ts=4 sw=4 et` in files)
opt.modeline = false

opt.termguicolors = true -- True color support

opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.list = true -- Show some invisible characters (tabs...
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows below current

opt.ignorecase = true -- make cmds & search case insensitive
opt.wrap = false

