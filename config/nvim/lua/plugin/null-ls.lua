local M = {}

M.setup = function()
  local null_ls = require 'null-ls'
  local b = null_ls.builtins

  vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath 'config' .. '/.prettierrc'

  -- you don't have to use these helpers and could do it yourself, too
  local eslint = require('null-ls.helpers').conditional(function(utils)
    local project_local_bin = 'node_modules/.bin/eslint'

    return null_ls.builtins.diagnostics.eslint.with {
      command = utils.root_has_file(project_local_bin) and project_local_bin
        or 'eslint_d',
    }
  end)

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
      eslint,
      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.code_actions.eslint,
      -- null_ls.builtins.formatting.prettier,

      b.formatting.prettier.with {
        prefer_local = 'node_modules/.bin',
        filetypes = {
          'typescriptreact',
          'typescript',
          'javascriptreact',
          'javascript',
          'svelte',
          'json',
          'jsonc',
          'css',
          'less',
          'scss',
          'html',
          'yaml',
        },
      },
      b.formatting.trim_whitespace.with({
        filetypes = { "plantuml" },
      }),
      b.formatting.stylua,
      b.diagnostics.selene.with({
        name = "selene",
      }),
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
