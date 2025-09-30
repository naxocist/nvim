vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Select all
vim.keymap.set("n", "<C-a>", "<esc>ggVG")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

-- move line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- remove highlighting
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- do not copy single character deletion
vim.keymap.set("n", "x", '"_x')

-- Increment / Decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- undo / redo
vim.keymap.set("n", "<C-y>", "<C-r>")
vim.keymap.set("i", "<C-z>", "<C-o>u")
vim.keymap.set("i", "<C-y>", "<C-o><C-r>")


-- Split window
vim.keymap.set("n", "Sh", ":split<cr>")
vim.keymap.set("n", "Sv", ":vsplit<cr>")

-- Resize window
vim.keymap.set("n", "<A-,>", "<C-w>5>")
vim.keymap.set("n", "<A-.>", "<C-w>5<")
vim.keymap.set("n", "<A-t>", "<C-w>+")
vim.keymap.set("n", "<A-s>", "<C-w>-")

-- Navigate through panes
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

local function toggle(opt)
  ---@diagnostic disable-next-line: assign-type-mismatch
  vim.wo[opt] = not vim.wo[opt]
  print(opt .. ":", vim.wo[opt])
end

vim.keymap.set("n", "<leader>ww", function() toggle "wrap" end)
vim.keymap.set("n", "<leader>nn", function() toggle "relativenumber" end)

vim.keymap.set("n", "q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>k", "<cmd>bdelete<cr>")

-- view all marks
vim.keymap.set("n", "<leader>m", "<cmd>marks<cr>")

-- <C-s>: Save and (if needed) stop the native snippet session so highlights disappear
vim.keymap.set({ "n", "x", "i" }, "<C-s>", function()
  vim.cmd("silent! write")
  -- stop the active snippet session (blink.cmp uses Neovim's native snippets)
  if vim.snippet and vim.snippet.stop then
    pcall(vim.snippet.stop)
  end

  -- match the original "<Esc>" after save
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "Save file + clear snippet highlight" })
