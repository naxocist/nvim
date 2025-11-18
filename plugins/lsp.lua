vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },

  { src = "https://github.com/nvimtools/none-ls.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },

  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})
require("fidget").setup()
require("typst-preview").setup({ dependencies_bin = { ["tinymist"] = "tinymist" } })
require("nvim-treesitter.configs").setup({ auto_install = true, highlight = { enable = true } })

require("mason").setup()
require("mason-lspconfig").setup()

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rustywind,
    null_ls.builtins.formatting.gofmt,
  },
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" }})
require("blink.cmp").setup({
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
  keymap = {
    preset = "enter",
    ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-j>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-h>"] = { "show_signature", "hide_signature", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "normal",
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },

  cmdline = {
    keymap = {
      preset = "inherit",
      ["<CR>"] = { "accept_and_enter", "fallback" },
    },
  },

  sources = { default = { "lsp", "snippets" } },
})

local keymap = vim.keymap.set
keymap("n", "<leader>od", vim.diagnostic.open_float)
keymap("n", "<leader>ca", vim.lsp.buf.code_action)
keymap("n", "gd", vim.lsp.buf.definition)
keymap("n", "gi", vim.lsp.buf.implementation)
keymap("n", "<leader>t", ":TypstPreview<CR>")

