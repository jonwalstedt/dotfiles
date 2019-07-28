" Keymap

" Open Vimrc in split
nnoremap <leader>ve :vsplit $MYVIMRC<CR>

" Source Vimrc
nnoremap <leader>vs :source $MYVIMRC<CR>

" Use jj as escape
inoremap jj <Esc>

" Yank to end of line
nnoremap Y y$

" Yank all matches
nnoremap <leader>y :CopyMatches<CR>

" Go to previous file with backspace
nnoremap <BS> :update<CR><c-^>

" Close current buffer
nnoremap <leader>bd :bd<CR>

" Close and update buffer
nnoremap <leader>q ZZ<C-w><C-p>
nnoremap <leader>ll ZZ<C-w><C-p>

" Write buffer and close window
nnoremap <leader>w :update<CR>

" Vanilla fuzzy find
nnoremap <leader>p :find ./**/

" Use light theme
nnoremap <leader>tl :colorscheme morning<CR>

" Use dark theme
nnoremap <leader>td :colorscheme onedark<CR>

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Escape to clear highlighting in normal mode
nnoremap <silent> <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

" Toggle relative line numbers
nnoremap <silent> <leader>n :call NumberToggle()<cr>

" Tabs {{{
" New tab
nnoremap <leader>tn :tabnew<CR>

" Previous tab (override unimpaired jump to next tag)
nnoremap <silent> [t :tabp<CR>

" Next tab (override unimpaired jump to previous tag)
nnoremap <silent> ]t :tabn<CR>
" }}}
" Macros {{{
" Easily edit the macro stored at register q
nnoremap <leader>mq :<C-U><C-R><C-R>='let @q = '. string(getreg('q'))<CR><C-F><left>

" Run macro over selected rows using @
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
" }}}
" Movement {{{
" Move to end of line
nnoremap L $
nnoremap L $
onoremap L $

" Move to start of line
nnoremap H ^
vnoremap H ^
onoremap H ^
" }}}
" Terminal {{{
" Open zsh terminal in vertical or horizontal split
nnoremap <silent> <Leader>tl :vs term://zsh<CR>
nnoremap <silent> <Leader>tj :sp term://zsh<CR>

" Escape to exit to normal mode in terminal
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>
" }}}
" Splits {{{
" Move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" Open file under cursor in vertical split
nnoremap <C-w>f :vertical wincmd f<CR>
" }}}
" Netrw {{{
" opens netrw in the current window
nnoremap <localleader>e :Explore<CR>
" opens netrw in a horizontal split
nnoremap <localleader>x :Sexplore<CR>
" opens netrw in a vertical split
nnoremap <localleader>v :Vexplore<CR>

" Refresh netrw directory listing using <C-l>
" }}}
" Folds {{{
" Navigate between closed folds
nnoremap <silent> zn :call NextClosedFold('j')<CR>
nnoremap <silent> zN :call NextClosedFold('k')<CR>
" }}}
" Grep / Search  {{{
" Regular grep
nnoremap <leader>h :silent grep! -R  .<left><left>

vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" Grep word under cursor: (from Learn Vimscript the hard way:
" http://learnvimscriptthehardway.stevelosh.com/chapters/32.html)
"nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<CR>:copen<CR>
nnoremap <leader>g :call SearchAndGrep("normal")<CR>
vnoremap <leader>g :<c-u>call SearchAndGrep(visualmode())<CR>
" }}}
" Substitute {{{
nnoremap c* *``cgn
nnoremap c# *``cgN

nnoremap d* *``dgn
nnoremap d# *``dgN

nnoremap <C-space> :call SubstituteWordOrSelection("normal")<CR>
vnoremap <C-space> :<c-u>call SubstituteWordOrSelection(visualmode())<CR>

nnoremap <leader>s :cfdo %s///c \| update<left><left><left><left><left><left><left><left><left><left><left>
" }}}
