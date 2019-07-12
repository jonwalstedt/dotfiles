" Commands

" Vim Profiler {{{
command! ProfileMe :profile start profile.log <bar> profile func * <bar> profile file *
command! ProfileStop :profile pause
"}}}
" Highlights {{{
function! MyHighlights() abort
  highlight VertSplit ctermbg=235 ctermfg=236
  highlight LineNr ctermfg=darkgrey
  highlight NonBreakingSpace ctermbg=red guibg=red
  match NonBreakingSpace / / " (CTRL+V x a 0)
endfunction

augroup highlights
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup end
" }}}
" Folding {{{
augroup marker
  autocmd!
  autocmd FileType vim,txt
        \ setlocal foldmethod=marker |
        \ setlocal foldlevel=0
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
