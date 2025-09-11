local input_path = "/home/naxocist/.config/nvim/lua/naxocist/custom/cp_input.txt"
local obj_path = "/home/naxocist/.config/nvim/lua/naxocist/custom/tmp"
local Terminal = require("toggleterm.terminal").Terminal

-- Keep a reference to the active run terminal
local run_term = nil

-- Utility: safely write cp_input.txt if modified
local function save_input()
  local input_buf = vim.fn.bufnr(input_path)
  if input_buf ~= -1 and vim.api.nvim_buf_is_loaded(input_buf) then
    if vim.api.nvim_buf_get_option(input_buf, "modified") then
      vim.api.nvim_buf_call(input_buf, function()
        vim.cmd("write")
      end)
    end
  end
end


-- Kill and close existing terminal
local function close_and_wipe()
  if run_term then
    run_term:close()
    run_term = nil
  end
end


-- Run code in a horizontal terminal
local function run_code()
  save_input()

  local filename = vim.fn.expand("%:t")
  local filename_noext = vim.fn.expand("%:r")
  local ext = vim.fn.expand("%:e")
  local cmd = ""

  if ext == "cpp" then
    cmd = string.format("g++ %s -o %s && %s < %s", filename, obj_path, obj_path, input_path)
  elseif ext == "py" then
    cmd = string.format("python3 %s < %s", filename, input_path)
  elseif ext == "sh" then
    cmd = string.format("chmod u+x ./%s && ./%s", filename, filename)
  else
    vim.notify("Unsupported filetype: " .. ext, vim.log.levels.ERROR)
    return
  end

  -- If terminal already open, close + wipe
  close_and_wipe()

  -- Create a new toggleterm instance
  run_term = Terminal:new({
    cmd = cmd,
    direction = "horizontal",
    close_on_exit = false,
    hidden = true,
    on_open = function(term)
      -- Resize split
      vim.cmd("resize 10")

      -- Enter normal mode immediately
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)

      -- Map `q` to quit (buffer-local)
      vim.keymap.set("n", "q", function()
        close_and_wipe()
      end, { buffer = term.bufnr, silent = true })
    end,
  })

  run_term:open()
end

-- Open cp_input.txt in vertical split
local function open_input()
  vim.cmd(string.format("50vsplit %s", input_path))
end

-- Keymaps
vim.keymap.set("n", "<leader>r", run_code, { desc = "Run code with cp_input.txt (toggleterm)" })
vim.keymap.set("n", "<leader>i", open_input, { desc = "Open input.txt" })
