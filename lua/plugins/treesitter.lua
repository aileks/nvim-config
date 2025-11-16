require("nvim-treesitter").setup()
require("nvim-treesitter")
  .install({
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "xml",
    "typst",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
  }, { summary = false })
  :wait(30000)

