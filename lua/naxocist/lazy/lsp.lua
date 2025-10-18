return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = { "c", "cpp", "python", "lua", "vim", "markdown" },
        auto_install = true,
        highlight = { enable = true }
      }
    end
  },

  {

    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", config = true },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim",    opts = { notification = { window = { winblend = 0, }, }, }, },
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
}
