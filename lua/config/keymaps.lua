-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- do not copy single character deletion
map("n", "x", '"_x')

-- Increment / Decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- delete a word
map("i", "<C-h>", "<C-w>")

-- undo / redo
map("n", "<C-z>", "u", opts)
map("n", "<C-y>", "<C-r>", opts)
map("i", "<C-z>", "<C-o>u", opts)
map("i", "<C-y>", "<C-o><C-r>", opts)

-- Tabs
map("n", "te", ":tabedit")

-- Split window
map("n", "sh", ":split<cr>", opts)
map("n", "sv", ":vsplit<cr>", opts)

-- Resize window
map("n", "<A-w>", "<C-w>>")
map("n", "<A-S-w>", "<C-w><")
map("n", "<A-h>", "<C-w>+")
map("n", "<A-S-h>", "<C-w>-")

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "<<")
map("n", ">", ">>")

-- Save
map({ "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")
map("i", "<C-s>", function()
  local buftype = vim.bo.buftype

  if buftype ~= "" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", false)
    vim.schedule(function()
      vim.notify("Cannot save. buftype is set to: " .. buftype, vim.log.levels.WARN)
    end)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cmd>w<cr><esc>", true, false, true), "n", false)
  end
end)
