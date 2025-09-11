return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {}
      require("naxocist.custom.quickrun")
      require("naxocist.custom.dcbot_rerun")
    end
  }
}
