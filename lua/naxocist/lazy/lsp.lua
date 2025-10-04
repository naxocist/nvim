return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    { "j-hui/fidget.nvim",    opts = { notification = { window = { winblend = 0, }, }, }, },

    -- Allows extra capabilities provided by nvim-cmp
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>od", vim.diagnostic.open_float, "open [D]iagnostic")
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    local capabilities = vim.tbl_deep_extend("force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities(),
      {
        general = {
          positionEncodings = { "utf-16" },
        },
      }
    )
    -- Add any additional override configuration in the following tables. Available keys are:
    -- - cmd (table): Override the default command used to start the server
    -- - filetypes (table): Override the default list of associated filetypes for the server
    -- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    -- - settings (table): Override the default settings passed when initializing the server.
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
              globals = { "vim" },
              disable = { "missing-fields" },
            }
          },
        },
      },
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              pylsp_mypy = { enabled = false },
              pylsp_black = { enabled = false },
              pylsp_insort = { enabled = false },
            }
          }
        }
      },
      ruff = {},
      jsonls = {},
      sqlls = {},
      yamlls = {},
      bashls = {},
      dockerls = {},
      vtsls = {},
      gopls = {},
      docker_compose_language_service = {},
      html = {},
      cssls = {},
      tailwindcss = {},
      graphql = {},
      clangd = {
        cmd = {
          "clangd",
          "--header-insertion=never",
          "--completion-style=detailed",
        }
      },
      svelte = {}
    }

    -- Ensure the servers and tools above are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }


    for server, cfg in pairs(servers) do
      -- For each LSP server (cfg), we merge:
      -- 1. A fresh empty table (to avoid mutating capabilities globally)
      -- 2. Your capabilities object with Neovim + cmp features
      -- 3. Any server-specific cfg.capabilities if defined in `servers`
      cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

      vim.lsp.config(server, cfg)
      vim.lsp.enable(server)
    end
  end,
}

-- return {
--   {
--     "mason-org/mason-lspconfig.nvim",
--     dependencies = {
--       { "mason-org/mason.nvim", opts = {} },
--       "neovim/nvim-lspconfig",
--     },
--     config = function()
--       vim.lsp.config("*", {
--         root_markers = { ".git" },
--       })
--
--       vim.lsp.config.lua_ls = {
--         settings = {
--           Lua = {
--             workspace = {
--               library = vim.api.nvim_get_runtime_file("", true)
--             }
--           }
--         }
--       }
--
--       -- clangd custom config
--       vim.lsp.config.clangd = {
--         root_markers = { ".clangd", "compile_commands.json" },
--         cmd = {
--           "clangd",
--           "--clang-tidy",
--           "--background-index",
--           "--offset-encoding=utf-8",
--           "--header-insertion=never",
--         },
--         filetypes = { "c", "cpp" },
--       }
--
--       vim.lsp.config.pylsp = {
--         settings = {
--           pylsp = {
--             plugins = {
--               autopep8 = { enabled = false },
--               pyflakes = { enabled = false },
--               pycodestyle = { enabled = false },
--               yapf = { enabled = false },
--               mccabe = { enabled = false },
--               pylsp_mypy = { enabled = false },
--               pylsp_black = { enabled = false },
--               pylsp_isort = { enabled = false },
--             }
--           }
--         }
--       }
--
--       -- mason-lspconfig setup
--       require("mason-lspconfig").setup {
--         ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "gopls", "yamlls", "html", "cssls", "vtsls", "pylsp" },
--       }
--
--       -- diagnostics keymap
--       vim.keymap.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>")
--       vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })    -- go to declaration
--       vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true }) -- go to implementation (if supported)
--       vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })     -- find references
--       vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })           -- hover docs
--     end,
--   },
--
--   -- COMPLETION ENGINE ~ blink.cmp
--   {
--     "saghen/blink.cmp",
--     dependencies = { "rafamadriz/friendly-snippets" }, -- large snippet sources
--
--     version = "1.*",
--
--     opts = {
--       -- See :h blink-cmp-config-keymap for defining your own keymap
--       keymap = {
--         preset = "enter",
--         ["<C-k>"] = { "select_prev", "fallback" },
--         ["<C-j>"] = { "select_next", "fallback" },
--       },
--
--       appearance = { nerd_font_variant = "mono" },
--
--       completion = { documentation = { auto_show = true } },
--
--       sources = {
--         default = { "lsp", "path", "snippets", "buffer" },
--         providers = {
--           lazydev = {
--             name = "LazyDev",
--             module = "lazydev.integrations.blink",
--             -- make lazydev completions top priority (see `:h blink.cmp`)
--             score_offset = 100,
--           },
--         },
--       },
--
--       fuzzy = { implementation = "prefer_rust_with_warning" }
--     },
--     opts_extend = { "sources.default" }
--   },
--
--   {
--     "luckasRanarison/tailwind-tools.nvim",
--     ft = "ts",
--     event = "VeryLazy",
--     name = "tailwind-tools",
--     build = ":UpdateRemotePlugins",
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter",
--       "nvim-telescope/telescope.nvim",
--       "neovim/nvim-lspconfig",
--     },
--     opts = {
--       keymaps = {
--         smart_increment = {
--           enabled = false
--         }
--       }
--     }
--   }
-- }
