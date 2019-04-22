" Misc {{{
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

set path=.,,**
set suffixesadd=.js,.jsx,.ts,.tsx               " Add suffix when looking for imported files
set include=from
set exrc                                        " Look for project specific settings in /project/.nvimrc
set secure                                      " Prevetn :autocmd unless owned by me
set spelllang=en_gb
set mouse=a                                     " Enable mouse.
"set lazyredraw                                  " Only redraw when needed
set noshowmode
set nostartofline                               " Do not jump to first character with page commands.
set showmatch                                   " Highlight matching [{()}]
set completeopt=longest,menuone,preview
set clipboard=unnamedplus                       " Use the clipboard register
set list
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set noruler                                       " Show the cursor position all the time.
set noshowcmd                                     " Display incomplete commands.
set tildeop                                     " Enable ~ operator.
set timeoutlen=800                              " Timeout Leader after 400 ms.
set updatetime=300                              " If this many milliseconds nothing is typed the swap file will be written to disk - Also used for CursorHold
set virtualedit=block                           " Enable virtualedit when in Visual Block mode.
set hidden                                      " Allow for unsaved changes when switchin buffers (use confirm if you want to be prompted for save)
set cmdheight=2                                 " Better display for messages
set shortmess+=c                                " don't give ins-completion-menu messages.
" }}}
" Backup {{{
set backup                                      " Enable backup of files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Undo {{{
set undofile                                    " Keep a persistent backup file.
" }}}
" Folding {{{
set foldmethod=indent
set foldlevelstart=99
" }}}
" Colors {{{
set nocursorline                                  " Disable Highlight current row
colorscheme onedark
highlight VertSplit ctermbg=235 ctermfg=236
highlight LineNr ctermfg=darkgrey
set termguicolors
" }}}
" Tabs (whitespace settings) {{{
set tabstop=4                                   " Render Tabs using this many spaces.
set softtabstop=0
set expandtab                                   " Insert spaces when TAB is pressed.
set shiftwidth=2                                " Indentation amount for < and > commands.
set nojoinspaces                                " Prevents inserting two spaces after punctuation on a join (J).
set nrformats-=octal                            " Numbers that start with a zero will be considered to be octal
set smartindent
" }}}
" Line numbers {{{
set number                                      " Show line numbers"
set norelativenumber                                       " No relative line numbers
set numberwidth=3                               " Gutter width for line numbers
set signcolumn=yes
"}}}
" Search {{{
set ignorecase                                  " Make searching case insensitive.
set smartcase                                   " Use case sensitive search when query has mixed case.
set gdefault                                    " Use 'g' flag by default with :s/foo/bar/.
set omnifunc=syntaxcomplete#Complete
"}}}
" Substitute {{{
set inccommand=nosplit                          " Shows the effects of a command incrementally, as you type.
" }}}
" Splits {{{
set splitright                                  " Open vertical splits to the right
set splitbelow                                  " Open horizontal splits below
set diffopt+=vertical                           " Open diff in vertical split
set diffopt+=indent-heuristic
set diffopt+=algorithm:patience
"}}}
" Netrw {{{
let g:netrw_liststyle=4
let g:netrw_preview=1
let g:netrw_alto=0
let g:netrw_winsize=50
let g:netrw_keepdir=1
let g:netrw_menu=0
let g:netrw_banner=0
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
let g:netrw_bufsettings='noma nomod nu nowrap ro nobl'
" }}}

" vim:foldmethod=marker:foldlevel=0
