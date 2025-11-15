vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },

  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
require("fidget").setup()

require("typst-preview").setup({
  dependencies_bin = { ["tinymist"] = "tinymist" },
})

require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = { enable = true },
})

require("mason").setup()
require("mason-lspconfig").setup()

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

  sources = { default = { "lsp" } },
})

local keymap = vim.keymap.set
keymap("n", "<leader>od", vim.diagnostic.open_float)
keymap("n", "<leader>ca", vim.lsp.buf.code_action)

local builtin = require("telescope.builtin")
keymap("n", "gd", builtin.lsp_definitions)
keymap("n", "gi", builtin.lsp_implementations)

keymap("n", "<leader>t", ":TypstPreview<CR>")

-- enable recursively search in current folder in gf, ex. including node_modules
vim.opt.path:append("**")
