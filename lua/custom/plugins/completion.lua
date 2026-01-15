return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
  },
  version = "1.*",
  opts = {
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

    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = false } },

    snippets = { preset = "luasnip" },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
