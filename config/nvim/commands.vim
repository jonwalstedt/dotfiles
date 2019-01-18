" SuperRetab {{{
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
"}}}
" Vim Profiler {{{
command! ProfileMe :profile start profile.log <bar> profile func * <bar> profile file *
command! ProfileStop :profile pause
"}}}
" vim:foldmethod=marker:foldlevel=0
