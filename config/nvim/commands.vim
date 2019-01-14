" SuperRetab
:command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" vim:foldmethod=marker:foldlevel=0
