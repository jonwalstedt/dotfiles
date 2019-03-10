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
" NNN {{{
Plug 'mcchrish/nnn.vim', { 'on': 'NnnPicker' }

let $NNN_USE_EDITOR=1
let $NNN_SHOW_HIDDEN=1
let $DISABLE_FILE_OPEN_ON_NAV=1

nnoremap <leader>h :NnnPicker '%:p:h'<CR>
nnoremap - :NnnPicker '%:p:h'<CR>
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<localleader>t': 'tab split',
      \ '<localleader>x': 'split',
      \ '<localleader>v': 'vsplit' }
" }}}
" Submode {{{
Plug 'kana/vim-submode'
let g:submode_timeout = 0                           " Disable submode timeouts:
let g:submode_keep_leaving_key = 1                  " Don't consume submode-leaving key
" }}}
" ProjectRoot {{{
Plug 'dbakker/vim-projectroot', { 'on': 'ProjectRootCD' }
nnoremap <silent> <localleader>r :ProjectRootCD<CR>
" }}}
" Gutentags {{{
Plug 'ludovicchabant/vim-gutentags'
" Gutentags throws errors when saving git commit messages, as a workaround
" gutentags is disabled.
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
" }}}
" GitGutter {{{
" Plug 'airblade/vim-gitgutter'
" "disable keybindings (causes delay on mapped easymotion keys)
" let g:gitgutter_map_keys = 0
" hi GitGutterAddLine guifg=white guibg=springgreen4 gui=NONE
" hi GitGutterChangeLine guifg=#ffffff guibg=lightseablue gui=NONE
" hi GitGutterDeleteLine guifg=#ff0101 guibg=firebricks gui=NONE
" hi GitGutterChangeDeleteLine guifg=#000000 guibg=#ffb733 gui=NONE
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
" Twiggy  {{{
" https://vimawesome.com/plugin/twiggy
Plug 'sodapopcan/vim-twiggy', { 'on': 'Twiggy'}

function! ToggleTwiggy()
  if buflisted(bufname('.git/index'))
    bd .git/branches
  else
    Twiggy
  endif
endfunction

command! ToggleTwiggy :call ToggleTwiggy()
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
" Coc {{{
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
vmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <localleader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <localleader>q  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <localleader>w  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <localleader>e  :<C-u>CocListResume<CR>

" }}}
" ExtractMatches {{{
Plug 'vim-scripts/ingo-library', { 'on': []}
Plug 'vim-scripts/ExtractMatches', { 'on': []}
command! YankMatches call plug#load('ExtractMatches', 'ingo-library') | YankMatches
" }}}
" Help {{{
Plug 'jonwalstedt/vim-myhelp'
" }}}
"
Plug 'ton/vim-bufsurf'
Plug 'Konfekt/FastFold'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'bronson/vim-visual-star-search'

Plug 'HerringtonDarkholme/yats.vim', { 'for': ['ts', 'tsx'] }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['hbs', 'handlebars'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css'] }

Plug 'joshdick/onedark.vim'
Plug 'jonwalstedt/minimalgrey'
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

" Twiggy (toggle twiggy panel)
call submode#enter_with('gitbranches', 'n', '', '<localleader>b', ':ToggleTwiggy<cr>')
call submode#map('gitbranches', 'n', '', 'b', ':ToggleTwiggy<cr>')

" BufSurf
call submode#enter_with('bufsurff', 'n', '', '<leader>j', ':BufSurfForward<cr>')
call submode#map('bufsurff', 'n', '', 'j', ':BufSurfForward<cr>')
call submode#enter_with('bufsurfback', 'n', '', '<leader>f', ':BufSurfBack<cr>')
call submode#map('bufsurfback', 'n', '', 'f', ':BufSurfBack<cr>')

call coc#add_extension('coc-json', 'coc-tsserver', 'coc-prettier', 'coc-html', 'coc-jest', 'coc-ultisnips', 'coc-tag', 'coc-css', 'coc-eslint', 'coc-tslint')
" vim:foldmethod=marker:foldlevel=0
