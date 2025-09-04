local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- ~/.config/nvim/lua/naxocist/run.lua
local M = {}

local input_path = "/home/naxocist/.config/nvim/lua/naxocist/lazy/cp_input.txt"
local run_bufnr = nil
local run_winid = nil
local run_jobid = nil

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

-- Kill process if still running
local function kill_job()
  if run_jobid and run_jobid > 0 then
    vim.fn.jobstop(run_jobid)
    run_jobid = nil
  end
end

-- Close + wipe terminal buffer
local function close_and_wipe()
  kill_job()

  if run_winid and vim.api.nvim_win_is_valid(run_winid) then
    vim.api.nvim_win_close(run_winid, true)
  end

  if run_bufnr and vim.api.nvim_buf_is_valid(run_bufnr) then
    vim.api.nvim_buf_delete(run_bufnr, { force = true })
  end

  run_bufnr = nil
  run_winid = nil
end

-- Run code in a horizontal terminal
local run_code = function()
  save_input()

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

  -- If terminal already open, close + wipe
  close_and_wipe()

  -- Open a horizontal split
  vim.cmd("belowright split | resize 15")
  run_winid = vim.api.nvim_get_current_win()

  -- Create a fresh scratch buffer for terminal
  run_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(run_winid, run_bufnr)

  -- Start terminal job in this buffer
  run_jobid = vim.fn.termopen({ "bash", "-c", cmd }, {
    on_exit = function(_, code)
      run_jobid = nil
      if code ~= 0 then
        vim.notify("Process exited with code " .. code, vim.log.levels.ERROR)
      end
    end,
  })

  -- Enter normal mode immediately
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)

  -- Map q to kill + close + wipe
  vim.keymap.set("n", "q", function()
    close_and_wipe()
  end, { buffer = run_bufnr, silent = true })
end

-- Open cp_input.txt in vertical split
local open_input = function()
  vim.cmd(string.format("50vsplit %s", input_path))
end

-- Keymaps
vim.keymap.set("n", "<leader>r", run_code, { desc = "Run code with cp_input.txt" })
vim.keymap.set("n", "<leader>i", open_input, { desc = "Open input.txt" })

return M
