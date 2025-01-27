local lspconfig = require 'lspconfig'
require 'plugin.nvim-lspconfig.handlers'
local on_attach_common = require 'plugin.nvim-lspconfig.on-attach'
local on_init_common = require 'plugin.nvim-lspconfig.on-init'
local capabilities = require 'plugin.nvim-lspconfig.capabilities'

local servers = {
  ltex = {
    on_init = on_init_common,
    on_attach = on_attach_common,
    cmd = { 'ltex-ls' },
    filetypes = {
      'bib',
      'gitcommit',
      'markdown',
      'org',
      'plaintex',
      'rst',
      'rnoweb',
      'tex',
      'pandoc',
      'quarto',
      'rmd',
      'context',
      'html',
      'xhtml',
      'mail',
      'text',
      'asciidoc',
      'md',
    },
    settings = {
      language = 'en-US',
      flags = { debounce_text_changes = 300 },
    },
  },
  eslint = lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
      on_attach_common(client)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })
    end,
  },
  biome = lspconfig.biome.setup {},
  ts_ls = lspconfig.ts_ls.setup {
    -- cmd = {
    --   'typescript-language-server',
    --   '--stdio',
    --   '--max-old-space-size=8192',
    -- },
    -- cmd = {
    --   'node',
    --   '--max-old-space-size=8192',
    --   '~/.local/share/fnm/node-versions/v22.6.0/installation/lib/node_modules/typescript-language-server/lib/cli.mjs',
    -- },
    on_attach = function(client, bufnr)
      on_attach_common(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        client.server_capabilities.documentFormattingProvider = false
      end
    end,
    flags = { debounce_text_changes = 150 },
    on_init = on_init_common,
    capabilities = capabilities,
    root_dir = require('lspconfig/util').root_pattern(
      'turbo.json',
      'tsconfig.json',
      'package.json',
      '.git'
    ),
  },
  lua_ls = lspconfig.lua_ls.setup {
    on_attach = on_attach_common,
    on_init = on_init_common,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  jsonls = require('lspconfig').jsonls.setup {
    capabilities = capabilities,
  },
  svelte = {
    on_attach = function(client)
      on_attach_common(client)
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
    on_init = on_init_common,
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
  },
  stylelint = require('lspconfig').stylelint_lsp.setup {
    on_attach = on_attach_common,
    on_init = on_init_common,
    filetypes = { 'css', 'less', 'scss', 'sugarss', 'vue', 'wxss' },
  },
  html = { cmd = { 'vscode-html-language-server', '--stdio' } },
  cssls = {
    root_dir = lspconfig.util.root_pattern '.git',
    cmd = { 'vscode-css-language-server', '--stdio' },
  },
  intelephense = {},
  omnisharp = {
    cmd = {
      'omnisharp',
      '--languageserver',
      '--hostPID',
      tostring(vim.fn.getpid()),
    },
  },
  clangd = {},
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
  lspconfig[name].setup(vim.tbl_extend('force', {
    flags = { debounce_text_changes = 150 },
    on_attach = on_attach_common,
    on_init = on_init_common,
    capabilities = capabilities,
  }, opts))
end

require('plugin.null-ls').setup()
