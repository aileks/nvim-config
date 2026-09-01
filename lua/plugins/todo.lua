local todo = require('todo-comments')

todo.setup({
  keywords = {
    TODO = { color = 'warning' },
    PERF = { color = 'hint' },
    NOTE = { color = 'info' },
  },
  colors = {
    test = { '@label', 'Identifier' },
  },
})

vim.keymap.set('n', ']t', todo.jump_next, { desc = 'Next todo comment' })
vim.keymap.set('n', '[t', todo.jump_prev, { desc = 'Previous todo comment' })
vim.keymap.set('n', '<leader>ft', '<cmd>TodoFzfLua<CR>', { desc = 'Todo comments' })
