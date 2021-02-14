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
  'neoclide/coc.nvim',
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
local smap = keymap.smap

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

-- Coc
vim.g.coc_global_extensions = {
  'coc-lists',
  'coc-json',
  'coc-tsserver',
  'coc-prettier',
  'coc-html',
  'coc-jest',
  'coc-ultisnips',
  'coc-css',
  'coc-eslint',
  'coc-go',
  'coc-actions',
  'coc-yaml',
  'coc-emmet'
}

local function check_back_space()
  local col = fn.col('.') - 1
  return col == 0 or fn.getline('.'):sub(col, col):match('%s')
end

local fn = vim.fn

imap('<TAB>', [[
  pumvisible() ? coc#_select_confirm() :
    coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    check_back_space() ? "\<TAB>" :
    coc#refresh()
]])

imap('<cr>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"', {expr = true})

vim.cmd[[augroup completion_done]]
  vim.cmd[[autocmd!]]
  vim.cmd[[autocmd CompleteDone * if pumvisible() == 0 | pclose | endif]]
vim.cmd[[augroup END]]


-- Use <c-space> for trigger completion.
imap('<C><space>', 'coc#refresh()')

-- Use `[c` and `]c` for navigate diagnostics
nmap('[c', '<Plug>(coc-diagnostic-prev)')
nmap(']c', '<Plug>(coc-diagnostic-next)')

-- Remap keys for gotos
nmap('gd', '<Plug>(coc-definition)')
nmap('<leader>ft', '<Plug>(coc-type-definition)')
nmap('<leader>fi', '<Plug>(coc-implementation)')
nmap('<leader>fr', '<Plug>(coc-references)')
nmap('<leader>rn', '<Plug>(coc-rename)')
-- Use K for show documentation in preview window
nmap('K', ':call show_documentation()<CR>')


-- Using CocList
-- Show all diagnostics
nmap('<leader>cd', ':<C-u>CocList diagnostics<cr>')
-- Show commands
nmap('<leader>cc', ':<C-u>CocList commands<cr>')
-- Search workspace symbols
nmap('<leader>cs', ':<C-u>CocList -I symbols<cr>')
-- Outline document
nmap('<leader>cp', ':<C-u>CocList outline<cr>')

-- Remap for do codeAction of selected region
local function cocActionsOpenFromSelected(type)
  vim.cmd("execute 'CocCommand actions.open '" .. type)
end

xmap('<leader>a', ":<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>")
nmap('<leader>a', ':<C-u>set operatorfunc=cocActionsOpenFromSelected<CR>g@')


-- Ultisnips
vim.g.UltiSnipsExpandTrigger = '<Nop>'
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'custom-snippets'}

--  Jump to next/previous placeholder.
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'


