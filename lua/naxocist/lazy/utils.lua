return {
  -- file tree
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require('mini.files').setup()
      vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
    end
  },

  -- Auto close parentheses and repeat by dot dot dot...
  { "cohama/lexima.vim" },

  -- Indentation guides
  { "echasnovski/mini.indentscope", version = "*",
    opts = {}
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

}
