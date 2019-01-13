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

" Highlight word under cursor without moving the cursor
nnoremap * *``
nnoremap # #``

" Split panes" (create with :vs)
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>

" Toggle cursorline and cursorcolumn
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" go to tag
nmap <C-]> <leader>gd

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
" vim:foldmethod=marker:foldlevel=0
