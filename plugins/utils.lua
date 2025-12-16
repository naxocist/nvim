local keymap = vim.keymap.set

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

  { src = "https://github.com/tpope/vim-dadbod" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
})

require("git-conflict").setup()

keymap("n", "<leader>db", "<cmd>DBUI<cr>")
vim.g.db_ui_use_nerd_fonts = 1

keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr><C-w>h")
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
      confirm_simple = true
    },
  },
})
keymap("n", "<leader>e", function()
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

keymap("n", "<leader>co", fzf_lua.colorschemes)
keymap("n", "<C-f>", fzf_lua.global)
keymap("n", "<C-p>", fzf_lua.files)
keymap("n", "<C-g>", fzf_lua.live_grep)

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
keymap("n", "zR", require("ufo").openAllFolds)
keymap("n", "zM", require("ufo").closeAllFolds)
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
