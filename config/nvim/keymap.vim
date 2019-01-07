" Map leader enter to redraw screen
nmap <leader><cr> :redraw!<CR>

" Map jj to escape
inoremap jj <Esc>

" Go to previous file with backspace
nnoremap <BS> <c-^>

" Open zsh terminal in vertical or horizontal split
nmap <silent> <Leader>tv :vs term://zsh<CR>
nmap <silent> <Leader>th :sp term://zsh<CR>

" Escape to exit to normal mode in terminal
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>

" Escape to clear highlighting in normal mode
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Search for visually selected word with //
vnoremap // y/<C-R>"<CR>

" Resize Split
map <silent> <Leader>0 :exe "vertical resize +15"<CR>
map <silent> <Leader>9 :exe "vertical resize -15"<CR>

" Highlight word under cursor without moving the cursor
nnoremap * *``
nnoremap # #``

" Shift enter and alt enter in normal mode to add new line above or below
nmap <S-Enter> O<Esc>j
nmap <A-Enter> o<Esc>k

" Split panes" (create with :vs)
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>

" Toggle cursorline and cursorcolumn
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
