" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': $XDG_DATA_HOME . '/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-submode'
Plug 'justinmk/vim-sneak'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive', { 'on': [] }
Plug 'sodapopcan/vim-twiggy', { 'on': 'Twiggy'}
Plug 'junegunn/gv.vim', { 'on': []}
Plug 'ervandew/supertab'
Plug 'sirver/ultisnips'
Plug 'dbakker/vim-projectroot', { 'on': 'ProjectRootCD' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'vim-scripts/ingo-library', { 'on': []}
Plug 'vim-scripts/ExtractMatches', { 'on': []}
Plug 'tpope/vim-vinegar'
Plug 'romainl/vim-qlist'
Plug 'ton/vim-bufsurf'
Plug 'Konfekt/FastFold'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'bronson/vim-visual-star-search'
Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs'
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['ts', 'tsx'] }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['hbs', 'handlebars'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css'] }
Plug 'jparise/vim-graphql'
Plug 'joshdick/onedark.vim'
Plug 'jonwalstedt/minimalgrey'
Plug 'jonwalstedt/vim-myhelp'
call plug#end()

" Plugin settings
" FZF Fuzzyfinder {{{
command! -bar -bang Snippets call fzf#vim#snippets({'options': '-n ..'}, <bang>0)
"let $FZF_DEFAULT_OPTS .= ' --inline-info --color "border:#333333"'
"let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <C-p> :FZF<cr>
nnoremap <C-s> :Ag<cr>
inoremap <C-space> <esc>:Snippets<cr>
nnoremap <localleader>t :Buffers<cr>
nnoremap <localleader>p :History:<cr>
nnoremap <localleader>h :History<cr>

imap <c-f> <plug>(fzf-complete-path)
imap <c-l> <plug>(fzf-complete-line)

" }}}
" Submode {{{
let g:submode_timeout = 0                           " Disable submode timeouts:
let g:submode_keep_leaving_key = 1                  " Don't consume submode-leaving key
" }}}
" ProjectRoot {{{
nnoremap <silent> <localleader>r :ProjectRootCD<CR>
" }}}
" Gutentags {{{
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ },
      \ }
let g:gutentags_generate_on_new = 1

" Gutentags throws errors when saving git commit messages, as a workaround
" gutentags is disabled.
augroup gutentags
  autocmd!
  autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
augroup end
" }}}
" GitGutter {{{
"disable keybindings (causes delay on mapped easymotion keys)
let g:gitgutter_map_keys = 0
hi GitGutterAddLine guifg=white guibg=springgreen4 gui=NONE
hi GitGutterChangeLine guifg=#ffffff guibg=lightseablue gui=NONE
hi GitGutterDeleteLine guifg=#ff0101 guibg=firebricks gui=NONE
hi GitGutterChangeDeleteLine guifg=#000000 guibg=#ffb733 gui=NONE
" }}}
" Vim Fugitive {{{
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

command! ToggleGStatus :call ToggleGStatus()

" Fugitive (toggle git status panel)
call submode#enter_with('gitstatus', 'n', '', '<localleader><space>', ':ToggleGStatus<cr>')
call submode#map('gitstatus', 'n', '', '<space>', ':ToggleGStatus<cr>')
"}}}
" Twiggy  {{{
" https://vimawesome.com/plugin/twiggy
function! ToggleTwiggy()
  if buflisted(bufname('.git/index'))
    bd .git/branches
  else
    Twiggy
  endif
endfunction

command! ToggleTwiggy :call ToggleTwiggy()

" Twiggy (toggle twiggy panel)
call submode#enter_with('gitbranches', 'n', '', '<localleader>b', ':ToggleTwiggy<cr>')
call submode#map('gitbranches', 'n', '', 'b', ':ToggleTwiggy<cr>')
"}}}
" gv.vim  {{{
command! GV call plug#load('vim-fugitive', 'gv.vim') | GV
"}}}
" Supertab {{{
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" Emmet {{{
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
"Disable default mappings
let g:EasyMotion_do_mapping = 0

"Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"keep cursor column when JK motion
let g:EasyMotion_startofline = 0

"Use upper target labels and type as a lower case
"let g:EasyMotion_use_upper = 1

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwy'

nmap <space> <plug>(easymotion-overwin-f2)
omap <space> <plug>(easymotion-bd-f2)
vmap <space> <plug>(easymotion-bd-f2)

"JK motions: Line motions
map <localleader>j <Plug>(easymotion-j)
map <localleader>k <Plug>(easymotion-k)

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
" Coc {{{
call coc#add_extension('coc-json', 'coc-tsserver', 'coc-prettier', 'coc-html', 'coc-jest', 'coc-ultisnips', 'coc-tag', 'coc-css', 'coc-eslint', 'coc-tslint', 'coc-tslint-plugin')
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup coc
  autocmd!
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,javascript setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>

" }}}
" ExtractMatches {{{
command! YankMatches call plug#load('ExtractMatches', 'ingo-library') | YankMatches
" }}}
" BufSurf {{{
call submode#enter_with('bufsurff', 'n', '', '<localleader>i', ':BufSurfForward<cr>')
call submode#map('bufsurff', 'n', '', 'i', ':BufSurfForward<cr>')
call submode#enter_with('bufsurfback', 'n', '', '<localleader>o', ':BufSurfBack<cr>')
call submode#map('bufsurfback', 'n', '', 'o', ':BufSurfBack<cr>')
" }}}
" Resize splits {{{
call submode#enter_with('grow/shrink', 'n', '', '<leader>0', ':exe "vertical resize +15"<cr>')
call submode#enter_with('grow/shrink', 'n', '', '<leader>9', ':exe "vertical resize -15"<cr>')
call submode#map('grow/shrink', 'n', '', '0', ':exe "vertical resize +15"<cr>')
call submode#map('grow/shrink', 'n', '', '9', ':exe "vertical resize -15"<cr>')
" }}}


" vim:foldmethod=marker:foldlevel=0
