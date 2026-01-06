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

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Auto-install parsers on startup
require("nvim-treesitter").install(parsers)
