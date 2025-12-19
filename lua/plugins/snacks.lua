require("snacks").setup({
  picker = {
    enabled = true,
    sources = {
      explorer = {
        layout = {
          layout = {
            width = 35,
            position = "right",
          },
          preview = true,
        },
      },
    },
  },
  explorer = { enabled = true },
  input = { enabled = true },
  git = { enabled = true },
  gh = { enabled = true },
  zen = {
    enabled = true,
    win = {
      width = 120,
      height = 0.95,
      backdrop = { transparent = false },
    },
    toggles = {
      dim = false,
    },
  },
})
