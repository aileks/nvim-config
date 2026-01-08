return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
     formatters_by_ft = {
       c = { "clang-format" },
       cpp = { "clang-format" },
       json = { "prettier" },
       yaml = { "prettier" },
       markdown = { "prettier" },
       html = { "prettier" },
       css = { "prettier" },
       lua = { "stylua" },
       sh = { "shfmt" },
       bash = { "shfmt" },
       zsh = { "shfmt" },
       zig = { "zigfmt" },
     },
     formatters = {
       stylua = {
         prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
       },
       prettier = {
         prepend_args = { "--tab-width", "2" },
       },
       shfmt = {
         prepend_args = { "--indent", "2" },
       },
       ["clang-format"] = {
         prepend_args = { "--style=file" },
       },
       zigfmt = {
         command = "zig",
         args = { "fmt", "--stdin" },
         stdin = true,
         condition = function()
           return vim.fn.executable("zig") == 1
         end,
       },
     },
     format_on_save = {
       timeout_ms = 500,
       lsp_format = "fallback",
     },
     notify_on_error = true,
     notify_no_formatters = true,
   },
}
