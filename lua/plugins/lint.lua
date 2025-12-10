require("lint").linters_by_ft = {
  go = { "golangcilint" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  rust = { "clippy" },
  c = { "clang" },
  cpp = { "clang" },
  lua = { "luacheck" },
}
