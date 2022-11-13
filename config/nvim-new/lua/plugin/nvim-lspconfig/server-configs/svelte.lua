local on_attach = require 'plugin.nvim-lspconfig.on-attach'
local on_init = require 'plugin.nvim-lspconfig.on-init'
local M = {}

M.config = {
  on_attach = function(client)
    on_attach(client)
    client.server_capabilities.completionProvider.triggerCharacters = {
      '.',
      '"',
      "'",
      '`',
      '/',
      '@',
      '*',
      '#',
      '$',
      '+',
      '^',
      '(',
      '[',
      '-',
      ':',
    }
  end,
  on_init = on_init,
  filetypes = { 'svelte' },
  settings = {
    svelte = {
      plugin = {
        html = { completions = { enable = true, emmet = false } },
        svelte = { completions = { enable = true, emmet = false } },
        css = { completions = { enable = true, emmet = true } },
      },
    },
  },
}

return M
