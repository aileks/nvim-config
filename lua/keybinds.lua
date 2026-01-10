local map = vim.keymap.set
local snacks = require("snacks")
local dap = require("dap")
local dapui = require("dapui")
local luasnip = require("luasnip")
local conform = require("conform")
local actions_preview = require("actions-preview")

-- general
map("n", "<Esc>", ":nohl<CR>", { silent = true })
map("n", "<leader>w", ":write<CR>", { silent = true })
map("n", "<leader>q", ":quit<CR>", { silent = true })
map("n", "<leader>L", "<cmd>Lazy<CR>")
map("n", "<leader>r", function() conform.format({ async = true }) end)

-- snacks: explorer/picker
map("n", "<leader>e", function() snacks.explorer() end, { silent = true })
map("n", "<leader>f", function() snacks.picker.files() end)
map("n", "<leader>F", function() snacks.picker.grep() end)
map("n", "<leader>gw", function() snacks.picker.grep_word() end)
map("n", "]w", function() snacks.words.jump(1) end)
map("n", "[w", function() snacks.words.jump(-1) end)
map("n", "<leader>b", function() snacks.picker.buffers() end)
map("n", "<leader>x", function() snacks.picker.diagnostics() end)
map("n", "<leader>u", function() snacks.picker.undo() end)
map("n", "<leader>gb", function() snacks.picker.git_branches() end)
map("n", "<leader>gs", function() snacks.picker.git_status() end)
map("n", "<leader>gc", function() snacks.picker.git_commits() end)
map("n", "<leader>n", function() snacks.picker.notifications() end)
map("n", "<leader>sq", function() snacks.picker.qflist() end)
map("n", "<leader>z", function() snacks.zen() end)

-- snacks: lsp
map("n", "gd", function() snacks.picker.lsp_definitions() end)
map("n", "gD", function() snacks.picker.lsp_declarations() end)
map("n", "gr", function() snacks.picker.lsp_references() end)
map("n", "gI", function() snacks.picker.lsp_implementations() end)
map("n", "gy", function() snacks.picker.lsp_type_definitions() end)
map("n", "gai", function() snacks.picker.lsp_incoming_calls() end)
map("n", "gao", function() snacks.picker.lsp_outgoing_calls() end)
map("n", "<leader>ss", function() snacks.picker.lsp_symbols() end)
map("n", "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end)

-- diagnostics
map("n", "[d", function() vim.diagnostic.goto_prev({ float = true }) end)
map("n", "]d", function() vim.diagnostic.goto_next({ float = true }) end)

-- code actions
map("n", "<leader>ca", function() actions_preview.code_actions() end)

-- luasnip
map({ "i", "s" }, "<C-e>", function() luasnip.expand_or_jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() luasnip.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-K>", function() luasnip.jump(-1) end, { silent = true })

-- lsp
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }))
end)
map("n", "K", vim.lsp.buf.hover)

-- splits/nav
map("n", "<leader>sv", ":vsplit<CR>", { silent = true })
map("n", "<leader>sh", ":split<CR>", { silent = true })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- misc
map("n", "Q", "<nop>")
map("n", "j", "gj")
map("n", "k", "gk")
map("i", "jj", "<Esc>")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- dap
map("n", "<F5>", dap.continue)
map("n", "<F10>", dap.step_over)
map("n", "<F11>", dap.step_into)
map("n", "<F12>", dap.step_out)
map("n", "<leader>db", dap.toggle_breakpoint)
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
map("n", "<leader>dc", dap.continue)
map("n", "<leader>dl", dap.run_last)
map("n", "<leader>dt", dap.terminate)
map("n", "<leader>du", dapui.toggle)
map("n", "<leader>dr", dap.repl.open)
map({ "n", "v" }, "<leader>de", dapui.eval)
