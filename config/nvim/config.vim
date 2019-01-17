" Misc {{{
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

filetype plugin indent on
set path=.,,**
set suffixesadd=.js,.jsx,.ts,.tsx               " Add suffix when looking for imported files
set exrc                                        " Look for project specific settings in /project/.nvimrc
set secure                                      " Prevetn :autocmd unless owned by me
set spelllang=en_gb
set mouse=a                                     " Enable mouse.
set lazyredraw                                  " Only redraw when needed
set nostartofline                               " Do not jump to first character with page commands.
set showmatch                                   " Highlight matching [{()}]
set completeopt=longest,menuone,preview
set clipboard=unnamed                           " Use the clipboard register
"set list "set listchars=eol:¶,tab:>=,trail:.
set list
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set ruler                                       " Show the cursor position all the time.
set showcmd                                     " Display incomplete commands.
set tildeop                                     " Enable ~ operator.
set timeoutlen=800                              " Timeout Leader after 400 ms.
set updatetime=100                              " Set update time to 100 ms.
set virtualedit=block                           " Enable virtualedit when in Visual Block mode.

" Remove highlighted line for unfocused buffer
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
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
set undodir=$HOME/.nvim/undo
set undolevels=1000
set undoreload=10000
" }}}
" Folding {{{
set foldenable                                  " Enable folding
set foldmethod=indent
set foldlevelstart=99
" }}}
" Colors {{{
syntax enable
set termguicolors
set t_Co=256
set cursorline                                  " Highlight current row
set background=dark

augroup init
  autocmd!
  autocmd ColorScheme * highlight NonText term=NONE cterm=NONE ctermfg=242 ctermbg=NONE gui=NONE guifg=magenta guibg=NONE
augroup END

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''
" }}}
" Tabs (whitespace settings) {{{
set tabstop=4                                   " Render Tabs using this many spaces.
set softtabstop=0
set expandtab                                   " Insert spaces when TAB is pressed.
set shiftwidth=2                                " Indentation amount for < and > commands.
set smarttab
set nojoinspaces                                " Prevents inserting two spaces after punctuation on a join (J).
set laststatus=2                                " Allways show statusline
set nrformats-=octal                            " Numbers that start with a zero will be considered to be octal
set autoindent
set smartindent
" }}}
" Line numbers {{{
set number                                      " Show line numbers"
set rnu                                         " Relative line numbers
set numberwidth=3                               " Gutter width for line numbers
set signcolumn=yes
"}}}
" Search {{{
set incsearch                                   " Highlight search results as you type
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
" Rulers (rulers of 80) {{{
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
"}}}
" Submode {{{
let g:submode_timeout = 0                           " Disable submode timeouts:
let g:submode_keep_leaving_key = 1                  " Don't consume submode-leaving key
" }}}
" Netrw {{{
let g:netrw_liststyle = 4
let g:netrw_preview=1
let g:netrw_alto=0
let g:netrw_winsize=50
let g:netrw_keepdir=0
" }}}

" vim:foldmethod=marker:foldlevel=0
