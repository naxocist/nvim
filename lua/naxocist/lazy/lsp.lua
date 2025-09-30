return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true)
            }
          }
        }
      }

      -- clangd custom config
      vim.lsp.config.clangd = {
        root_markers = { ".clangd", "compile_commands.json" },
        cmd = {
          "clangd",
          "--clang-tidy",
          "--background-index",
          "--offset-encoding=utf-8",
          "--header-insertion=never",
        },
        filetypes = { "c", "cpp" },
      }

      -- mason-lspconfig setup
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "gopls", "yamlls", "html", "cssls", "vtsls" },
      }

      -- diagnostics keymap
      vim.keymap.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>")
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })    -- go to declaration
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true }) -- go to implementation (if supported)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })     -- find references
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })           -- hover docs
    end,
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
        default = { "lsp", "path", "snippets", "buffer" },
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
    "luckasRanarison/tailwind-tools.nvim",
    ft = "ts",
    event = "VeryLazy",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      keymaps = {
        smart_increment = {
          enabled = false
        }
      }
    }
  }
}
