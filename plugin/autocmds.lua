-- highlight on yank
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#ffffff", fg = "#000000" })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true, higroup = "YankHighlight" })
  end,
})

-- store cursor position in previous buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- verticle split help
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.txt",
  callback = function ()
    if vim.bo.filetype == "help" then
      vim.cmd("wincmd L")
    end
  end
})

-- auto resize when terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- set colorclumn based on ft
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local excluded_fts = {
      oil = true,
      fyler = true,
      dbout = true,
      typst = true,
      markdown = true,
      help = true,
    }

    local ft = vim.bo.filetype
    if excluded_fts[ft] then
      return
    end

    local col = "100"
    vim.opt_local.colorcolumn = col
  end,
})


-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function()
    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlights when entering insert mode",
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, bold = true })

