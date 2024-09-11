return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        -- transparent_mode = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
