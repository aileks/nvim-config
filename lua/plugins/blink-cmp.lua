require("blink.cmp").setup({
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
      function()
        return require("sidekick").nes_jump_or_apply()
      end,
      function()
        return vim.lsp.inline_completion.get()
      end,
      "fallback",
    },
  },
})
