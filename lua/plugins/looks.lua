return {
  "vague-theme/vague.nvim",
  config = function()
    require("vague").setup({
      transparent = true,
      bold = true,
      italic = false,
    })

    vim.cmd("color vague")

    -- highlight on yank
    vim.api.nvim_set_hl(0, "YankFlash", { bg = "#f6c177", fg = "#000000" })
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
      callback = function()
        vim.highlight.on_yank({ higroup = "YankFlash", timeout = 150 })
      end,
    })
  end,
}
