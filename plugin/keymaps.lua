vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<ESC>", ":noh<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "i" }, "<C-s>", "<ESC>:w<CR>")
vim.keymap.set({ "n", "i" }, "<C-a>", "<ESC>gg<S-v>G")
vim.keymap.set("v", "sy", '"+y')
vim.keymap.set("n", "<leader>wai", "<CMD>echo expand('%:p')<CR>") -- where am i?

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move down, but use 'gj' if no count is given
vim.keymap.set({ "n", "v" }, "j", function()
  return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true })
-- Move up, but use 'gk' if no count is given
vim.keymap.set({ "n", "v" }, "k", function()
  return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true })

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")
