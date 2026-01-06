return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      highlight = "IblIndent",
    },
    whitespace = {
      highlight = "IblWhitespace",
    },
    scope = { enabled = true },
  },
}
