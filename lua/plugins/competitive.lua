local input_path = "~/.config/nvim/lua/plugins/cp_input.txt"

return {
  {
    "A7lavinraj/assistant.nvim",
    lazy = false,
    keys = {
      { "<leader>c", "<cmd>Assistant<cr>"}
    },
    opts = {
      commands = {
        cpp = {
          compile = {
            args = { "$FILENAME_WITH_EXTENSION", "-o", "$FILENAME_WITHOUT_EXTENSION.exe"},
          },
          execute = {
            main = "bash",
            args = {"-c", "./$FILENAME_WITHOUT_EXTENSION.exe"}
          },
        }
      },
      core = {
        process_budget = 3000,
      }
    }
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      {
        "<leader>r",
        function()
          -- Save input.txt if loaded & modified
          local input_buf = vim.fn.bufnr(input_path)
          if input_buf ~= -1 and vim.api.nvim_buf_is_loaded(input_buf) then
            if vim.api.nvim_buf_get_option(input_buf, "modified") then
              vim.api.nvim_buf_call(input_buf, function()
                vim.cmd("write")
              end)
            end
          end

          -- Build command based on filetype
          local filename = vim.fn.expand("%:t")
          local filename_noext = vim.fn.expand("%:r")
          local ext = vim.fn.expand("%:e")
          local cmd = ""


          if ext == "cpp" then
            cmd = string.format("g++ %s -o %s.exe && ./%s.exe < %s", filename, filename_noext, filename_noext, input_path)
          elseif ext == "py" then
            cmd = string.format("python3 %s < %s", filename, input_path)
          else
            vim.notify("Unsupported filetype: " .. ext)
            return
          end

          -- Use ToggleTerm to run the command
          local Terminal = require("toggleterm.terminal").Terminal

          -- Close old terminal if exists
          if run_term and run_term:is_open() then
            run_term:close()
          end

          -- global terminal
          run_term = Terminal:new({
            direction = "horizontal",
            close_on_exit = false,
            hidden = true,
            on_open = function(term)
              -- Enter normal mode automatically
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)

              -- Optional: map `q` to close the terminal (in normal mode)
              vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })

              -- Optional: disable insert mode on re-entry
              vim.api.nvim_create_autocmd("BufEnter", {
                buffer = term.bufnr,
                callback = function()
                  if vim.fn.mode() == "t" then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
                  end
                end,
              })
            end,
            cmd = string.format("bash -c '%s'", cmd),
          })
          run_term:toggle()
        end,
        desc = "Run code with cp_input.txt",
      },

      {
        "<leader>i",
        string.format(":vsplit %s<CR>", input_path),
        desc = "Open input.txt",
      },
    },
  }
}
