return {
  "saghen/blink.cmp",
  version = "*",
  build = "cargo build --release",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "supermaven-inc/supermaven-nvim",
    { "saghen/blink.compat", opts = {} },
  },
  opts = {
    completion = {
      menu = {
        border = "rounded",
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    sources = {
      default = { "supermaven", "lsp", "path", "buffer", "snippets" },
      providers = {
        supermaven = {
          name = "supermaven",
          module = "blink.compat.source",
          score_offset = 100,
          async = true,
        },
        snippets = {
          name = "snippets",
          enabled = true,
          max_items = 8,
          min_keyword_length = 2,
        },
      },
    },
    appearance = {
      kind_icons = {
        Supermaven = "*",
      },
    },
    keymap = {
      ["<Tab>"] = {
        "snippet_forward",
        "select_and_accept",
        "fallback",
      },
    },
  },
}
