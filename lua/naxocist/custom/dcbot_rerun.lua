local Terminal = require("toggleterm.terminal").Terminal

local bot_term = nil

local function run_bot()
  if bot_term ~= nil then
    bot_term:shutdown()
    bot_term = nil
  end

  bot_term = Terminal:new({
    cmd = "python3 main.py", -- command to run your bot
    direction = "horizontal",
    close_on_exit = false,
    hidden = true,
    on_open = function(term)
      -- adjust terminal size
      vim.cmd("resize 7")
      -- go to terminal-normal mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
      -- optional: map q to close
      vim.keymap.set("n", "q", function()
        term:shutdown()
        bot_term = nil
      end, { buffer = term.bufnr, silent = true })
    end,
  })

  bot_term:open()
  vim.cmd "wincmd p"
end

vim.keymap.set("n", "<leader>dc", run_bot, { desc = "Rerun Discord bot", silent = true })
