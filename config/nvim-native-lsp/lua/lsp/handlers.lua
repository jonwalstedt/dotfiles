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
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
  )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
  )
end

return M
