-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Sync with system clipboard
opt.clipboard = "unnamedplus" 
vim.g.clipboard = {
   name = 'WslClipboard',
   copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
   paste = {
      ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
   },
   cache_enabled = 0,
}

opt.completeopt = "menu,menuone,noselect"
opt.cursorline = false -- Enable highlighting of the current line
opt.scrolloff = 10 -- Lines of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.relativenumber = true -- Relative line numbers

opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.termguicolors = true -- True color support

opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.list = true -- Show some invisible characters (tabs...
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows below current

