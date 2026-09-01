require('nvim-treesitter').install({
  'lua',
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
  'sql',
  'javascript',
  'typescript',
  'tsx',
  'json',
  'yaml',
  'html',
  'css',
  'bash',
  'diff',
  'gitcommit',
  'go',
  'gomod',
  'gosum',
  'gowork',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
