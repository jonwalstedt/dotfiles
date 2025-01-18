local fn, lsp = vim.fn, vim.lsp

lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
  border = U.borders,
})

lsp.handlers['textDocument/signatureHelp'] =
  lsp.with(lsp.handlers.signature_help, {
    border = U.borders,
  })

local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = '',
  })
end

vim.diagnostic.config {
  underline = true,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
  virtual_text = false,
}
