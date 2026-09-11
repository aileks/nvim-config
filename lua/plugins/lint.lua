local lint = require('lint')

lint.linters_by_ft = {
  sql = { 'sqlfluff' },
  python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  group = vim.api.nvim_create_augroup('config-lint', { clear = true }),
  desc = 'Lint supported buffers',
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set('n', '<leader>ln', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '<leader>lp', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Previous diagnostic' })
