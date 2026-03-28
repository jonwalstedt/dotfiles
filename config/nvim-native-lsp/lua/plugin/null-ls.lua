local M = {}

M.setup = function()
  local null_ls = require 'null-ls'
  local b = null_ls.builtins

  vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath 'config' .. '/.prettierrc'

  local root_has_file = function(files)
    return function(utils)
      return utils.root_has_file(files)
    end
  end

  local prettier_root_files = { '.prettierrc', '.prettierrc.js', '.prettierrc.json' }
  local elm_root_files = { 'elm.json' }

  -- Manual format keymap (format on save is wired in lsp/on_attach.lua)
  local function on_attach(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<Leader>fr', function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, { buffer = bufnr, desc = '[lsp] format' })
    end

    if client.supports_method('textDocument/rangeFormatting') then
      vim.keymap.set('x', '<Leader>fr', function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, { buffer = bufnr, desc = '[lsp] format range' })
    end
  end

  null_ls.setup {
    debounce = 150,
    autostart = true,
    sources = {
      b.formatting.stylua.with {
        args = { '--config-path', vim.fn.stdpath 'config' .. '/stylua.toml', '-' },
      },
      b.formatting.prettierd.with {
        condition = root_has_file(prettier_root_files),
      },
      b.formatting.elm_format.with {
        condition = root_has_file(elm_root_files),
      },
      b.formatting.gofumpt,
      b.formatting.shfmt,
      b.diagnostics.codespell.with {
        filetypes = {
          'typescript', 'typescriptreact', 'javascript', 'javascriptreact',
          'html', 'css', 'scss', 'less', 'json', 'yaml',
          'lua', 'python', 'markdown',
        },
      },
      b.diagnostics.hadolint,
      b.diagnostics.markdownlint,
      b.diagnostics.write_good,
    },
    on_attach = on_attach,
  }
end

return M
