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

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")


vim.keymap.set({ "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save in [x,n,s] mode" })
vim.keymap.set("i", "<C-s>", function()
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


local function toggle(opt)
  ---@diagnostic disable-next-line: assign-type-mismatch
  vim.wo[opt] = not vim.wo[opt]
  print(opt .. ":", vim.wo[opt])
end

vim.keymap.set("n", "<leader>ww", function() toggle "wrap" end)
vim.keymap.set("n", "<leader>nn", function() toggle "relativenumber" end)
vim.keymap.set("n", "q", "<cmd>q<cr>")
