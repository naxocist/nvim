local keymap = vim.keymap.set

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.pairs" },

  { src = "https://github.com/A7Lavinraj/fyler.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },

  { src = "https://github.com/kevinhwang91/promise-async" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },

  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/folke/flash.nvim" }
})

local flash = require("flash")
flash.setup()
keymap({"n", "x", "o"}, "s", function () flash.jump() end)
keymap({"n", "x", "o"}, "S", function () flash.treesitter() end)

require("mini.pairs").setup()

local fyler = require("fyler")
fyler.setup({
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
keymap("n", "<leader>e", function()
  fyler.toggle({ kind = "float" })
end)

local fzf_lua = require("fzf-lua")
keymap("n", "<leader>c", fzf_lua.colorschemes)
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
