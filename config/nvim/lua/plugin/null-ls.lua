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

  null_ls.config {
    debounce = 150,
    autostart = true,
    sources = {
      eslint,
      b.formatting.stylua.with {
        args = {
          '--config-path',
          vim.fn.stdpath 'config' .. '/stylua.toml',
          '-',
        },
      },
      b.formatting.prettierd.with {
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
    },
  }
end

return M
