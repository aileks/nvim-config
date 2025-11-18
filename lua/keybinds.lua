local snacks = require("snacks")
local actions = require("actions-preview")
local ls = require("luasnip")
local dap = require("dap")

local function format()
  require("conform").format({ async = true })
end

local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":write<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", format)
vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>ps", vim.pack.update)

vim.keymap.set("n", "<leader>e", function()
  snacks.explorer()
end, { silent = true })
vim.keymap.set("n", "<leader>f", function()
  snacks.picker.files()
end)
vim.keymap.set("n", "<leader>g", function()
  snacks.picker.grep()
end)
vim.keymap.set("n", "<leader>b", function()
  snacks.picker.buffers()
end)
vim.keymap.set("n", "<leader>d", function()
  snacks.picker.diagnostics()
end)
vim.keymap.set("n", "<leader>gb", function()
  snacks.picker.git_branches()
end)
vim.keymap.set("n", "<leader>gs", function()
  snacks.picker.git_status()
end)
vim.keymap.set("n", "<leader>gc", function()
  snacks.picker.git_commits()
end)
vim.keymap.set("n", "<leader>n", function()
  snacks.picker.notifications()
end)

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true })

vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dn", dap.step_over, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>do", dap.step_out, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dR", dap.run_last, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ca", actions.code_actions)
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

vim.keymap.set({ "i", "s" }, "<C-e>", function()
  ls.expand_or_jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function()
  ls.jump(-1)
end, { silent = true })
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

for i = 1, 8 do
  vim.keymap.set({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end
