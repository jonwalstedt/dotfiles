" Commands

" Auto reload vimrc {{{
augroup autoreloadvimrc
  autocmd!
  autocmd BufWritePost *.vim source $MYVIMRC
augroup end
" }}}
" Vim Profiler {{{
command! ProfileMe :profile start profile.log <bar> profile func * <bar> profile file *
command! ProfileStop :profile pause
"}}}
" Folding {{{
function! Marker() abort
  setlocal foldmethod=marker
  setlocal foldlevel=0
endfunction

augroup marker
  autocmd!
  autocmd FileType vim,txt call Marker()
augroup end
" }}}
" Terminal buffer {{{
augroup terminal
  autocmd!
  autocmd TermOpen *
    \ setlocal nonumber |
    \ setlocal signcolumn=no
augroup end
" }}}
" Remove NonBreakingSpaces {{{
augroup RemoveSpaces
  autocmd!
  autocmd BufWritePre * silent! :%s/\%u00A0/ /g
augroup end
" }}}
