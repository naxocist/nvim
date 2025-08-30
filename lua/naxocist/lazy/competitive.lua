local input_file = "/home/naxocist/.config/nvim/lua/naxocist/lazy/cp_input.txt"
local terminal_bufnr = nil
local terminal_winid = nil
local term_height = 10

-- Toggle input file in vertical split
local function toggle_input()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name == input_file then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.cmd("vsplit " .. input_file)
end

-- Compile and run current C++ file
local function run_cpp()
  local file_path = vim.api.nvim_buf_get_name(0)
  if not file_path:match("%.cpp$") then
    print("Not a C++ file!")
    return
  end

  local output_file = file_path:gsub("%.cpp$", ".exe")
  local cmd = string.format("g++ %s -o %s && %s < %s", file_path, output_file, output_file, input_file)

  -- Open terminal if not exists
  if not terminal_bufnr or not vim.api.nvim_buf_is_valid(terminal_bufnr) then
    terminal_bufnr = vim.api.nvim_create_buf(false, true)
  end

  if not terminal_winid or not vim.api.nvim_win_is_valid(terminal_winid) then
    vim.cmd(string.format("botright %dsplit", term_height))
    terminal_winid = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(terminal_winid, terminal_bufnr)
  end

  -- Run command in terminal
  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      if exit_code == 0 then
        print("Execution finished successfully.")
      else
        print("Execution terminated with code: " .. exit_code)
      end
    end,
  })
end

-- Automatically delete terminal buffer when closed
vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*",
  callback = function()
    if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
      vim.api.nvim_buf_delete(terminal_bufnr, { force = true })
      terminal_bufnr = nil
      terminal_winid = nil
    end
  end,
})


vim.keymap.set("n", "<leader>i", toggle_input, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", run_cpp, { noremap = true, silent = true })

return {}
