require('mason').setup({
  PATH = 'prepend',
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'basedpyright',
    'clangd',
    'ruff',
    'jsonls',
    'yamlls',
    'lua_ls',
    'zls',
  },
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'clang-format',
    'codelldb',
    'debugpy',
    'prettier',
    'sqlfluff',
    'stylua',
    'shfmt',
    'tree-sitter-cli',
  },
  run_on_start = true,
  auto_update = false,
  debounce_hours = 24,
})
