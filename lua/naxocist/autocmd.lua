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
    if vim.bo[args.buf].filetype ~= "cpp" then
      vim.lsp.buf.format({ bufnr = args.buf })
    end
  end,
})

-- LSP ATTACH
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if not client then return end

    -- Check if client supports documentHighlight
    local supports_highlight =
        vim.fn.has("nvim-0.11") == 1
        and client:supports_method("textDocument/documentHighlight", bufnr)
        or client.supports_method(client, { bufnr = bufnr })

    if not supports_highlight then return end

    local highlight_group = vim.api.nvim_create_augroup("lsp_highlight_" .. bufnr, { clear = true })

    local function make_autocmd(events, callback)
      vim.api.nvim_create_autocmd(events, {
        buffer = bufnr,
        group = highlight_group,
        callback = callback,
      })
    end

    make_autocmd({ "CursorHold", "CursorHoldI" }, vim.lsp.buf.document_highlight)
    make_autocmd({ "CursorMoved", "CursorMovedI" }, vim.lsp.buf.clear_references)

    -- Cleanup on detach
    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("lsp_detach_" .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = highlight_group, buffer = event2.buf }
      end,
    })
  end,
})
