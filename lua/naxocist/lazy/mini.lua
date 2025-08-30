return {
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require('mini.files').setup()
      vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
    end
  },

  -- Indentation guides
  {
    "echasnovski/mini.indentscope",
    version = "*",
    opts = {

    }
  },

  {
    'echasnovski/mini.pairs',
    version = '*',
    opts = {}
  }
}
