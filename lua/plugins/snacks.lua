return {
  "folke/snacks.nvim",
  priority = 900,
  lazy = false,
  opts = {
     picker = {
       enabled = true,
       sources = {
         explorer = {
           layout = {
             layout = {
               width = 35,
               position = "left",
             },
           },
         },
       },
     },
     explorer = { enabled = true },
     input = { enabled = true },
     git = { enabled = true },
     gh = { enabled = true },
     words = { enabled = true },
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
  },
}
