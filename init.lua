vim.g.mapleader = " "
vim.g.localleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.winborder = "single"
vim.o.scrolloff = 10

vim.o.wrap = false
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.inccommand = "nosplit"
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

-- KEYMAPS
local keymap = vim.keymap.set

-- Move down, but use 'gj' if no count is given
keymap("n", "j", function()
  return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true })
-- Move up, but use 'gk' if no count is given
keymap("n", "k", function()
  return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true })

keymap("n", "<leader>pu", vim.pack.update)
keymap("n", "<leader>f", vim.lsp.buf.format)

keymap("n", "<esc>", ":noh<CR>")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<leader>o", ":update<CR>:source<CR>")
keymap("n", "<leader>O", ":restart<CR>")
keymap("n", "<leader>q", ":quit<CR>")
keymap({ "n", "i" }, "<C-s>", "<ESC>:write<CR>")
keymap({ "n", "i" }, "<C-a>", "<ESC>gg<S-v>G")
keymap("v", "sy", '"+y')
keymap("v", "sp", '"+y')

package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/custom/?.lua"
require("cp")

package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/plugins/?.lua"
require("lsp")
require("utils")
require("looks")

-- AUTOCMD
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 170 })
  end,
  group = highlight_group,
})
-- custom colorcolumn
local ft_colorcolumns = {
  python = "79",
  markdown = "100",
  lua = "120",
  c = "80",
  cpp = "80",
  javascript = "100",
  typescript = "100",
  html = "120",
  default = "80", -- fallback
}

-- set colorclumn based on ft
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    if ft == "Fyler" then
      return
    end
    local col = ft_colorcolumns[ft] or ft_colorcolumns.default
    vim.opt_local.colorcolumn = col
  end,
})
