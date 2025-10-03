local fn, lsp = vim.fn, vim.lsp
local M = {}

function M.setup()
  -- Configure diagnostics
  local signs = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  vim.diagnostic.config {
    underline = true,
    signs = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
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
