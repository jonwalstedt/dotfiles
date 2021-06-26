local buf_nmap = U.keymap.buf_nmap
local function lua_nmap(lhs, rhs, opts)
  buf_nmap(lhs, '<cmd>lua  ' .. rhs .. '<CR>', opts)
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

-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {'documentation', 'detail', 'additionalTextEdits'},
-- }


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

local palette = U.palette

set_highlight("Hint", palette.green)
set_highlight("Information", palette.cyan)
set_highlight("Warning", palette.yellow)
set_highlight("Error", palette.red)

_G.formatting = function()
    if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
        vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
    end
end

return function(client)
  -- vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  if client.resolved_capabilities.document_formatting then
    U.nvim_create_augroup({
      Format = {
        {'BufWritePost', '<buffer>', 'lua formatting()'},
      },
    })
  end

  mappings()

  if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end

  -- if client.name == 'typescript' then require('nvim-lsp-ts-utils').setup {} end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end
end
