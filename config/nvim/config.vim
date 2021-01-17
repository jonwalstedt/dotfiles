" Config

" Misc {{{
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

set path+=.
set wildignorecase                              " Case insensitive :search etc.
set wildmenu
set wildoptions=pum
set suffixesadd=.js,.jsx,.ts,.tsx               " Add suffix when looking for imported files
set include=from
set exrc                                        " Look for project specific settings in /project/.nvimrc
set secure                                      " Prevetn :autocmd unless owned by me
set spelllang=en_gb
set mouse=a                                     " Enable mouse.
set lazyredraw                                  " Only redraw when needed
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
set virtualedit=block                           " Enable virtualedit when in Visual Block mode.
set hidden                                      " Allow for unsaved changes when switchin buffers (use confirm if you want to be prompted for save)
set cmdheight=2                                 " Better display for messages
" set shortmess+=c                                " don't give ins-completion-menu messages.
set nomodeline
set scrolloff=5
" }}}
" Backup {{{
set backup                                      " Enable backup of files
set writebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" }}}
" Undo {{{
set undofile                                    " Keep a persistent backup file.
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" }}}
" Folding {{{
set foldmethod=manual
" set foldlevelstart=99
" set foldnestmax=2
set foldtext=NeatFoldText()
" }}}
" Colors {{{
set termguicolors
" colorscheme onedark
" colorscheme night-owl
" colorscheme dracula
" colorscheme elly

colorscheme nvcode
set nocursorline                                  " Disable Highlight current row

highlight Comment cterm=italic
let g:nvcode_hide_endofbuffer=1
let g:nvcode_terminal_italics=1
let g:nvcode_termcolors=256

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" Misc
highlight TSError guifg=#F44747
highlight TSPunctDelimiter guifg=#ABB2BF
highlight TSPunctBracket guifg=#ABB2BF
highlight TSPunctSpecial guifg=#ABB2BF

" Constants
highlight TSConstant guifg=#DCDCAA
highlight TSConstBuiltin guifg=#569CD6
" Not sure about this guy
highlight TSConstMacro guifg=#4EC9B0
highlight TSString guifg=#CE9178
highlight TSStringRegex guifg=#CE9178
highlight TSString guifg=#CE9178
highlight TSStringEscape guifg=#D7BA7D
highlight TSCharacter guifg=#CE9178
highlight TSNumber guifg=#B5CEA8
highlight TSBoolean guifg=#569CD6
highlight TSFloat guifg=#B5CEA8
highlight TSAnnotation guifg=#DCDCAA
highlight TSAttribute guifg=#FF00FF
highlight TSNamespace guifg=#FF00FF


" Functions
" highlight TSFuncBuiltin guifg=#4EC9B0
highlight TSFuncBuiltin guifg=#DCDCAA
highlight TSFunction guifg=#DCDCAA
highlight TSFuncMacro guifg=#DCDCAA
highlight TSParameter guifg=#9CDCFE
highlight TSParameterReference guifg=#9CDCFE
highlight TSMethod guifg=#DCDCAA
highlight TSField guifg=#9CDCFE
highlight TSProperty guifg=#9CDCFE
highlight TSConstructor guifg=#4EC9B0

" Keywords
highlight TSConditional guifg=#C586C0
highlight TSRepeat guifg=#C586C0
highlight TSLabel guifg=#FF00FF
" Does not work for yield and return they should be diff then class and def
highlight TSKeyword guifg=#569CD6
highlight TSKeywordFunction guifg=#FF00FF
highlight TSKeywordOperator guifg=#569CD6
highlight TSOperator guifg=#ABB2BF
highlight TSException guifg=#C586C0
highlight TSType guifg=#4EC9B0
highlight TSTypeBuiltin guifg=#FF00FF
highlight TSStructure guifg=#FF00FF
highlight TSInclude guifg=#C586C0

" Variable
highlight TSVariable guifg=#9CDCFE
highlight TSVariableBuiltin guifg=#9CDCFE

" Text
highlight TSText guifg=#FF00FF
highlight TSStrong guifg=#FF00FF
highlight TSEmphasis guifg=#FF00FF
highlight TSUnderline guifg=#FF00FF
highlight TSTitle guifg=#FF00FF
highlight TSLiteral guifg=#FF00FF
highlight TSURI guifg=#FF00FF

" Tags
highlight TSTag guifg=#569CD6
highlight TSTagDelimiter guifg=#5C6370
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
set numberwidth=3                               " Gutter width for line numbers
set signcolumn=yes
"}}}
" Search {{{
set grepprg=ag\ --vimgrep
set ignorecase                                  " Make searching case insensitive.
set smartcase                                   " Use case sensitive search when query has mixed case.
set gdefault                                    " Use 'g' flag by default with :s/foo/bar/.
" set omnifunc=syntaxcomplete#Complete
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
" Tags {{{
set tags=./.tags,.tags;
" }}}
" Dim inactive buffer {{{
" Background colors for active vs inactive windows
" One Dark
"highlight ActiveWindow guibg=#181a1f
"highlight InactiveWindow guibg=#282c34

" Night Owl and Dracula
" highlight ActiveWindow guibg=#051626
" highlight InactiveWindow guibg=#1f2730
" highlight VertSplit guibg=#051626 guifg=#1f2730

" Elly
highlight ActiveWindow guibg=#0c1317
highlight InactiveWindow guibg=#111a20
highlight VertSplit guibg=#051626 guifg=#1f2730
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
" }}}
