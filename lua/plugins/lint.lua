local lint = require('lint')
local checkstyle = require('lint.linters.checkstyle')

lint.linters.checkstyle = function()
  local config = vim.fs.find('checkstyle.xml', {
    upward = true,
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })[1]
  checkstyle.config_file = config or '/google_checks.xml'
  return checkstyle
end

lint.linters_by_ft = {
  sql = { 'sqlfluff' },
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  java = { 'checkstyle' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
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
