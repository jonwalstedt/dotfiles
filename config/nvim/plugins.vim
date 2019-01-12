" Plugins
call plug#begin('~/.nvim/plugged')
" Interface {{{
" FZF Fuzzyfinder {{{
Plug 'junegunn/fzf', { 'dir': $XDG_DATA_HOME . '/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <C-p> :FZF<cr>
nnoremap <C-t> :Buffers<cr>
nnoremap <C-s> :Ag<cr>
nnoremap <localleader>p :History:<cr>
" }}}
" GitGutter {{{
Plug 'airblade/vim-gitgutter'
"disable keybindings (causes delay on mapped easymotion keys)
let g:gitgutter_map_keys = 0
hi GitGutterAddLine guifg=white guibg=springgreen4 gui=NONE
hi GitGutterChangeLine guifg=#ffffff guibg=lightseablue gui=NONE
hi GitGutterDeleteLine guifg=#ff0101 guibg=firebricks gui=NONE
hi GitGutterChangeDeleteLine guifg=#000000 guibg=#ffb733 gui=NONE
" }}}
" NERDTree {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" enable line numbers
let NERDTreeShowLineNumbers=1
let loaded_netrwPlugin=1
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.map$[[file]]']
let g:NERDTreeNodeDelimiter = "\u00a0"
"Toggle NERDTree
map <C-b> :NERDTreeToggle<CR>

"Show current file in nerdtree
map <leader>r :NERDTreeFind<cr>
" }}}
" Ale {{{
Plug 'w0rp/ale'
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['tslint', 'prettier'],
\   'css': ['prettier'],
\}
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
" }}}
" BufSurf (navigate file history) {{{
Plug 'ton/vim-bufsurf'
nnoremap <leader>f :BufSurfBack<CR>
nnoremap <leader>j :BufSurfForward<CR>
" }}}
" Vim-Commited {{{
Plug 'ChrisPenner/vim-committed'
let g:committed_min_time_threshold = 10
let g:committed_lines_threshold = 15
"}}}
"}}}
Plug 'kana/vim-submode'
Plug 'Konfekt/FastFold'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'vim-scripts/auto-pairs-gentle'
" Git  {{{
" Vim Fugitive {{{
Plug 'tpope/vim-fugitive'
function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    Gstatus
  endif
endfunction
command ToggleGStatus :call ToggleGStatus()
"}}}
" Twiggy  {{{
" https://vimawesome.com/plugin/twiggy
Plug 'sodapopcan/vim-twiggy'
function! ToggleTwiggy()
  if buflisted(bufname('.git/index'))
    bd .git/branches
  else
    Twiggy
  endif
endfunction
command ToggleTwiggy :call ToggleTwiggy()
"}}}
" gv.vim  {{{
Plug 'junegunn/gv.vim'
"}}}
"}}}
"}}}
" Completion {{{
" Supertab {{{
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" Neosnippet / not used for now but is probably faster than utltisnps {{{
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"      \ "\<Plug>(neosnippet_expand_or_jump)"
"      \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"      \ "\<Plug>(neosnippet_expand_or_jump)"
"      \: "\<TAB>"
" }}}
" Ultisnips {{{
Plug 'sirver/ultisnips'

let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/ultisnips'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/ultisnips']
"}}}
" Tern {{{
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
let g:tern#command = ['tern']
" }}}
" Deoplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

let g:deoplete#sources = {}
let g:deoplete#sources['javascript.js'] = ['buffer', 'file', 'ultisnips', 'ternjs']
let g:deoplete#sources['javascript.jsx'] = ['buffer', 'file', 'ultisnips', 'ternjs']

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
"}}}
" }}}
" Motions / Search {{{
"EasyMotion {{{
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
"Disable default mappings
let g:EasyMotion_do_mapping = 0

"Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"keep cursor column when JK motion
let g:EasyMotion_startofline = 0

"Use upper target labels and type as a lower case
"let g:EasyMotion_use_upper = 1

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwy'

" Fuzzy search with easy motion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <localleader>/ incsearch#go(<SID>config_easyfuzzymotion())

nmap <leader>w <Plug>(easymotion-overwin-w)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
"map <Leader><space> <Plug>(easymotion-bd-f)
nmap <space> <Plug>(easymotion-overwin-f2)
omap <space> <plug>(easymotion-bd-f2)
vmap <space> <plug>(easymotion-bd-f2)

nmap <Leader><space> <plug>(easymotion-bd-f)
omap <Leader><space> <plug>(easymotion-bd-f)
vmap <Leader><space> <plug>(easymotion-bd-f)

nmap <C-space> <plug>(easymotion-bd-t2)
omap <C-space> <plug>(easymotion-bd-t2)
vmap <C-space> <plug>(easymotion-bd-t2)

"JKLH motions: Line motions
map <localleader>l <Plug>(easymotion-lineforward)
map <localleader>j <Plug>(easymotion-j)
map <localleader>k <Plug>(easymotion-k)
map <localleader>h <Plug>(easymotion-linebackward)

" }}}
" Sneak {{{
Plug 'justinmk/vim-sneak'
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
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'

Plug 'bronson/vim-visual-star-search'
Plug 'vim-scripts/ExtractMatches'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/PatternsOnText'
" }}}
" Language / Syntax / Themes {{{
" Themes {{{
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
let ayucolor="dark"
"}}}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'jonwalstedt/minimalgrey'
Plug 'ujihisa/neco-look'
Plug 'mustache/vim-mustache-handlebars'
" }}}
" Help {{{
Plug 'jonwalstedt/vim-myhelp'
" }}}
call plug#end()

colorscheme onedark

call submode#enter_with('grow/shrink', 'n', '', '<leader>0', ':exe "vertical resize +15"<cr>')
call submode#enter_with('grow/shrink', 'n', '', '<leader>9', ':exe "vertical resize -15"<cr>')
call submode#map('grow/shrink', 'n', '', '0', ':exe "vertical resize +15"<cr>')
call submode#map('grow/shrink', 'n', '', '9', ':exe "vertical resize -15"<cr>')

call submode#enter_with('gitstatus', 'n', '', '<localleader><space>', ':ToggleGStatus<cr>')
call submode#map('gitstatus', 'n', '', '<space>', ':ToggleGStatus<cr>')

call submode#enter_with('gitbranches', 'n', '', '<localleader>b', ':ToggleTwiggy<cr>')
call submode#map('gitbranches', 'n', '', 'b', ':ToggleTwiggy<cr>')
" vim:foldmethod=marker:foldlevel=0
