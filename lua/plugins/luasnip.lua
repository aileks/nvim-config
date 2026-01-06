return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  lazy = true,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").setup({
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })
  end,
}
