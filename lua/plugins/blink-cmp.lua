return {
  "saghen/blink.cmp",
  version = "*",
  build = "cargo build --release",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
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
      default = { "lsp", "path", "buffer", "snippets" },
      providers = {
        snippets = {
          name = "snippets",
          enabled = true,
          max_items = 8,
          min_keyword_length = 2,
        },
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
