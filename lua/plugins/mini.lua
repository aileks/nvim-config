return {
  "nvim-mini/mini.nvim",
  event = { "BufReadPost", "BufNewFile", "InsertEnter" },
  config = function()
    require("mini.pairs").setup()
    require("mini.surround").setup()
  end,
}
