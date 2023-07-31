local lspconfig = require 'lspconfig'
require 'plugin.nvim-lspconfig.handlers'
local on_attach_common = require 'plugin.nvim-lspconfig.on-attach'
local on_init_common = require 'plugin.nvim-lspconfig.on-init'
local capabilities = require 'plugin.nvim-lspconfig.capabilities'

local servers = {
  typescript_tools = require("typescript-tools").setup {
    on_attach = function(client, bufnr)
    end,
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = "insert_leave",
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
      -- specify commands exposed as code_actions
      expose_as_code_action = {},
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = "auto",
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = {},
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = false,
    },
  },
  lua_ls = require('plugin.nvim-lspconfig.server-configs.sumneko').config,
  jsonls = require('plugin.nvim-lspconfig.server-configs.jsonls').config,
  svelte = require('plugin.nvim-lspconfig.server-configs.svelte').config,
  html = { cmd = { 'vscode-html-language-server', '--stdio' } },
  cssls = {
    root_dir = lspconfig.util.root_pattern '.git',
    cmd = { 'vscode-css-language-server', '--stdio' },
  },
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
