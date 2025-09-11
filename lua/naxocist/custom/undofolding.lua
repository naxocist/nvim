-- Store the last fold command
local last_fold_cmd = nil

-- Helper: run a fold command and remember it
local function fold_and_remember(cmd)
  vim.cmd("normal! " .. cmd)
  last_fold_cmd = cmd
end

-- Undo the last fold action
local function undo_last_fold()
  if not last_fold_cmd then
    print("No fold action to undo")
    return
  end

  local inverse = nil
  if last_fold_cmd == "zM" then
    inverse = "zR"
  elseif last_fold_cmd == "zR" then
    inverse = "zM"
  elseif last_fold_cmd == "za" or last_fold_cmd == "zA" then
    inverse = last_fold_cmd -- toggle back
  elseif last_fold_cmd == "zc" then
    inverse = "zo"
  elseif last_fold_cmd == "zo" then
    inverse = "zc"
  end

  if inverse then
    vim.cmd("normal! " .. inverse)
  end

  -- Clear so it doesn’t keep undoing the same thing
  last_fold_cmd = nil
end

-- Keymaps for fold commands with tracking
vim.keymap.set("n", "zM", function() fold_and_remember("zM") end)
vim.keymap.set("n", "zR", function() fold_and_remember("zR") end)
vim.keymap.set("n", "za", function() fold_and_remember("za") end)
vim.keymap.set("n", "zA", function() fold_and_remember("zA") end)
vim.keymap.set("n", "zc", function() fold_and_remember("zc") end)
vim.keymap.set("n", "zo", function() fold_and_remember("zo") end)

-- Undo keymap
vim.keymap.set("n", "zu", undo_last_fold, { desc = "Undo last fold action" })
