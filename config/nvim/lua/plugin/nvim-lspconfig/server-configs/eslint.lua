local lspconfig = require 'lspconfig'
local on_attach = require 'plugin.nvim-lspconfig.on-attach'
local on_init = require 'plugin.nvim-lspconfig.on-init'

local M = {}

M.config = {
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = true
    on_attach(client)
  end,
  on_init = on_init,
  filetypes = {},
  settings = {},
}

return M
