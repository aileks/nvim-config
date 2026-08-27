require('mason').setup({
  PATH = 'prepend',
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'basedpyright',
    'clangd',
    'ruff',
    'vtsls',
    'jsonls',
    'yamlls',
    'lua_ls',
    'gopls',
    'jdtls',
  },

  automatic_enable = { exclude = { 'jdtls' } },
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'clang-format',
    'codelldb',
    'debugpy',
    'prettier',
    'eslint_d',
    'js-debug-adapter',
    'sqlfluff',
    'stylua',
    'shfmt',
    'tree-sitter-cli',
    'goimports',
    'gofumpt',
    'java-debug-adapter',
    'checkstyle',
    'google-java-format',
  },
  run_on_start = true,
  auto_update = false,
  debounce_hours = 24,
})
