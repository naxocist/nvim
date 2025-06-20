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
  }
}
