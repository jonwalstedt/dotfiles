local buf_nmap = U.keymap.buf_nmap
local function lua_nmap(lhs, rhs, opts)
  buf_nmap(lhs, '<cmd>lua  ' .. rhs .. '<CR>', opts)
end

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" }
}

local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " "
}

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Prettier
local format_options_prettier = {
  tabWidth = 2,
  useTabs = false,
  singleQuote = true,
  trailingComma = "all",
  configPrecedence = "prefer-file"
}

vim.g.format_options_typescript = format_options_prettier
vim.g.format_options_javascript = format_options_prettier
vim.g.format_options_typescriptreact = format_options_prettier
vim.g.format_options_javascriptreact = format_options_prettier
vim.g.format_options_json = format_options_prettier
vim.g.format_options_css = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_markdown = format_options_prettier

FormatToggle = function(value)
  vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end

U.command('FormatDisable', 'lua FormatToggle(true)')
U.command('FormatEnable', 'lua FormatToggle(false)')

_G.formatting = function()
  if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
    vim.lsp.buf.formatting(
      vim.g[string.format(
        "format_options_%s", vim.bo.filetype
      )] or {}
    )
  end
end

-- All of these are buffer mappings
local function mappings()
  -- GOTO mappings
  lua_nmap('gD', 'vim.lsp.buf.declaration()')
  lua_nmap('gd', 'vim.lsp.buf.definition()')
  lua_nmap('K', 'require("lspsaga.hover").render_hover_doc()')
  lua_nmap('gr', 'vim.lsp.buf.references()')
  lua_nmap('<space>gh', 'vim.lsp.buf.signature_help()')
  lua_nmap('gi', 'vim.lsp.buf.implementation()')
  -- ACTION mappings
  lua_nmap('<leader>af', 'vim.lsp.buf.code_action()')
  lua_nmap('<leader>ar', 'require("lspsaga.rename").rename()')
  -- lua_map('<leader>ar',  'vim.lsp.buf.rename()')
  -- Few language severs support these three
  lua_nmap('<leader>=', 'vim.lsp.buf.formatting()')
  lua_nmap('<leader>ai', 'vim.lsp.buf.incoming_calls()')
  lua_nmap('<leader>ao', 'vim.lsp.buf.outgoing_calls()')

  -- Diagnostics mapping
  lua_nmap('<leader>ed', 'vim.lsp.diagnostic.show_line_diagnostics()')
  lua_nmap('<leader>en', 'vim.lsp.diagnostic.goto_next()')
  lua_nmap('<leader>ep', 'vim.lsp.diagnostic.goto_prev()')
end

return function(client)
  print("LSP started.");
  -- vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
  mappings()

  -- if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end

  -- if client.name == 'typescript' then require('nvim-lsp-ts-utils').setup {} end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = border }
  )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = border }
  )

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end
end
