vim.o.completeopt = 'menuone,noselect'
local imap = U.keymap.imap
local smap = U.keymap.smap

require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 3,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = { kind = '   (Path)', priority = 9 },
    buffer = { kind = '   (Buffer)', priority = 8 },
    luasnip = { kind = '   (Snippet)', priority = 10 },
    nvim_lsp = { kind = '   (LSP)', priority = 10 },
    treesitter = { kind = "  ", priority = 8 },
    calc = { kind = '   (Calc)' },
    emoji = { kind = ' ﲃ  (Emoji)', filetypes = {'markdown', 'text'} },
    nvim_lua = false,
    tags = false,
    vim_dadbod_completion = true,
    snippets_nvim = { kind = "  " },
    -- vsnip = { kind = '   (Snippet)', priority = 10 },
    -- nvim_lua = {kind = "  "},
    -- spell = {kind = '   (Spell)'},
    -- ultisnips = {kind = "  "},
    -- for emoji press : (idk if that in compe tho)
  },
}


local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif require'luasnip'.expand_or_jumpable() then
    return t "<Plug>luasnip-expand-or-jump"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif require'luasnip'.jumpable(-1) then
    return t "<Plug>luasnip-jump-prev"
  else
    return t "<S-Tab>"
  end
end

imap("<C-Space>", "compe#complete()", {expr = true})
imap("<CR>", "compe#confirm('<CR>')", {expr = true})
imap("<C-e>", "compe#close('<C-e>')", {expr = true})
imap("<C-f>", "compe#scroll({ 'delta': +4 })", {expr = true})
imap("<C-d>", "compe#scroll({ 'delta': -4 })", {expr = true})

imap("<Tab>", "v:lua.tab_complete()", {expr = true})
imap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
smap("<Tab>", "v:lua.tab_complete()", {expr = true})
smap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
