local M = {}

M.setup = function()
  local null_ls = require 'null-ls'
  local b = null_ls.builtins

  vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath 'config' .. '/.prettierrc'

  null_ls.setup {
    debounce = 150,
    autostart = true,
    sources = {
      b.formatting.stylua.with {
        args = {
          '--config-path',
          vim.fn.stdpath 'config' .. '/stylua.toml',
          '-',
        },
      },
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettierd,
      b.formatting.trim_whitespace.with {
        filetypes = { 'plantuml' },
      },
      b.formatting.stylua,
      b.diagnostics.selene.with {
        name = 'selene',
      },
      b.diagnostics.shellcheck,
      b.code_actions.shellcheck,
      b.formatting.shfmt,
      b.diagnostics.hadolint,
      b.diagnostics.markdownlint,
      b.diagnostics.write_good,
      b.diagnostics.misspell,
      b.formatting.gofumpt,
    },
  }
end

return M
