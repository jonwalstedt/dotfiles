local set = U.set
local highlight = U.highlight

-- Misc
-- disable some health checks
-- vim.g.loaded_node_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_python_provider = 0
-- g.loaded_python3_provider = 0

-- vim.g.python_host_skip_check = 1
-- vim.g.python3_host_skip_check = 1
vim.g.python2_host_prog = '/Users/jon.walstedt/.pyenv/shims/python'
vim.g.python3_host_prog = '/Users/jon.walstedt/.pyenv/shims/python3'

-- Include current directory in path
set 'path=.'

-- Case insensitive :search etc.
set 'wildignorecase'
set('wildignore', '.git,**/node_modules/**')

-- Add suffix when looking for imported files
set('suffixesadd', '.js,.jsx,.ts,.tsx')
set('include', 'from')

-- Look for project specific settings in /project/.nvimrc
set 'exrc'

-- Prevetn :autocmd unless owned by me
set 'secure'
set('spelllang', 'en_gb')

-- Enable mouse.
set('mouse', 'a')

-- set 'wildmenu'
set('wildoptions', 'pum')

-- Only redraw when needed
set 'lazyredraw'

-- Do not jump to first character with page commands.
set 'nostartofline'

-- Highlight matching [{()}]
set 'showmatch'
set('completeopt', 'menu,menuone,noselect')
-- set omnifunc=syntaxcomplete#Complete
-- set('omnifunc', 'v:lua.vim.lsp.omnifunc')
set('completeopt', 'menu,menuone,noinsert')

-- Use the clipboard register
set('clipboard', 'unnamedplus')

set 'list'
set('listchars', 'nbsp:¬,tab:>-,extends:»,precedes:«,trail:•')

-- Show the cursor position all the time.
set 'noruler'

-- Display incomplete commands.
set 'noshowcmd'

-- Enable ~ operator.
set 'tildeop'

-- Timeout Leader after 400 ms.
set('timeoutlen', 800)

-- Enable virtualedit when in Visual Block mode.
set('virtualedit', 'block')

-- Allow for unsaved changes when switchin buffers (use confirm if you want to be prompted for save)
set 'hidden'

-- Better display for messages
set('cmdheight', 2)

-- don't give ins-completion-menu messages.
-- set shortmess+=c
set 'nomodeline'
set('scrolloff', 5)

-- Backup
-- Enable backup of files
set 'nobackup'
set 'nowritebackup'
set('backupdir', '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp')
set('backupskip', '/tmp/*,/private/tmp/*')
set('directory', '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp')

-- Undo
-- Keep a persistent backup file.
set 'undofile'
set('undodir', '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp')

-- Folding
set('foldmethod', 'manual')
set('foldtext', 'NeatFoldText()')

-- Global statusline
-- set('laststatus', 3)

-- Colors
vim.g.nvcode_termcolors = 256
vim.cmd 'syntax on'
set 'termguicolors'
vim.cmd 'colorscheme embark'
-- vim.g.tokyonight_style = 'night'

-- Disable highlight current row
set 'nocursorline'

-- Dim inactive buffer
highlight('Normal', { guibg = '#13141c' })
highlight('ActiveWindow', { guibg = '#101118' })
highlight('InactiveWindow', { guibg = '#13141c' })
highlight('EndOfBuffer', { ctermbg = 'bg', ctermfg = 'bg', guibg = 'bg', guifg = 'bg' })
highlight('VertSplit', { guibg = '#13141c', guifg = '#000000' })
set('winhighlight', 'Normal:ActiveWindow,NormalNC:InactiveWindow')
highlight('CursorLine', { guibg = '#13141c',  guifg = '#65b2ff' })
highlight('CursorLineNR', { guifg = '#65b2ff' })

highlight('Comment', { guifg = '#666666', gui = 'italic', cterm = 'italic' })
-- highlight('SignColumn', { guibg = '#000000' })
-- highlight('LineNr', { guibg = '#000000'})

-- Tabs (whitespace settings)
-- Render Tabs using this many spaces.
set('tabstop', 4)
set('softtabstop', 0)

-- Insert spaces when TAB is pressed.
set 'expandtab'

-- Indentation amount for < and > commands.
set('shiftwidth', 2)

-- Prevents inserting two spaces after punctuation on a join (J).
set 'nojoinspaces'

-- Numbers that start with a zero will be considered to be octal
vim.cmd 'set nrformats-=octal'

set 'smartindent'

-- Line numbers
-- Show line numbers
set 'number'

-- Gutter width for line numbers
set('numberwidth', 3)
set('signcolumn', 'yes')

-- Search
set('grepprg', 'ag\\ --vimgrep\\ --nogroup\\ --nocolor')

-- Make searching case insensitive.
set 'ignorecase'

-- Use case sensitive search when query has mixed case.
set 'smartcase'

-- Use 'g' flag by default with :s/foo/bar/.
set 'gdefault'

-- Substitute
-- Shows the effects of a command incrementally, as you type.
set('inccommand', 'nosplit')

-- Splits
-- Open vertical splits to the right
set 'splitright'

-- Open horizontal splits below
set 'splitbelow'

set('updatetime', 300)

-- Open diff in vertical split
vim.cmd 'set diffopt+=vertical'
vim.cmd 'set diffopt+=indent-heuristic'
vim.cmd 'set diffopt+=algorithm:patience'

-- Netrw
vim.g.netrw_liststyle = 4
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.netrw_winsize = 50
vim.g.netrw_keepdir = 1
vim.g.netrw_menu = 0
vim.g.netrw_banner = 0

-- Allow netrw to remove non-empty local directories
vim.g.netrw_localrmdir = 'rm -r'
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

-- Tags
set('tags', './.tags,.tags')
