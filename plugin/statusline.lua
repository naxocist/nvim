local state = {
  show_path = true,
}

local config = {
  icons = {
    path_hidden = "", -- opened directory icon
  },
}

local function git()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end

  local head = git_info.head
  local added = git_info.added and (" +" .. git_info.added) or ""
  local changed = git_info.changed and (" ~" .. git_info.changed) or ""
  local removed = git_info.removed and (" -" .. git_info.removed) or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end

  return table.concat({
    "[ ", -- branch icon
    head,
    added,
    changed,
    removed,
    "]",
  })
end

local function filepath()
  -- Modify the given file path with the given modifiers
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")

  if fpath == "" or fpath == "." then
    return ""
  end

  -- Whether to show the path or the icon
  if state.show_path then
    return string.format("%%<%s/", fpath)
  end

  return config.icons.path_hidden .. "/"

  -- `%%` -> `%`.
  -- `%s` -> value of `fpath`.
  -- The result is `%<fpath/`.
  -- `%<` tells where to truncate when there is not enough space.
end

Statusline = {}

function Statusline.toggle_path()
  state.show_path = not state.show_path

  -- Draw the statusline manually
  vim.cmd("redrawstatus")
end
vim.keymap.set("n", "<leader>sp", function()
  Statusline.toggle_path()
end, { desc = "Toggle statusline path" })

function Statusline.active()
  return table.concat({
    -- Before: `[%f]`
    -- `%t` shows only the file name
    "[",
    filepath(),
    "%t] ",
    git(),
    "%=",
    "%y [%P %l:%c]",
  })
end

function Statusline.inactive()
  return " %t"
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = group,
  desc = "Activate statusline on focus",
  callback = function()
    vim.opt_local.statusline = "%!v:lua.Statusline.active()"
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = group,
  desc = "Deactivate statusline when unfocused",
  callback = function()
    vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
  end,
})
