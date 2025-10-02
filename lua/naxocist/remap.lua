vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- system copy & paste
vim.keymap.set({ "n", "v", "x" }, "sy", '"+y<cr>')
vim.keymap.set({ "n", "v", "x" }, "sp", '"+p<cr>')
vim.keymap.set({ "n", "v", "x" }, "sd", '"+d<cr>')

-- Select all
vim.keymap.set("n", "<C-a>", "<esc>ggVG")

-- adjust to cursor to middle
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- format in func
vim.keymap.set("n", "=ap", "ma=ap'a")

-- move line in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- remove search highlight
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- Resize window
vim.keymap.set("n", "<A-w>", "<C-w>5>") -- wider
vim.keymap.set("n", "<A-n>", "<C-w>5<") -- narrower
vim.keymap.set("n", "<A-t>", "<C-w>+")  -- taller
vim.keymap.set("n", "<A-s>", "<C-w>-")  -- shorter

-- Navigate through panes
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>")

-- ez indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

local function toggle(opt)
  ---@diagnostic disable-next-line: assign-type-mismatch
  vim.wo[opt] = not vim.wo[opt]
  print(opt .. ":", vim.wo[opt])
end

-- toggle wrap / reltive num
vim.keymap.set("n", "<leader>ww", function() toggle "wrap" end)
vim.keymap.set("n", "<leader>nn", function() toggle "relativenumber" end)

vim.keymap.set("n", "q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>")

-- view all marks
vim.keymap.set("n", "<leader>m", "<cmd>marks<cr>")

-- do not copy single character deletion
vim.keymap.set("n", "x", '"_x')

-- Increment / Decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")


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
