" Map leader enter to redraw screen
nnoremap <leader><CR> :redraw!<CR>

inoremap jj <Esc>

nnoremap KK ZZ
nnoremap L $
vnoremap L $
nnoremap H _
vnoremap H _

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
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

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

nnoremap <unique> <leader>r <Plug>NetrwRefresh

" Yank to end of line
nnoremap Y y$

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" go to tag
nnoremap <leader>gd <C-]>

" netrw
" opens netrw in the current window
nnoremap <localleader>e :Explore<CR>
" opens netrw in a horizontal split
nnoremap <localleader>x :Sexplore<CR>
" opens netrw in a vertical split
nnoremap <localleader>v :Vexplore<CR>

" Easily edit the macro stored at register q
nnoremap <leader>q :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<CR><c-f><left>

" Navigate between closed folds
nnoremap <silent> zn :call NextClosedFold('j')<CR>
nnoremap <silent> zN :call NextClosedFold('k')<CR>

nnoremap <localleader>] <C-]>

map <C-w>f :vertical wincmd f<CR>
