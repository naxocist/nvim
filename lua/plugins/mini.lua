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
        },
      })
      require("mini.files").setup()
      require("mini.surround").setup()
      require("mini.pairs").setup()
      require("mini.git").setup()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "-" },
        },
      })
      require("mini.base16").setup({
        palette = {
          base00 = "#111111",
          base01 = "#1a1a1a",
          base02 = "#222222",
          base03 = "#6e6a86",
          base04 = "#908caa",
          base05 = "#e0def4",
          base06 = "#e0def4",
          base07 = "#f7f3f3",
          base08 = "#eb6f92",
          base09 = "#f6c177",
          base0A = "#ea9a97",
          base0B = "#3e8fb0",
          base0C = "#9ccfd8",
          base0D = "#c4a7e7",
          base0E = "#f6c177",
          base0F = "#56526e",
        },
      })
      vim.api.nvim_set_hl(0, "MiniDiffSignAdd",       { fg = "#587c0c" })
      vim.api.nvim_set_hl(0, "MiniDiffSignChange",    { fg = "#0c7d9d" })
      vim.api.nvim_set_hl(0, "MiniDiffSignDelete",    { fg = "#94151b" })
      vim.api.nvim_set_hl(0, "MiniDiffOverAdd",       { bg = "#1e4620" })
      vim.api.nvim_set_hl(0, "MiniDiffOverChange",    { bg = "#3d3000" })
      vim.api.nvim_set_hl(0, "MiniDiffOverChangeBuf", { bg = "#3d3000" })
      vim.api.nvim_set_hl(0, "MiniDiffOverDelete",    { bg = "#5c1111" })
      require("mini.statusline").setup()

      local map = function(m, k, v) vim.keymap.set(m, k, v, { silent = true }) end
      map("n", "<leader>e", function() MiniFiles.open() end)
      map("n", "<C-p>", function() MiniPick.builtin.files() end)
      map("n", "<C-g>", function() MiniPick.builtin.grep_live() end)
      map("n", "<leader>gs", function() MiniGit.show_at_cursor() end)
      map("n", "<leader>gd", function() MiniDiff.toggle_overlay() end)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("i", "<C-s>", "<esc>", { buffer = args.data.buf_id })
          vim.keymap.set("n", "<M-h>", "<left>",  { buffer = args.data.buf_id })
          vim.keymap.set("n", "<M-l>", "<right>", { buffer = args.data.buf_id })
          vim.keymap.set("n", "<leader>e", function() MiniFiles.close() end, { buffer = args.data.buf_id })
          vim.keymap.set("n", "<CR>", function() MiniFiles.go_in({ close_on_file = true }) end, { buffer = args.data.buf_id })
        end,
      })
    end,
  },
}
