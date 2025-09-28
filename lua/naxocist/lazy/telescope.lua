return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
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
    local themes = require("telescope.themes")

    vim.keymap.set("n", "<leader>pf", function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)

    vim.keymap.set("n", "<leader>lg", builtin.live_grep)
  end
}
