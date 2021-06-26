local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local languages = require('plugin.nvim-lspconfig.format')
local on_attach = require('plugin.nvim-lspconfig.on-attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- configuring diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false, -- disable inline diagnostics
        signs = true,
        update_in_insert = false,
    }
)

local servers = {
  efm = {
    init_options = {documentFormatting = true, codeAction = true},
    root_dir = lspconfig.util.root_pattern({'.git/', '.'}),
    filetypes = vim.tbl_keys(languages),
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
  },
  lua = {
    settings = {
      Lua = {
        diagnostics = {globals = {'vim', 'packer_plugins'}},
        completion = {keywordSnippet = 'Both'},
        runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
        workspace = {library = vim.list_extend({[vim.fn.expand('$VIMRUNTIME/lua')] = true}, {})},
      },
    },
  }
}

local function setup_servers()
  lspinstall.setup()
  local installed = lspinstall.installed_servers()
  for _, server in pairs(installed) do
    local config = servers[server] or {root_dir = lspconfig.util.root_pattern({'.git/', '.'})}

    capabilities = capabilities
    config.on_attach = on_attach
    lspconfig[server].setup(config)
  end

  -- https://github.com/theia-ide/typescript-language-server
  lspconfig.tsserver.setup {
      capabilities = capabilities,
      on_attach = function(client)
        if client.config.flags then
          client.config.flags.allow_incremental_sync = true
        end
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
      end
  }

  -- https://github.com/golang/tools/tree/master/gopls
  lspconfig.gopls.setup {
      on_attach = function(client)
          client.resolved_capabilities.document_formatting = false
          on_attach(client)
      end
  }

  -- https://github.com/palantir/python-language-server
  lspconfig.pyls.setup {
      on_attach = on_attach,
      settings = {
          pyls = {
              plugins = {
                  pycodestyle = {
                      enabled = false,
                      ignore = {
                          "E501"
                      }
                  }
              }
          }
      }
  }

  lspconfig.pyright.setup {on_attach = on_attach}

  -- https://github.com/iamcco/vim-language-server
  lspconfig.vimls.setup {on_attach = on_attach}

  -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
  lspconfig.dockerls.setup {on_attach = on_attach}

  -- https://github.com/hashicorp/terraform-ls
  lspconfig.terraformls.setup {
      on_attach = on_attach,
      cmd = {"terraform-ls", "serve"},
      filetypes = {"tf"}
  }

  -- CSS
  -- https://github.com/vscode-langservers/vscode-css-languageserver-bin
  lspconfig.cssls.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "html-languageserver", "--stdio" },
      filetypes = { "html" },
      init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
              css = true,
              javascript = true
          }
      },
      settings = {},
  }


end

setup_servers()
