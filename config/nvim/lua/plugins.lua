local function plug(t)
  vim.cmd[[call plug#begin('~/.local/share/nvim/plugged')]]
  for _,v in ipairs(t) do
    vim.cmd(string.format([[Plug '%s']], v))
  end
  vim.cmd[[call plug#end()]]
end

plug {
  'junegunn/fzf',
  'junegunn/fzf.vim',
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
  'SirVer/ultisnips',
  'honza/vim-snippets',
  'joaohkfaria/vim-jest-snippets',

  -- NVIM LSP
  'RishabhRD/nvim-lsputils',
  'RishabhRD/popfix',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-compe',
  'nvim-treesitter/nvim-treesitter',

  -- Language
  'HerringtonDarkholme/yats.vim',
  'hail2u/vim-css3-syntax',
  'jparise/vim-graphql',

  -- Colorschemes
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

local colors = require 'lua-helpers/colors'
local highlight = colors.highlight


-- FZF
-- vim.g.fzf_layout = { 'window': 'call CustomFZF#Float()' }
nmap('<C-p>', ':call CustomFZF#WithDevIcons()<CR>')
nmap('<leader>p', ':Buffers<CR>')
nmap('<leader>ff', ':Ag<CR>')
nmap('<leader>hh', ':History:<CR>')
nmap('<leader>fl', ':BLines<CR>')
nmap('<leader>fh', ':History<CR>')
nmap('<leader>fg', ':Ag <C-R><C-W><CR>')
nmap('<leader>fd', ':BD<CR>')

imap('<C-f>', '<Plug>(fzf-complete-path)', {})
imap('<C-l>', '<Plug>(fzf-complete-line)', {})


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
nmap('<localleader>v', ':Gvdiffsplit<CR>')
nmap('<localleader>l', ':Glog -10 -- %<CR>')


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
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        path = {
            priority = 9
        },
        buffer = {
            priority = 8
        },
        vsnip = {
            priority = 9
        },
        nvim_lsp = {
            priority = 10,
            sort = false
        },
        calc = true,
        nvim_lua = true,
        spell = true,
        tags = true,
        snippets_nvim = true,
        treesitter = true,
    };
}

