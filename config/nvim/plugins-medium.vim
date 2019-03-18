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
" Submode {{{
Plug 'kana/vim-submode'
let g:submode_timeout = 0                           " Disable submode timeouts:
let g:submode_keep_leaving_key = 1                  " Don't consume submode-leaving key
" }}}
" Gutentags {{{
Plug 'ludovicchabant/vim-gutentags'
" Gutentags throws errors when saving git commit messages, as a workaround
" gutentags is disabled.
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
" }}}
" Vim Fugitive {{{
Plug 'tpope/vim-fugitive', { 'on': [] }

command! Gstatus call LazyLoadFugitive('Gstatus')
command! Gdiff call LazyLoadFugitive('Gdiff')
command! Glog call LazyLoadFugitive('Glog')
command! Gblame call LazyLoadFugitive('Gblame')

function! LazyLoadFugitive(cmd)
  call plug#load('vim-fugitive')
  call fugitive#detect(expand('%:p'))
  exe a:cmd
endfunction

function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    Gstatus
  endif
endfunction
command ToggleGStatus :call ToggleGStatus()
"}}}
" gv.vim  {{{
Plug 'junegunn/gv.vim', { 'on': []}
command! GV call plug#load('vim-fugitive', 'gv.vim') | GV
"}}}
" Supertab {{{
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" Ultisnips {{{
Plug 'sirver/ultisnips'

" let g:UltiSnipsExpandTrigger = '<Tab>'
" let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
" let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/ultisnips'
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/ultisnips']
"}}}
"EasyMotion {{{
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
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

nmap <space> <plug>(easymotion-overwin-f2)
omap <space> <plug>(easymotion-bd-f2)
vmap <space> <plug>(easymotion-bd-f2)

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
" Help {{{
Plug 'jonwalstedt/vim-myhelp'
" }}}
"
Plug 'tpope/vim-vinegar'
Plug 'ton/vim-bufsurf'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'bronson/vim-visual-star-search'

" Plug 'chriskempson/base16-vim'
Plug 'joshdick/onedark.vim'
call plug#end()

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

" BufSurf
call submode#enter_with('bufsurff', 'n', '', '<leader>j', ':BufSurfForward<cr>')
call submode#map('bufsurff', 'n', '', 'j', ':BufSurfForward<cr>')
call submode#enter_with('bufsurfback', 'n', '', '<leader>f', ':BufSurfBack<cr>')
call submode#map('bufsurfback', 'n', '', 'f', ':BufSurfBack<cr>')

" vim:foldmethod=marker:foldlevel=0
