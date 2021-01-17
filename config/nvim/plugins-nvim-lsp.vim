" Plugins
" Plugins {{{
" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'andymass/vim-matchup'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim', { 'on': []}
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'google/vim-searchindex'
Plug 'justinmk/vim-dirvish'
Plug 'romainl/vim-qlist'
Plug 'romainl/vim-qf'
Plug 'editorconfig/editorconfig-vim'
" Plug 'tmsvg/pear-tree'
Plug 'honza/vim-snippets'
Plug 'joaohkfaria/vim-jest-snippets'
Plug 'ryanoasis/vim-devicons'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'christianchiarulli/nvcode.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/completion-treesitter'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'

" Syntax highlight
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['ts', 'tsx'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css'] }
Plug 'jparise/vim-graphql'

" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()
"}}}

" Plugin settings
" FZF Fuzzyfinder {{{
command! -bar -bang Snippets call fzf#vim#snippets({'options': '-n ..'}, <bang>0)
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,2'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

nnoremap <silent> <C-p> :call FZFWithDevIcons()<CR>
nnoremap <silent> <leader>p :Buffers<CR>
nnoremap <silent> <leader>ff :Ag<CR>
nnoremap <silent> <leader>fc :History:<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fg :Ag <C-R><C-W><CR>
inoremap <silent> <c-space> <esc>:Snippets<CR>

imap <c-f> <plug>(fzf-complete-path)
imap <c-l> <plug>(fzf-complete-line)

" }}}
" GitGutter {{{
"disable keybindings (causes delay on mapped easymotion keys)
let g:gitgutter_map_keys = 0
hi GitGutterAddLine guifg=white guibg=springgreen4 gui=NONE
hi GitGutterChangeLine guifg=#ffffff guibg=lightseablue gui=NONE
hi GitGutterDeleteLine guifg=#ff0101 guibg=firebricks gui=NONE
hi GitGutterChangeDeleteLine guifg=#000000 guibg=#ffb733 gui=NONE

nnoremap <silent> <leader>nn :GitGutterNextHunk<CR>
nnoremap <silent> <leader>np :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>nf :GitGutterFold<CR>
nnoremap <silent> <leader>nq :GitGutterQuickFix<CR>
" }}}
" Vim Fugitive {{{
function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    Gstatus
  endif
endfunction

command! ToggleGStatus :call ToggleGStatus()

" Fugitive (toggle git status panel)
nnoremap <silent> <localleader><space> :call ToggleGStatus()<cr>
nnoremap <leader>fv :Gvdiff<CR>
nnoremap <leader>fl :Glog -10 -- %<CR>
"}}}
" gv.vim  {{{
command! GV call plug#load('vim-fugitive', 'gv.vim') | GV
"}}}
" Dirvish  {{{
let g:dirvish_mode = ':sort ,^.*[\/],'

augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish silent! unmap <buffer> <C-n>
augroup END

nmap <leader>f<CR> Z!
" }}}
" Sneak {{{
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S

" visual-mode
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S

" operator-pending-mode
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S
"}}}
"EasyMotion {{{
"Disable default mappings
let g:EasyMotion_do_mapping = 0

"Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"keep cursor column when JK motion
let g:EasyMotion_startofline = 0

"Use upper target labels and type as a lower case
"let g:EasyMotion_use_upper = 1

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwy'

"JK motions: Line motions
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
" }}}
" nvim-lsp {{{
lua require('init')
" Display LSP diagnostics to statusline

function! LSP_StatusLine() abort
    " let l:diagnostics = luaeval("require('lsp-status').diagnostics()")
    let l:diagnostics = { 'errors': 0, 'warnings': 0 }
    let l:errors = l:diagnostics.errors
    let l:warnings = l:diagnostics.warnings

    if l:errors > 0 || l:warnings > 0
        return printf('LSP %d 🔴 %d 🟡', l:errors, l:warnings)
    endif

    return ''
endfunction

" Register LSP keys
function! LSP_RegisterKeys()
    nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <leader>a<leader> <cmd>lua vim.lsp.diagnostic.code_action()<CR>
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gt <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <leader>lf <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <leader>lr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <leader>lh <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <leader>le <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    nnoremap <silent> [c <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> ]c <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
endfunction

function! ToggleConceal()
    if &conceallevel == 0
        set conceallevel=2
    elseif &conceallevel == 2
        set conceallevel=0
    endif
endfunction

" if GetNVimVersion() != "0.4.3"
" lua <<EOF
" local lspconfig = require 'lspconfig'
" lspconfig.tsserver.setup({config})
" EOF

set omnifunc=lsp#omnifunc
" nnoremap <silent>gD    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent>gt    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent><gd> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent><c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent>1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" endif
"}}}
" treesitter {{{
if GetNVimVersion() != "0.4.3"
lua <<EOF
local status, nvim_ts = pcall(require, 'nvim-treesitter.configs')
if (status) then
  nvim_ts.setup {
    ensure_installed = 'all',
    highlight = {
      enable = true,
    },
  }
end
EOF
endif
"}}}
" completion-nvim {{{
" Use completion-nvim in every buffer
if GetNVimVersion() != "0.4.3"
autocmd BufEnter * lua require'completion'.on_attach()
 let g:completion_enable_auto_popup = 1
let g:completion_auto_change_source = 0
let g:completion_enable_auto_hover = 1
" Set completeopt to have a better completion experience
" set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" completion-nvim

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif
" }}}
" lsp-diagnostics {{{
" diagnostic-nvim
lua require'lspconfig'.pyls.setup{on_attach=require'diagnostic'.on_attach}
let g:diagnostic_virtual_text_prefix = ' '
let g:diagnostic_trimmed_virtual_text = '20'
let g:space_before_virtual_text = 5
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_show_sign = 0
" }}}
" lsputils {{{
lua <<EOF
vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF
"}}}
