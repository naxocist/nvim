local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- disable json conceal level
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})


-- LSP attach: highlights + autoformat
local autoformat_filetypes = {
  lua = true,
  python = true,
  go = true,
  javascript = true,
  typescript = true,
  jsonc = true,
  json = true,
  -- svelte = true
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    if not client then return end

    -- buffer-local keymap for formatting
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end, { buffer = bufnr, desc = "Format buffer with LSP" })

    -- documentHighlight support
    if client:supports_method("textDocument/documentHighlight") then
      local group = augroup("lsp_document_highlight_" .. bufnr)

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = group,
        callback = function() pcall(vim.lsp.buf.document_highlight) end,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })

      -- cleanup on detach
      vim.api.nvim_create_autocmd("LspDetach", {
        buffer = bufnr,
        once = true,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
        end,
      })
    end

    if autoformat_filetypes[vim.bo[bufnr].filetype] then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = augroup("lsp_autoformat_" .. bufnr),
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

-- DIAGNOSTIC COLOR on line numbers
vim.cmd([[
  highlight! link DiagnosticLineNrError DiagnosticError
  highlight! link DiagnosticLineNrWarn  DiagnosticWarn
  highlight! link DiagnosticLineNrInfo  DiagnosticInfo
  highlight! link DiagnosticLineNrHint  DiagnosticHint
]])

-- Function to colorize line numbers based on diagnostics
local function set_line_diagnostic_hl()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      local diags = vim.diagnostic.get(bufnr)
      local ns = vim.api.nvim_create_namespace("diagnostic_line_nr")

      -- Clear old highlights
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

      for _, d in ipairs(diags) do
        local hl_group = ({
          [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
          [vim.diagnostic.severity.WARN]  = "DiagnosticLineNrWarn",
          [vim.diagnostic.severity.INFO]  = "DiagnosticLineNrInfo",
          [vim.diagnostic.severity.HINT]  = "DiagnosticLineNrHint",
        })[d.severity]

        if hl_group then
          vim.api.nvim_buf_set_extmark(bufnr, ns, d.lnum, 0, {
            end_line = d.lnum,
            hl_group = hl_group,
            hl_mode = "combine",
            number_hl_group = hl_group, -- this is the key: color the number column
          })
        end
      end
    end
  end
end

-- Update whenever diagnostics change
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
  callback = set_line_diagnostic_hl,
})
