local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader><space>", ":noh<CR>", { desc = "Clear search highlights", noremap = true, silent = true })
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file", noremap = true, silent = true })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit", noremap = true, silent = true })
keymap("n", "<C-h>", "<C-w>h", { desc = "Window left", noremap = true, silent = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Window down", noremap = true, silent = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Window up", noremap = true, silent = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Window right", noremap = true, silent = true })
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split", noremap = true, silent = true })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split", noremap = true, silent = true })
keymap("n", "j", "gj", { desc = "Move down (display)", noremap = true, silent = true })
keymap("n", "k", "gk", { desc = "Move up (display)", noremap = true, silent = true })
keymap("n", "Q", "<nop>", { desc = "Disable Q", noremap = true, silent = true })

keymap("n", "<leader>ff", function() require("telescope.builtin").find_files() end,
  { desc = "Find files", noremap = true, silent = true })
keymap("n", "<leader>fg", function() require("telescope.builtin").live_grep() end,
  { desc = "Live grep", noremap = true, silent = true })
keymap("n", "<leader>fb", function() require("telescope.builtin").buffers() end,
  { desc = "Find buffers", noremap = true, silent = true })
keymap("n", "<leader>ft", function() require("telescope.builtin").treesitter() end,
  { desc = "Find treesitter", noremap = true, silent = true })

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree", noremap = true, silent = true })
keymap("n", "<leader>=", function() require("conform").format() end,
  { desc = "Format code", noremap = true, silent = true })

local function setup_lsp_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "LSP Declaration" }))
  keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "LSP Definition" }))
  keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP Hover" }))
  keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "LSP Implementation" }))
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "LSP Signature Help" }))
  keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
    vim.tbl_extend("force", bufopts, { desc = "LSP Add Workspace Folder" }))
  keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
    vim.tbl_extend("force", bufopts, { desc = "LSP Remove Workspace Folder" }))
  keymap("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend("force", bufopts, { desc = "LSP List Workspace Folders" }))
  keymap("n", "<leader>D", vim.lsp.buf.type_definition,
    vim.tbl_extend("force", bufopts, { desc = "LSP Type Definition" }))
  keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP Rename" }))
  keymap("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "LSP References" }))
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "LSP Code Action" }))
end

_G.setup_lsp_keymaps = setup_lsp_keymaps
