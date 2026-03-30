local M = {}

function M.setup()
  -- Configure diagnostics (signs API — no deprecated sign_define)
  vim.diagnostic.config {
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = ' ',
        [vim.diagnostic.severity.WARN]  = ' ',
        [vim.diagnostic.severity.HINT]  = ' ',
        [vim.diagnostic.severity.INFO]  = ' ',
      },
    },
  }

  -- Rounded borders for hover/signature windows
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
    vim.lsp.handlers.hover(err, result, ctx, config)
  end

  vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
    config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
    vim.lsp.handlers.signature_help(err, result, ctx, config)
  end
end

return M
