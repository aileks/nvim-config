local telescope = require("telescope")
telescope.setup({
  defaults = {
    preview = { treesitter = false },
    color_devicons = true,
    sorting_strategy = "ascending",
    path_displays = { "smart" },
    layout_config = {
      height = 100,
      width = 400,
      prompt_position = "bottom",
      preview_cutoff = 40,
    },
  },
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")

