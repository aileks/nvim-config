local parsers = {
  "lua",
  "rust",
  "zig",
  "c",
  "cpp",
  "xml",
  "typst",
  "markdown",
  "markdown_inline",
  "vim",
  "vimdoc",
  "json",
  "yaml",
  "toml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install(parsers)
  end,
}
