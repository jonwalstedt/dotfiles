local lspconfig = require 'lspconfig'
local on_attach = require 'plugin.nvim-lspconfig.on-attach'
local on_init = require 'plugin.nvim-lspconfig.on-init'

local M = {}

M.config = {
  on_attach = on_attach,
  on_init = on_init,
  filetypes = { 'scss', 'css', 'less', 'sugarss' },
  settings = { stylelintplus = { autoFixOnSave = true } },
  root_dir = lspconfig.util.root_pattern(
    '.stylelintrc',
    '.git',
    '.stylelintrc.js'
  ),
}

return M
