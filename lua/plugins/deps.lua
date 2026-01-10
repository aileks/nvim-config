return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "rafamadriz/friendly-snippets", lazy = true },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      require("multicursor-nvim").setup()
    end,
  },
}

