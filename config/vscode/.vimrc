let g:mapleader = "\<Space>"

set incsearch
set smartcase
set hlsearch

inoremap jj <Esc>

" Update and go to previous file with backspace
nnoremap <BS> :update<CR><C-^>

" Close and update buffer
nnoremap <leader>q ZZ<C-w><C-p>

" Map <leader>dd to close the current buffer without saving
nnoremap <leader>dd :bd!<CR>

" Refresh buffer
nnoremap <leader>er :e<CR>

" Close all other windows
nnoremap <leader>do :only<CR>

" Update current buffer and close all other buffers
nnoremap <leader>d<CR> :wa<bar>%bd!<bar>e#<bar>bd#<CR>

" Move to end of line
nnoremap L $
vnoremap L $
onoremap L $

" Move to start of line
nnoremap H ^
vnoremap H ^
onoremap H ^

" Yank to end of line
nnoremap Y y$

" Smooth way of creating and moving between splits
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

" search for word under cursor
nnoremap <leader><CR> *:hlsearch<CR>
" ============================================================================
" Macros
" ============================================================================
let @l = "iconsole.log('jjpa:', jjpA);jj=="

" ============================================================================
" IDE replacements
" https://gist.github.com/zchee/9c78f91cc5ad771c1f5d
" ============================================================================
nnoremap <leader>ep editor.action.marker.nextInFiles
nnoremap <leader>en edotr.action.marker.prevInFiles
nnoremap <leader>af editor.action.quickFix
nnoremap <leader>ar editor.action.rename
nnoremap <leader>ad editor.action.goToImplementation
nnoremap <leader><leader> git.showCommnands
nnoremap <leader>p workbench.action.openRecent
nnoremap <leader>w workbench.action.files.save
nnoremap <leader>rr workbench.action.formatDocument

" unimpaired mappings
nnoremap [<space> O<esc>j
nnoremap ]<space> o<esc>k
nnoremap [q editor.action.marker.prevInFiles
nnoremap ]q editor.action.marker.nextInFiles
nnoremap [m editor.action.goToPreviousSymbolInFile
nnoremap ]m editor.action.goToNextSymbolInFile
nnoremap [c git.previousChange
nnoremap ]c git.nextChange

nnoremap - workbench.files.action.showActiveFileInExplorer

" Terminal
nnoremap <Leader>t<Leader> workbench.action.terminal.toggleTerminal

nnoremap <c-p> workbench.action.quickOpen
nnoremap <leader>ff workbench.action.quickOpen
