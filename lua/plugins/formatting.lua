local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    python = { 'ruff_organize_imports', 'ruff_format' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    sql = { 'sqlfluff' },
    sh = { 'shfmt' },
    lua = { 'stylua' },
    bash = { 'shfmt' },
    zig = { 'zigfmt' },
  },

  formatters = {
    shfmt = {
      append_args = {
        '-i',
        '2',
        '-ci',
        '-bn',
      },
    },
    clang_format = {
      append_args = function(_, ctx)
        local config = vim.fs.find({ '.clang-format', '_clang-format' }, {
          path = vim.fs.dirname(ctx.filename),
          upward = true,
        })[1]

        if config then
          return {}
        end

        local global_config = vim.fs.normalize('~/.clang-format')
        if vim.uv.fs_stat(global_config) then
          return { '--style=file:' .. global_config }
        end
        return {}
      end,
    },
  },

  format_on_save = {
    timeout_ms = 3000,
    lsp_format = 'fallback',
  },
})

vim.keymap.set('n', '<leader>lf', function()
  conform.format({
    async = true,
    lsp_format = 'fallback',
  })
end, { desc = 'Format buffer' })
