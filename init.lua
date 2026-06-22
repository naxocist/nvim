-- CONSTANT
local diag_current_line = false

-- OPTIONS
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = "single"
vim.opt.list = true
vim.opt.listchars = { tab = "▏ ", trail = "·", extends = ">", precedes = "<" }

-- KEYMAPS
local map = function(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><esc>")
map("n", "<leader>q", "<cmd>q<cr>")
map({ "n", "i" }, "<esc>", "<esc><cmd>nohl<cr>")
map("n", "<M-s>", "<cmd>resize -5<cr>")
map("n", "<M-t>", "<cmd>resize +5<cr>")
map("n", "<M-,>", "<cmd>vertical resize -5<cr>")
map("n", "<M-.>", "<cmd>vertical resize +5<cr>")
map({ "n", "i" }, "<C-a>", "<esc>ggVG")
map("n", "<leader>gg", function()
  vim.cmd("botright 60split | terminal lazygit")
  vim.cmd("startinsert")
end)
map("n", "<leader>td", function()
  diag_current_line = not diag_current_line
  vim.diagnostic.config({ virtual_text = diag_current_line })
end)

-- DIAGNOSTICS
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = true,
  underline = true,
  severity_sort = true,
})

-- AUTOCMDS
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR><C-w>p", { buffer = true, silent = true })
  end,
})

-- highlight on yank
vim.api.nvim_set_hl(0, "YankFlash", { bg = "#f6c177", fg = "#111111" })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "YankFlash", timeout = 150 })
  end,
})

-- LAZY.NVIM BOOTSTRAP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = { enabled = true, notify = false },
})
