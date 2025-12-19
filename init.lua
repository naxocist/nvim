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
keymap({"n", "v"}, "j", function()
  return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true })
-- Move up, but use 'gk' if no count is given
keymap({"n", "v"}, "k", function()
  return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true })

keymap("n", "<leader>pu", vim.pack.update)
keymap("n", "<leader>f", vim.lsp.buf.format)

keymap("n", "<esc>", ":noh<CR>")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap({ "n", "i" }, "<C-s>", "<ESC>:write<CR>")
keymap({ "n", "i" }, "<C-a>", "<ESC>gg<S-v>G")
keymap("v", "sy", '"+y')
keymap("n", "<leader>wai", "<CMD>echo expand('%:p')<CR>") -- where am i?

keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")

package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/custom/?.lua"
require("cp")

package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/plugins/?.lua"
require("looks")
require("lsp")
require("utils")

-- AUTOCMD
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

-- store cursor position in previous buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- verticle split help
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- auto resize when terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function()
    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlights when entering insert mode",
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- set colorclumn based on ft
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    if ft == "oil" or ft == "fyler" or ft == "dbout" or ft == "typst" then
      return
    end
    local col = "100"
    vim.opt_local.colorcolumn = col
  end,
})

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.open = function(path)
  -- Use wslview instead of xdg-open
  vim.fn.jobstart({ "wslview", path }, { detach = true })
end


-- for a, b in pairs(vim.pack.get()) do
--   print(b.spec.name)
--   -- vim.pack.del({b.spec.name})
-- end
