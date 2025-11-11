local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local format_group = augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  callback = function(args)
    local conform = require("conform")
    if conform then
      conform.format({ bufnr = args.buf })
    end
  end,
  group = format_group,
  pattern = "*",
})
