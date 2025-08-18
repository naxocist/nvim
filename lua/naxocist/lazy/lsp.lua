return {
  {
    -- MASON + nvim-lspconfig + MASON-LSPCONFIG
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      vim.lsp.config('*', {
        root_markers = { '.git' },
      })

      vim.lsp.config.clangd = {
        cmd = {
          "clangd",
          "--clang-tidy",
          "--background-index",
          "--offset-encoding=utf-8",
          "--header-insertion=never"
        },
        root_markers = { ".clangd", "compile_commands.json" },
        filetypes = { "c", "cpp" },
      }

      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "pyright", "clangd", "gopls" }
      }

    end
  },

  -- COMPLETION ENGINE ~ blink.cmp
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" }, -- large snippet sources

    version = "1.*",

    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "enter",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      appearance = { nerd_font_variant = "mono" },

      completion = { documentation = { auto_show = true } },

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

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}

