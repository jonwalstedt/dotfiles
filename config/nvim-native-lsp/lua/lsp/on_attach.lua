local format_group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })

return function(client, bufnr)
  local function map(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Navigation
  map('gD', vim.lsp.buf.declaration, 'LSP declaration')
  map('gd', vim.lsp.buf.definition, 'LSP definition')
  map('K', vim.lsp.buf.hover, 'LSP hover')
  map('gr', vim.lsp.buf.references, 'LSP references')
  map('<space>gh', vim.lsp.buf.signature_help, 'LSP signature help')
  map('gi', vim.lsp.buf.implementation, 'LSP implementation')

  -- Actions
  map('<leader>af', vim.lsp.buf.code_action, 'LSP code action')
  map('<leader>ar', vim.lsp.buf.rename, 'LSP rename')
  map('<leader>ai', vim.lsp.buf.incoming_calls, 'LSP incoming calls')
  map('<leader>ao', vim.lsp.buf.outgoing_calls, 'LSP outgoing calls')

  -- Diagnostics
  map('<leader>ed', vim.diagnostic.open_float, 'Show diagnostics')
  map('<leader>en', vim.diagnostic.goto_next, 'Next diagnostic')
  map('<leader>ep', vim.diagnostic.goto_prev, 'Prev diagnostic')

  -- Format on save: prefer null-ls when attached, fall back to this client
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = format_group })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = format_group,
      callback = function()
        local null_ls = vim.lsp.get_clients({ bufnr = bufnr, name = 'null-ls' })
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 2000,
          bufnr = bufnr,
          filter = #null_ls > 0 and function(c) return c.name == 'null-ls' end or nil,
        })
      end,
    })
  end
end
