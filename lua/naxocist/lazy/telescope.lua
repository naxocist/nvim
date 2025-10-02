return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  commit = 'b4da76be54691e854d3e0e02c36b0245f945c2c7',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup {
      defaults = {
        mappings = {
          n = {
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous
          },
          i = {
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous
          }
        }
      }
    }

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
    vim.keymap.set("n", "<leader>gp", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }); end)
    vim.keymap.set("n", "<leader>lg", builtin.live_grep)
  end
}
