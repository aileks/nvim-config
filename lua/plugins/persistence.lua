local persistence = require('persistence')

persistence.setup({})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Restore session when starting without file arguments',
  callback = function()
    if vim.fn.argc(-1) == 0 then
      persistence.load()
    end
  end,
})

local map = vim.keymap.set

map('n', '<leader>ss', function()
  persistence.load()
end, { desc = 'Restore session for cwd' })
map('n', '<leader>sl', function()
  persistence.load({ last = true })
end, { desc = 'Restore last session' })
map('n', '<leader>sd', function()
  persistence.stop()
end, { desc = 'Stop session saving' })
