local parsers = {
  "lua",
  "rust",
  "zig",
  "c",
  "cpp",
  "xml",
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
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
      auto_install = true,
      ensure_installed = parsers,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
