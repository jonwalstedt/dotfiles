" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

packadd! matchit

" Plugins
call plug#begin('~/.nvim/plugged')
" FZF Fuzzyfinder {{{
Plug 'junegunn/fzf', { 'dir': $XDG_DATA_HOME . '/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
command! -bar -bang Snippets call fzf#vim#snippets({'options': '-n ..'}, <bang>0)
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <C-p> :FZF<cr>
nnoremap <C-t> :Buffers<cr>
nnoremap <C-s> :Ag<cr>
inoremap <C-space> <esc>:Snippets<cr>
nnoremap <localleader>p :History:<cr>
" }}}
" Ale {{{
Plug 'w0rp/ale'
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['tslint', 'prettier'],
\   'css': ['prettier'],
\}

let g:ale_pattern_options = {
\ '.css$': {'ale_linters': [], 'ale_fixers': []},
\}

let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
" }}}
" NNN {{{
Plug 'mcchrish/nnn.vim'

let $NNN_USE_EDITOR=1
let $NNN_SHOW_HIDDEN=1
let $DISABLE_FILE_OPEN_ON_NAV=1

nnoremap <leader>h :NnnPicker '%:p:h'<CR>
nnoremap - :NnnPicker '%:p:h'<CR>
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
" }}}
" Vaffle {{{
" Plug 'cocopon/vaffle.vim'
" let g:vaffle_use_default_mappings=0
" let g:vaffle_show_hidden_files=1
" let g:vaffle_force_delete=1
"
" function! s:customize_vaffle_mappings() abort
"   " Keep netrw keybindings
"   nmap <silent> + :ProjectRootExe Vaffle<cr>
"   nmap <silent> <buffer> - <Plug>(vaffle-open-parent)
"
"   nmap <silent> <buffer> <CR> <Plug>(vaffle-open-current)
"
"   nmap <silent> <buffer> * <Plug>(vaffle-toggle-all)
"   nmap <silent> <buffer> . <Plug>(vaffle-toggle-hidden)
"   nmap <silent> <buffer> <C-space> <Plug>(vaffle-toggle-current)
"   vmap <silent> <buffer> <C-space> <Plug>(vaffle-toggle-current)
"
"   nmap <silent> <buffer> D <Plug>(vaffle-delete-selected)
"   nmap <silent> <buffer> R <Plug>(vaffle-rename-selected)
"   nmap <silent> <buffer> m <Plug>(vaffle-move-selected)
"   nmap <silent> <buffer> v <Plug>(vaffle-open-selected-vsplit)
"
"   nmap <silent> <buffer> <leader>r <Plug>(vaffle-refresh)
"
"   nmap <silent> <buffer> d <Plug>(vaffle-mkdir)
"   nmap <silent> <buffer> % <Plug>(vaffle-new-file)
"   nmap <silent> <buffer> x <Plug>(vaffle-fill-cmdline)
"
"   nmap <silent> <buffer> q <Plug>(vaffle-quit)
"   nmap <silent> <buffer> <BS> <Plug>(vaffle-quit)
" endfunction
"
" augroup vimrc_vaffle
"   autocmd!
"   autocmd FileType vaffle call s:customize_vaffle_mappings()
" augroup END
"
" nnoremap <silent> - :Vaffle %:h<CR>

"}}}
" Submode {{{
Plug 'kana/vim-submode'
let g:submode_timeout = 0                           " Disable submode timeouts:
let g:submode_keep_leaving_key = 1                  " Don't consume submode-leaving key
" }}}
Plug 'ton/vim-bufsurf'
Plug 'dbakker/vim-projectroot'
Plug 'Konfekt/FastFold'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'

" Gutentags {{{
Plug 'ludovicchabant/vim-gutentags'
" Gutentags throws errors when saving git commit messages, as a workaround
" gutentags is disabled.
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
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
" Vim-Commited {{{
"Plug 'ChrisPenner/vim-committed'
"let g:committed_min_time_threshold = 10
"let g:committed_lines_threshold = 15
"}}}
" Supertab {{{
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" Ultisnips {{{
Plug 'sirver/ultisnips'

let g:UltiSnipsExpandTrigger = '<Tab>'
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
let g:deoplete#sources['javascript.js'] = ['ultisnips', 'buffer', 'file', 'ternjs']
let g:deoplete#sources['javascript.jsx'] = ['ultisnips', 'buffer', 'file', 'ternjs']

"}}}
" Emmet {{{
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'jsx',
\  },
\}
" }}}
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

Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'jonwalstedt/minimalgrey'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'mustache/vim-mustache-handlebars'
Plug 'hail2u/vim-css3-syntax'
" Help {{{
Plug 'jonwalstedt/vim-myhelp'
" }}}
call plug#end()

call deoplete#custom#option('ignore_sources', {'_': ['tag']})
colorscheme onedark

" Sumodes
" Resize splits
call submode#enter_with('grow/shrink', 'n', '', '<leader>0', ':exe "vertical resize +15"<cr>')
call submode#enter_with('grow/shrink', 'n', '', '<leader>9', ':exe "vertical resize -15"<cr>')
call submode#map('grow/shrink', 'n', '', '0', ':exe "vertical resize +15"<cr>')
call submode#map('grow/shrink', 'n', '', '9', ':exe "vertical resize -15"<cr>')

" Fugitive (toggle git status panel)
call submode#enter_with('gitstatus', 'n', '', '<localleader><space>', ':ToggleGStatus<cr>')
call submode#map('gitstatus', 'n', '', '<space>', ':ToggleGStatus<cr>')

" Twiggy (toggle twiggy panel)
call submode#enter_with('gitbranches', 'n', '', '<localleader>b', ':ToggleTwiggy<cr>')
call submode#map('gitbranches', 'n', '', 'b', ':ToggleTwiggy<cr>')

" BufSurf
call submode#enter_with('bufsurff', 'n', '', '<leader>j', ':BufSurfForward<cr>')
call submode#map('bufsurff', 'n', '', 'j', ':BufSurfForward<cr>')
call submode#enter_with('bufsurfback', 'n', '', '<leader>f', ':BufSurfBack<cr>')
call submode#map('bufsurfback', 'n', '', 'f', ':BufSurfBack<cr>')

" vim:foldmethod=marker:foldlevel=0
