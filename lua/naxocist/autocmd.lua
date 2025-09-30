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
