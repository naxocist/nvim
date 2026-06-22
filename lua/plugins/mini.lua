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
    end,
  },
}
