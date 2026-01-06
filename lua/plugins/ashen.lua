return {
  "ficd0/ashen.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  config = function(_, opts)
    require("ashen").setup(opts)
    vim.cmd([[colorscheme ashen]])
  end,
}
