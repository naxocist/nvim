return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.icons").setup()
      require("mini.snippets").setup({
        snippets = { require("mini.snippets").gen_loader.from_lang() },
      })

      require("mini.pick").setup({
        mappings = {
          move_down = "<C-j>",
          move_up = "<C-k>",
          scroll_down = "<C-d>",
          scroll_left = "<C-h>",
          scroll_right = "<C-l>",
          scroll_up = "<C-u>",
        },
      })

      require("mini.pairs").setup()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "-" },
        },
      })

      local map = function(m, k, v)
        vim.keymap.set(m, k, v, { silent = true })
      end
      map("n", "<C-p>", function()
        MiniPick.builtin.files()
      end)
      map("n", "<C-g>", function()
        MiniPick.builtin.grep_live()
      end)
    end,
  },
}
