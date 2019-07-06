" Open Vimrc in split
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Source Vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Use jj as escape
inoremap jj <Esc>

" Update and close buffer with KK
nnoremap KK ZZ

" Yank to end of line
nnoremap Y y$

" Move to end of line
nnoremap L $
nnoremap L $
onoremap L $

" Move to start of line
nnoremap H ^
vnoremap H ^
onoremap H ^

nnoremap c* *``cgn
nnoremap c# *``cgN

nnoremap d* *``dgn
nnoremap d# *``dgN

" Substitute word under cursor
nnoremap <C-space> *``:%s//<C-R><C-W>

" Substitute visually selection
vnoremap <C-space> y/<C-R>"<CR>:%s//<C-R>/

" Substitute previous search within selected range
vnoremap <expr> <localleader><space> GetSearchWordClean()

" Go to previous file with backspace
nnoremap <BS> :update<CR><c-^>

" Open zsh terminal in vertical or horizontal split
nnoremap <silent> <Leader>tv :vs term://zsh<CR>
nnoremap <silent> <Leader>th :sp term://zsh<CR>
nnoremap <silent> <localleader>l :vs term://zsh<CR>

" Escape to exit to normal mode in terminal
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>

" Escape to clear highlighting in normal mode
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Go to tag
nnoremap <leader>gd <C-]>

" netrw
" opens netrw in the current window
nnoremap <localleader>e :Explore<CR>
" opens netrw in a horizontal split
nnoremap <localleader>x :Sexplore<CR>
" opens netrw in a vertical split
nnoremap <localleader>v :Vexplore<CR>

nnoremap <unique> <leader>r <Plug>NetrwRefresh

" Easily edit the macro stored at register q
nnoremap <leader>q :<C-U><C-R><C-R>='let @q = '. string(getreg('q'))<CR><C-F><left>

" Navigate between closed folds
nnoremap <silent> zn :call NextClosedFold('j')<CR>
nnoremap <silent> zN :call NextClosedFold('k')<CR>

nnoremap <localleader>] <C-]>

" Open file under cursor in vertical split
nnoremap <C-w>f :vertical wincmd f<CR>
