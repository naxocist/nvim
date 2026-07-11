return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      local map = function(m, k, v)
        vim.keymap.set(m, k, v, { silent = true })
      end

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
      map("n", "<C-p>", function()
        MiniPick.builtin.files()
      end)
      map("n", "<C-g>", function()
        MiniPick.builtin.grep_live()
      end)

      require("mini.files").setup({})
      require("minifiles_git")
      map("n", "<leader>e", MiniFiles.open)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf = args.data.buf_id
          vim.keymap.set("i", "<C-l>", "<Right>", { buffer = buf })
          vim.keymap.set("i", "<C-h>", "<Left>", { buffer = buf })
          vim.keymap.set("i", "<C-s>", "<Esc>", { buffer = buf })
        end,
      })

      require("mini.pairs").setup()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "-" },
        },
      })

    end,
  },
}
