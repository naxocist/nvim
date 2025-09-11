local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
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

-- Auto format on save (except C++)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("lsp_format_on_save"),
  callback = function(args)
    local lang_to_auto_format = {
      lua = true,
      ts = true,
      js = true,
      c = true,
      py = true,
      css = true
    }

    local file_type = vim.bo[args.buf].filetype
    if lang_to_auto_format[file_type] then
      vim.lsp.buf.format({ bufnr = args.buf })
    end
  end,
})

-- LSP attach: highlights + format mapping
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
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
      local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })

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
  end,
})
