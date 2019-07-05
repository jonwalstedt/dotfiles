" Map leader enter to redraw screen
nnoremap <leader><cr> :redraw!<CR>

inoremap jj <Esc>
inoremap kk <Esc>:w<cr>

nnoremap LL ZZ

nnoremap c* *``cgn
nnoremap c# *``cgN

nnoremap d* *``dgn
nnoremap d# *``dgN

nnoremap <C-space> *``:%s//<C-R><C-W>
vnoremap <C-space> y/<C-R>"<CR>:%s//<C-R>/
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

"move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

nmap <unique> <leader>r <Plug>NetrwRefresh

" Yank to end of line
map Y y$

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" go to tag
nmap <leader>gd <C-]>

" netrw
" opens netrw in the current window
nmap <localleader>e :Explore<cr>
" opens netrw in a horizontal split
nmap <localleader>x :Sexplore<cr>
" opens netrw in a vertical split
nmap <localleader>v :Vexplore<cr>

" Easily edit the macro stored at register q
nnoremap <leader>q :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>

" Navigate between closed folds
nnoremap <silent> zn :call NextClosedFold('j')<cr>
nnoremap <silent> zN :call NextClosedFold('k')<cr>

nnoremap <localleader>] <C-]>

map <C-w>f :vertical wincmd f<CR>
