require('nvim-treesitter').install({
  'lua',
  'zig',
  'vim',
  'vimdoc',
  'regex',
  'query',
  'markdown',
  'markdown_inline',
  'python',
  'c',
  'cpp',
  'cmake',
  'make',
  'sql',
  'json',
  'yaml',
  'bash',
  'diff',
  'gitcommit',
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('config-treesitter', { clear = true }),
  desc = 'Enable Tree-sitter when a parser is available',
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
