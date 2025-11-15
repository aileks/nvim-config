local builtin = require("telescope.builtin")
local actions = require("actions-preview")
local ls = require("luasnip")

function all_files()
  builtin.find_files({ no_ignore = true })
end

function format()
  require("conform").format({ async = true })
end

vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":write<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", format)
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { silent = true })
vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>ps", vim.pack.update)
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>h", builtin.help_tags)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>d", builtin.diagnostics)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<leader>ca", actions.code_actions)
vim.keymap.set("n", "<leader>F", all_files)
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set({ "n", "t" }, "<leader>t", ":tabnew<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<leader>x", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<C-f>", ":Open .<CR>")
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set({ "i", "s" }, "<C-e>", function()
  ls.expand_or_jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Easy tab switching
for i = 1, 8 do
  vim.keymap.set({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

