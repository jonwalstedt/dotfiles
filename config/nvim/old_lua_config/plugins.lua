local function plug(t)
  vim.cmd[[call plug#begin('~/.local/share/nvim/plugged')]]
  for _,v in ipairs(t) do
    vim.cmd(string.format([[Plug '%s']], v))
  end
    vim.cmd([[Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}]])
  vim.cmd[[call plug#end()]]
end

plug {
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'stsewd/fzf-checkout.vim',
  'chengzeyi/fzf-preview.vim',
  'andymass/vim-matchup',
  'airblade/vim-gitgutter',
  'tpope/vim-fugitive',
  'junegunn/gv.vim',
  'justinmk/vim-sneak',
  'tpope/vim-unimpaired',
  'tpope/vim-repeat',
  'google/vim-searchindex',
  'justinmk/vim-dirvish',
  'romainl/vim-qlist',
  'romainl/vim-qf',
  'editorconfig/editorconfig-vim',
  'ryanoasis/vim-devicons',
  'sheerun/vim-polyglot',
  'hrsh7th/vim-vsnip',
  'hrsh7th/vim-vsnip-integ',
  'norcalli/snippets.nvim',

  'kyazdani42/nvim-web-devicons',
  'folke/lsp-trouble.nvim',
  -- 'SirVer/ultisnips',
  -- 'honza/vim-snippets',
  -- 'joaohkfaria/vim-jest-snippets',

  -- NVIM LSP
  'RishabhRD/nvim-lsputils',
  'RishabhRD/popfix',
  'neovim/nvim-lspconfig',
  'kabouzeid/nvim-lspinstall',
  'hrsh7th/nvim-compe',
  -- 'nvim-treesitter/nvim-treesitter',

  -- Language
  'HerringtonDarkholme/yats.vim',
  'hail2u/vim-css3-syntax',
  'jparise/vim-graphql',

  -- Colorschemes
  'christianchiarulli/nvcode-color-schemes.vim',
  'joshdick/onedark.vim',
  'haishanh/night-owl.vim',
  'christianchiarulli/nvcode-color-schemes.vim',
  'dracula/vim',
  'ryuta69/elly.vim',

  -- Misc
  'jonwalstedt/vim-myhelp'
}

local keymap = require 'lua-helpers/keymap'
local nmap = keymap.nmap
local imap = keymap.imap
local xmap = keymap.xmap
local omap = keymap.omap
local smap = keymap.smap

local colors = require 'lua-helpers/colors'
local highlight = colors.highlight


-- FZF
nmap('<C-p>', ':call CustomFZF#FilesWithDevIcons()<CR>')
nmap('<leader>p', ':FzfBuffers<CR>')
nmap('<leader>ff', ':FZFAg<CR>')
nmap('<leader>fg', ':FZFAg<CR>')
nmap('<leader>hh', ':FZFHistory:<CR>')
nmap('<leader>fl', ':FZFBLines<CR>')
nmap('<leader>fh', ':FZFHistory<CR>')
nmap('<leader>fd', ':BD<CR>')
nmap('<leader>fb', ':FzfGBranches<CR>')

imap('<C-f>', '<Plug>(fzf-complete-path)', {})
imap('<C-l>', '<Plug>(fzf-complete-line)', {})

-- fzf-checkout.vim
--  https://github.com/stsewd/fzf-checkout.vim
vim.g.fzf_command_prefix = 'Fzf'
vim.g.fzf_branch_actions = {
  diff = {
    prompt = 'Diff> ',
    execute = 'Git diff {branch}',
    multiple = false,
    keymap = 'ctrl-f',
    required = {'branch'},
    confirm = false,
  }
}


-- Git gutter
vim.g.gitgutter_map_keys = 0
highlight('GitGutterAddLine', 'white', 'springgreen4')
highlight('GitGutterChangeLine', 'white', 'lightseablue')
highlight('GitGutterDeleteLine', '#ff0101', '#ffb733')
highlight('GitGutterChangeDeleteLine', 'black', 'firebricks')

nmap('<leader>nn', ':GitGutterNextHunk<CR>')
nmap('<leader>nn', ':GitGutterNextHunk<CR>')
nmap('<leader>np', ':GitGutterPrevHunk<CR>')
nmap('<leader>nf', ':GitGutterFold<CR>')
nmap('<leader>nq', ':GitGutterQuickFix<CR>')


-- Fugitive (toggle git status panel)
nmap('<localleader><space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('§<space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('<localleader>v', ':Gdiffsplit!<CR>')
nmap('<localleader>h', ':diffget //2<CR>')
nmap('<localleader>l', ':diffget //3<CR>')
nmap('<localleader>g', ':Gclog -10 -- %<CR>')


-- Dirvish
vim.g.dirvish_mode = vim.api.nvim_replace_termcodes(':sort ,^.*[/],', true, false, true)
vim.g.loaded_netrwPlugin = 0
nmap('<leader>f<CR>', 'Z!')


-- Sneak
vim.g['sneak#s_next'] = 0
vim.g['sneak#use_ic_scs'] = 1
nmap('s', '<Plug>Sneak_s', {})
nmap('S', '<Plug>Sneak_S', {})


-- visual-mode
xmap('s', '<Plug>Sneak_s', {})
xmap('S', '<Plug>Sneak_S', {})


-- operator-pending-mode
omap('s', '<Plug>Sneak_s', {})
omap('S', '<Plug>Sneak_S', {})


-- Ultisnips
vim.g.UltiSnipsExpandTrigger = '<Nop>'
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'custom-snippets'}

--  Jump to next/previous placeholder.
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'


-- Compe
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 3,
  preselect = 'enable',
  throttle_time = 120,
  source_timeout = 200,
  incomplete_delay = 600,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = {
      menu = '[PATH]',
      priority = 9
    },
    buffer = {
      menu = '[BUF]',
      priority = 8
    },
    vsnip = {
      menu = '[SPT]',
      priority = 10
    },
    nvim_lsp = {
      menu = '[LSP]',
      priority = 10,
      sort = false
    },
    -- spell = {
    --   menu = '[SPELL]',
    --   priority = 6,
    -- },
    calc = true,
    nvim_lua = true,
    tags = true,
    snippets_nvim = true,
    treesitter = true,
  };
}

-- SET SNIPPETS PATH
vim.g.vsnip_snippet_dir = vim.fn.stdpath("config").."/snippets"
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

-- Trouble
require("trouble").setup { }
nmap('<leader>e<cr>', ':LspTroubleOpen<cr>')
