return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      TODO = { icon = " ", color = "info" },
      FIXME = { icon = " ", color = "error" },
      HACK = { icon = " ", color = "warning" },
      NOTE = { icon = " ", color = "hint" },
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*:]],
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]],
    },
  },
}
