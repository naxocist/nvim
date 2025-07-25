return {

  -- file tree
  {
    "echasnovski/mini.files", 
    version = false,
    config = function()
      require('mini.files').setup()
      vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
    end
  },


  -- buffers storage management
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() 
      harpoon:list():add()

        local file_name = vim.fn.expand("%")
        print(file_name .. " was added to harpoon!")
      end)

      vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-j>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-k>", function() harpoon:list():next() end)
    end
  },

  -- Auto close parentheses and repeat by dot dot dot...
  { "cohama/lexima.vim" },

  -- Indentation guides
  { "echasnovski/mini.indentscope", version = "*", 
    opts = {} 
  },

  -- completion + snippets
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()

      local cmp = require("cmp")
      require("luasnip.loaders.from_lua").lazy_load({
        paths = "~/.config/nvim/LuaSnip"
      })

      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = {
          { name = "luasnip" }
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-e>'] = cmp.mapping.abort(),
        }),

        -- mapping = cmp.mapping.preset.insert({
        --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --   ['<C-Space>'] = cmp.mapping.complete(),
        --   ['<C-e>'] = cmp.mapping.abort(),
        --   -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --   ['<CR>'] = cmp.mapping.confirm({ select = true }), 
        -- }),
      }

    end
  }
}
