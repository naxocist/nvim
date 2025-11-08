local input_buf = nil
local output_buf = nil
local input_file = "/tmp/cp_in"
local output_file = "/tmp/cp_out"
local time_file = "/tmp/cp_time"
local exe = "/tmp/cp_exec"
local exit_file = "/tmp/cp_exitcode"

local timelimit_seconds = 2
local max_output_chars = 5000
local compile_flags = "-O2 -std=c++17"

local keymap = vim.keymap.set

local function toggle_output()
  if input_buf and vim.api.nvim_buf_is_valid(input_buf) then
    vim.api.nvim_buf_delete(input_buf, { force = true })
    input_buf = nil
  end
  if output_buf and vim.api.nvim_buf_is_valid(output_buf) then
    vim.api.nvim_buf_delete(output_buf, { force = true })
    output_buf = nil
    return
  end

  vim.cmd("50vsplit " .. input_file)
  input_buf = vim.api.nvim_get_current_buf()
  vim.cmd("set norelativenumber")

  vim.cmd("split " .. output_file)
  output_buf = vim.api.nvim_get_current_buf()
  vim.cmd("set norelativenumber")

  vim.cmd("wincmd p")
end

local function force_open_refresh_output()
  if output_buf and vim.api.nvim_buf_is_valid(output_buf) then
    vim.api.nvim_buf_call(output_buf, function()
      vim.cmd("silent! edit " .. output_file)
    end)
  else
    toggle_output()
  end
end

local function compile_run_cpp()
  local file = vim.api.nvim_buf_get_name(0)
  if not file:match("%.cpp$") then
    print("Not a C++ file!")
    return
  end

  local compile_cmd = string.format("g++ %s '%s' -o '%s' 2>&1", compile_flags, file, exe)
  local compile_out = vim.fn.systemlist(compile_cmd)

  if vim.v.shell_error ~= 0 then
    local f = io.open(output_file, "w")
    if f == nil then
      print("output_file not found")
      return
    end
    f:write(table.concat(compile_out, "\n"))
    f:close()

    print("Compilation Failed")
    force_open_refresh_output()
    return
  end

  local run_cmd = string.format(
    "/usr/bin/time -f \"%%e\" -o '%s' timeout %d sh -c \"'%s' < '%s'\" > '%s' 2>&1; echo $? > '%s'",
    time_file,
    timelimit_seconds,
    exe,
    input_file,
    output_file,
    exit_file
  )
  os.execute(run_cmd)

  local f_exit_r = io.open(exit_file, "r")
  if f_exit_r == nil then
    print("exit_file not found")
    return
  end
  local exit_code = tonumber(f_exit_r:read("*a")) or -1
  f_exit_r:close()

  local f_out_r = io.open(output_file, "r")
  if f_out_r == nil then
    print("output_file not found")
    return
  end
  local output = f_out_r:read("*a") or ""
  f_out_r:close()

  local f_time_r = io.open(time_file, "r")
  if f_time_r == nil then
    print("time_file not found")
    return
  end
  local elapsed = f_time_r:read("*a") or ""
  elapsed = elapsed:gsub("%s+$", "")
  elapsed = elapsed:gsub("\n", " ")

  ---------------------------------------------------------------------------
  --- To process: exit_code, output, elapsed
  ---------------------------------------------------------------------------
  if exit_code == 124 then
    output = output:sub(1, max_output_chars)
  elseif exit_code ~= 0 then
    output = string.format("RUNTIME ERROR\n%s", output)
  else
    if #output > max_output_chars then
      output = output:sub(1, max_output_chars) .. "\n[truncated]"
    end
  end

  local f_out_w = io.open(output_file, "w")
  if f_out_w == nil then
    print("output_file not found")
    return
  end
  f_out_w:write(output)
  f_out_w:close()

  force_open_refresh_output()

  local msg = ""
  if exit_code == 0 then
    msg = "SUCCESS"
  elseif exit_code == 124 then
    msg = "TIMEOUT"
  else
    msg = "RUNTIME ERROR"
  end

  msg = string.format("%s, %ss", msg, elapsed)
  print(msg)
end

keymap("n", "<leader>i", toggle_output)
keymap("n", "<leader>r", compile_run_cpp, { noremap = true, silent = true })

-- # TESTCASE MANAGEMENT in plain text
local separator = ">>>>>>>>>>>>>"
local function find_separators()
  local start = vim.fn.search("^" .. separator .. "$", "bnW")
  local stop = vim.fn.search("^" .. separator .. "$", "nW")

  local cur_line = vim.fn.line(".") -- current cursor line
  local line_text = vim.fn.getline(cur_line) -- text of current line

  if not start or not stop or start > stop or start == -1 or stop == -1 or line_text == separator then
    print("Invalid Testcase")
    return nil, nil
  end

  print(start, stop)
  return start, stop
end

local function feedkeys(cmd)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "n", false)
end

-- add blank testcase (insert mode)
keymap("n", "ti", function()
  local cmd = "ggO" .. separator .. "<ESC>O"
  feedkeys(cmd)
end)
-- edit testcase (insert mode)
keymap("n", "te", function()
  local start, stop = find_separators()
  if not start or not stop then
    return
  end
  local cmd = string.format("%sGk<S-v>", stop)
  local size = stop - start - 1
  if size > 1 then
    cmd = cmd .. tostring(size - 1) .. "k"
  end
  cmd = cmd .. "c"
  feedkeys(cmd)
end)
-- add testcase
keymap("n", "ta", function()
  -- string from trimmed system clipboard
  local trimmed = vim.fn.getreg("+"):gsub("^%s+", ""):gsub("%s+$", "")
  local cmd = "ggO" .. separator .. "<ESC>O" .. trimmed .. "<ESC>"
  feedkeys(cmd)
end)
-- delete testcase
keymap("n", "td", function()
  local start, stop = find_separators()
  if not start or not stop then
    return
  end
  local size = stop - start - 1
  local cmd = string.format("%sGV", stop)
  if size >= 1 then
    cmd = cmd .. tostring(size) .. "k"
  end
  cmd = cmd .. "d"
  feedkeys(cmd)
end)
-- choose testcase
keymap("n", "tu", function()
  local start, stop = find_separators()
  if not start or not stop then
    return
  end
  if start <= stop then
    local size = stop - start - 1
    local cmd = string.format("%sGV%skdggP", stop, size)
    feedkeys(cmd)
  end
end)
