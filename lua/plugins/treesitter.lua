require("nvim-treesitter").setup()
require("nvim-treesitter")
  .install({
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
    "java",
    "xml",
    "typst",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
  }, { summary = false })
  :wait(30000)

