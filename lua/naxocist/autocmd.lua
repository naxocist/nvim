local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end


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

    -- Check if client supports a method
    ---@diagnostic disable-next-line:redefined-local
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      -- Create a buffer-local augroup
      local highlight_augroup = vim.api.nvim_create_augroup("lsp_highlight_" .. event.buf, { clear = true })

      -- Highlight references on CursorHold
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      -- Clear highlights when cursor moves
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- Cleanup on detach
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp_detach_" .. event.buf, { clear = true }),
        buffer = event.buf,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = event2.buf }
        end,
      })
    end
  end,
})
