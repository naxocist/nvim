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

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		vim.keymap.set("i", "<C-s>", "<esc>", { buffer = args.data.buf_id })
		vim.keymap.set("n", "<M-h>", "<left>",  { buffer = args.data.buf_id })
		vim.keymap.set("n", "<M-l>", "<right>", { buffer = args.data.buf_id })
		vim.keymap.set("n", "<leader>e", function() MiniFiles.close() end, { buffer = args.data.buf_id })
		vim.keymap.set("n", "<CR>", function() MiniFiles.go_in({ close_on_file = true }) end, { buffer = args.data.buf_id })
	end,
})

-- KEYMAPS
local map = function(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
map("n", "<C-p>", "<cmd>lua MiniPick.builtin.files()<cr>")
map("n", "<C-g>", "<cmd>lua MiniPick.builtin.grep_live()<cr>")
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
map("n", "<leader>gs", "<cmd>lua MiniGit.show_at_cursor()<cr>")
map("n", "<leader>gg", function()
	vim.cmd("botright 60split | terminal lazygit")
	vim.cmd("startinsert")
end)
map("n", "<leader>gd", "<cmd>lua MiniDiff.toggle_overlay()<cr>")
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
	change_detection = { enabled = true, notify = true },
})
