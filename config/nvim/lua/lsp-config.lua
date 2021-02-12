local lsp = require'lspconfig'

-- Utility servers
local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

-- For snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- configuring diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

-- Customize diagnostics signs
local function set_sign(type, icon)
  local sign = string.format("LspDiagnosticsSign%s", type)
  local texthl = string.format("LspDiagnosticsDefault%s", type)
  vim.fn.sign_define(sign, {text = icon, texthl = texthl})
end

set_sign("Hint", "")
set_sign("Information", "")
set_sign("Warning", "")
set_sign("Error", "ﰸ")

-- Customize diagnostics highlights
local function set_highlight(type, color)
  vim.cmd(string.format("highlight! LspDiagnosticsDefault%s guifg=%s", type, color))
end

local colors = require 'lua-helpers/colors'
local palette = colors.palette

set_highlight("Hint", palette.green)
set_highlight("Information", palette.cyan)
set_highlight("Warning", palette.yellow)
set_highlight("Error", palette.red)

-- configuring LSP servers
local on_attach_common = function(_)
    print("LSP started.");

    -- GOTO mappings
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    -- ACTION mappings
    map('n','<leader>ah',  '<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ar',  '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- Few language severs support these three
    map('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
    -- Diagnostics mapping
    map('n','<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    map('n','<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    map('n','<leader>ep', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

end

-- JSON
lsp.jsonls.setup{on_attach=on_attach_common}

-- Typescript
lsp.tsserver.setup{
  on_attach=on_attach_common,
  capabilities = capabilities,
}

-- HTML
lsp.html.setup{
    on_attach=on_attach_common,
    capabilities = capabilities,
}

-- CSS
lsp.cssls.setup{
    on_attach=on_attach_common,
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

-- EFM
local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

lsp.efm.setup{
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    set_lsp_config(client)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}



-- Lua language server
-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
-- elseif vim.fn.has('win32') == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end
-- 
-- local sumneko_root_path = '/Users/jonwalstedt/repos/language-servers/lua/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
-- lsp.sumneko_lua.setup({
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--     settings = {
--         Lua = {
--             diagnostics = {
--                 enable = true,
--                 globals = { "vim" },
--             },
--         }
--     },
-- 
--     on_attach = on_attach_common
-- })

-- Diagnostic LSP
local eslint = require('./linters/eslint')
local prettier = require('./formatters/prettier')
local prettier_standard = require('./formatters/prettier-standard')
lsp.diagnosticls.setup {
    on_attach = on_attach_common,
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    init_options = {
        filetypes = {
            javascript = 'eslint',
            javascriptreact = 'eslint',
            typescript = 'eslint',
            typescriptreact = 'eslint',
        },
        formatFiletypes = {
            javascript = 'prettier',
            javascriptreact = 'prettier',
            typescript = 'prettier',
            typescriptreact = 'prettier',
            typescriptreact = 'prettier',
        },
        linters = {
            eslint = eslint,
        },
        formatters = {
            prettier = prettier,
            prettier_standard = prettier_standard,
        },
    },
}

-- nvim-lsputils configuration
vim.g.lsp_utils_location_opts = {
    height = 24,
    mode = 'split',
    list = {
        border = true,
        numbering = true
    },
    preview = {
        title = 'Location Preview',
        border = true,
    },
}


vim.g.lsp_utils_symbols_opts = {
    height = 24,
    mode = 'editor',
    list = {
        border = true,
        numbering = false,
    },
    preview = {
        title = 'Symbols Preview',
        border = true,
    },
    prompt = {}
}
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler



vim.g.diagnostic_enable_virtual_text = 1

local function lsp_reload(buffer)
    vim.lsp.stop_client(vim.lsp.get_active_clients(buffer))
    vim.cmd("edit")
end

local function lsp_stop(buffer)
    vim.lsp.diagnostic.clear(buffer)
    vim.lsp.stop_client(vim.lsp.get_active_clients(buffer))
end

return{
    lsp_reload = lsp_reload,
    lsp_stop = lsp_stop
}


