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

  -- local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
  local prettier_root_files =
    { '.prettierrc', '.prettierrc.js', '.prettierrc.json' }
  local stylua_root_files = { 'stylua.toml', '.stylua.toml' }
  local elm_root_files = { 'elm.json' }

  local opts = {
    -- eslint_formatting = {
    --   condition = function(utils)
    --     local has_eslint = root_has_file(eslint_root_files)(utils)
    --     local has_prettier = root_has_file(prettier_root_files)(utils)
    --     return has_eslint and not has_prettier
    --   end,
    -- },
    -- eslint_diagnostics = {
    --   condition = root_has_file(eslint_root_files),
    -- },
    prettier_formatting = {
      condition = root_has_file(prettier_root_files),
    },
    stylua_formatting = {
      condition = root_has_file(stylua_root_files),
    },
    elm_format_formatting = {
      condition = root_has_file(elm_root_files),
    },
  }

  local function on_attach(client, _)
    -- if client.server_capabilities.document_formatting then
    --   vim.cmd 'command! -buffer Formatting lua vim.lsp.buf.formatting()'
    --   vim.cmd 'command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()'
    -- end

    if client.supports_method 'textDocument/formatting' then
      vim.keymap.set('n', '<Leader>fr', function()
        vim.lsp.buf.format { bufnr = vim.api.nvim_get_current_buf() }
      end, { buffer = bufnr, desc = '[lsp] format' })

      -- format on save
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr, async = async }
        end,
        desc = '[lsp] format on save',
      })
    end

    if client.supports_method 'textDocument/rangeFormatting' then
      vim.keymap.set('x', '<Leader>fr', function()
        vim.lsp.buf.format { bufnr = vim.api.nvim_get_current_buf() }
      end, { buffer = bufnr, desc = '[lsp] format' })
    end
  end

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
      -- null_ls.builtins.diagnostics.eslint_d.with(opts.eslint_diagnostics),
      -- null_ls.builtins.formatting.eslint_d.with(opts.eslint_formatting),
      null_ls.builtins.formatting.prettierd.with(opts.prettier_formatting),
      null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
      null_ls.builtins.formatting.elm_format.with(opts.elm_format_formatting),
      -- null_ls.builtins.code_actions.eslint_d.with(opts.eslint_diagnostics),

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
    on_attach = on_attach,
  }
end

return M
