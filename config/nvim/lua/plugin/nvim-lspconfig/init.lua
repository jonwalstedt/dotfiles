local lspconfig = require 'lspconfig'
require 'plugin.nvim-lspconfig.handlers'
local on_attach_common = require 'plugin.nvim-lspconfig.on-attach'
local on_init_common = require 'plugin.nvim-lspconfig.on-init'
local capabilities = require 'plugin.nvim-lspconfig.capabilities'

local servers = {
  tsserver = {
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern '.git',
    on_attach = function(client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      local ts_utils = require 'nvim-lsp-ts-utils'
      ts_utils.setup {}
      ts_utils.setup_client(client)
      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>ao',
        ':TSLspOrganize<CR>',
        opts
      )
      vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>ai',
        ':TSLspImportAll<CR>',
        opts
      )
      on_attach_common(client)
    end,
  },
  sumneko_lua = require('plugin.nvim-lspconfig.server-configs.sumneko').config,
  jsonls = require('plugin.nvim-lspconfig.server-configs.jsonls').config,
  svelte = require('plugin.nvim-lspconfig.server-configs.svelte').config,
  html = { cmd = { 'vscode-html-language-server', '--stdio' } },
  cssls = { cmd = { 'vscode-css-language-server', '--stdio' } },
  intelephense = {},
  -- fsautocomplete = {},
  omnisharp = {
    cmd = {
      'omnisharp',
      '--languageserver',
      '--hostPID',
      tostring(vim.fn.getpid()),
    },
  },
  clangd = {},
  -- wait until rust-tools.nvim adapt to new handler signature
  rust_analyzer = {},
  elmls = {},
  gopls = {
    settings = {
      gopls = {
        codelenses = {
          references = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          generate = true,
        },
        gofumpt = true,
      },
    },
  },
  vimls = {},
  dockerls = {},
  terraformls = {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'tf' },
  },
  pyright = {},
}

for name, opts in pairs(servers) do
  if type(opts) == 'function' then
    opts()
  else
    local client = lspconfig[name]
    client.setup(vim.tbl_extend('force', {
      flags = { debounce_text_changes = 150 },
      on_attach = on_attach_common,
      on_init = on_init_common,
      capabilities = capabilities,
    }, opts))
  end
end

require('plugin.null-ls').setup()
