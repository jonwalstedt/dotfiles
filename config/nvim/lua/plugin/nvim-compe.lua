-- require'compe'.setup {
--   enabled = true,
--   autocomplete = true,
--   debug = false,
--   min_length = 1,
--   preselect = 'always',
--   allow_prefix_unmatch = false,
--   source = {
--     path = true,
--     buffer = true,
--     calc = true,
--     vsnip = true,
--     nvim_lsp = true,
--     nvim_lua = true,
--     spell = true,
--     tags = true,
--     snippets_nvim = true,
--   },
-- }
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
    vsnip = { kind = '   (Snippet)', priority = 10 },
    nvim_lsp = { kind = '   (LSP)', priority = 10 },
    treesitter = { kind = "  ", priority = 8 },
    calc = { kind = '   (Calc)' },
    emoji = { kind = ' ﲃ  (Emoji)', filetypes = {'markdown', 'text'} },
    nvim_lua = false,
    tags = false,
    vim_dadbod_completion = true,
    snippets_nvim = { kind = "  " },
    -- nvim_lua = {kind = "  "},
    -- spell = {kind = '   (Spell)'},
    -- ultisnips = {kind = "  "},
    -- for emoji press : (idk if that in compe tho)
  },
}


vim.g.vsnip_snippet_dir = U.os.config.."/snippets"
vim.g.vsnip_filetypes = {
  javascriptreact = {'javascript', 'html'},
  typescriptreact = {'typescript', 'html'}
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
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
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
