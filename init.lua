vim.g.mapleader = " "

package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/custom/?.lua"
require("cp")

-- # OPTIONS

vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.scrolloff = 8
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

vim.g.netrw_liststyle = 1 -- Use the long listing view
vim.g.netrw_sort_by = "name"

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = false
})

-- # KEYMAPS

local keymap = vim.keymap.set

-- Move down, but use 'gj' if no count is given
keymap("n", "j", function() return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj" end,
  { expr = true, silent = true })
-- Move up, but use 'gk' if no count is given
keymap("n", "k", function() return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk" end,
  { expr = true, silent = true })

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

-- # CODE PROCESSING

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/saghen/blink.cmp",               version = vim.version.range("^1") },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" }
})

require("nvim-treesitter.configs").setup { auto_install = true }

require("mason").setup()
require("mason-lspconfig").setup()
vim.diagnostic.config({ virtual_text = true })


require('blink.cmp').setup({
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
  keymap = {
    preset = "default",

    ["<C-space>"] = {},
    ["<C-p>"] = {},
    ["<Tab>"] = {},
    ["<S-Tab>"] = {},
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-n>"] = { "select_and_accept" },
    ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-b>"] = { "scroll_documentation_down", "fallback" },
    ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
    ["<C-e>"] = { "hide" },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "normal",
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    }
  },

  cmdline = {
    keymap = {
      preset = 'inherit',
      ['<CR>'] = { 'accept_and_enter', 'fallback' },
    },
  },

  sources = { default = { "lsp" } }
})
keymap("n", "<leader>od", vim.diagnostic.open_float)

-- # UTILS
vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/A7Lavinraj/fyler.nvim" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/kevinhwang91/promise-async" },
})


require('mini.pairs').setup()

require("fyler").setup({
  default_explorer = true,
  mappings = {
    ["q"] = "CloseView",
    ["<CR>"] = "Select",
    ["<C-t>"] = "SelectTab",
    ["|"] = "SelectVSplit",
    ["-"] = "SelectSplit",
    ["^"] = "GotoParent",
    ["="] = "GotoCwd",
    ["."] = "GotoNode",
    ["#"] = "CollapseAll",
    ["<BS>"] = "CollapseNode",
  },
})
keymap("n", "<leader>e", ":Fyler kind=float<CR>")

local fzf_lua = require("fzf-lua")
keymap("n", "<C-p>", fzf_lua.files)
keymap("n", "<C-g>", fzf_lua.live_grep)

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

require('ufo').setup({
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

-- # AUTOCMD

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ timeout = 170 })
  end,
  group = highlight_group,
})


-- # CUSTOM
vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
})
require("vague").setup { italic = false, bold = false, transparent = true }
vim.cmd("color vague")

vim.o.guicursor = "i:block-MyInsertCursor"
vim.api.nvim_set_hl(0, "MyNormalCursor", { fg = "#000000", bg = "#0000FF" })
vim.api.nvim_set_hl(0, "MyInsertCursor", { fg = "#000000", bg = "#FF0000" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000", fg = "#888888" })
