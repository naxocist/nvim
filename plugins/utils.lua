vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.icons" },

  { src = "https://github.com/A7Lavinraj/fyler.nvim" },

  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/ibhagwan/fzf-lua" },

  { src = "https://github.com/kevinhwang91/promise-async" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },

  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/akinsho/git-conflict.nvim" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },

  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

  { src = "https://github.com/tpope/vim-dadbod" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2a2e37" })

local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

require("git-conflict").setup()

vim.keymap.set("n", "<leader>db", "<cmd>DBUI<cr>")
vim.g.db_ui_use_nerd_fonts = 1

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr><C-w>h")
require("nvim-ts-autotag").setup()
require("mini.pairs").setup()

local fyler = require("fyler")
fyler.setup({
  integrations = {
    icon = "nvim_web_devicons",
  },
  views = {
    finder = {
      default_explorer = true,
      confirm_simple = true,
    },
  },
})
vim.keymap.set("n", "<leader>e", function()
  fyler.toggle({ kind = "float" })
end)

local fzf_lua = require("fzf-lua")
fzf_lua.setup({
  winopts = {
    border = "single",
    preview = {
      border = "single",
    },
  },
})

vim.keymap.set("n", "<leader>co", fzf_lua.colorschemes)
vim.keymap.set("n", "<C-f>", fzf_lua.global)
vim.keymap.set("n", "<C-p>", fzf_lua.files)
vim.keymap.set("n", "<C-g>", fzf_lua.live_grep)

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
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
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

require("ufo").setup({
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
})
