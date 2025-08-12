return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        styles = {
          italic = false,
          transparency = true
        }
      }

      vim.cmd "color rose-pine"

      -- ## THEME LIKE GVIM default ##
      -- vim.cmd "color morning"
      -- -- Helper to preserve foreground color
      -- local function set_bg_white(group)
      --   local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
      --   if ok and hl.fg then
      --     vim.api.nvim_set_hl(0, group, { fg = hl.fg, bg = "#FFFFFF" })
      --   end
      -- end
      --
      -- -- List of highlight groups to patch
      -- local groups = {
      --   "Normal", "NormalNC", "String", "Comment", "Keyword", "Function",
      --   "Identifier", "Type", "Constant", "Statement", "PreProc",
      --   "Special", "Todo", "Number", "LineNr", "SignColumn"
      -- }
      --
      -- -- Set them all
      -- for _, group in ipairs(groups) do
      --   set_bg_white(group)
      -- end
    end
  },

  -- {
  --   "andweeb/presence.nvim",
  --   opts = {
  --     neovim_image_text = "go checkout love live!",
  --     editing_text        = "Yapping in ****",
  --     file_explorer_text  = "Searching in a void",
  --   }
  -- }
}

