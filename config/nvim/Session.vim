let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/repos/dotfiles/config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/repos/dotfiles/config/nvim/
badd +1 functions.vim
badd +113 keymap.vim
badd +3 term://.//67733:zsh
badd +7 init-light.vim
badd +1 init.vim
badd +1 macros.vim
badd +168 plugins.vim
badd +1 term://.//71770:zsh
argglobal
silent! argdel *
$argadd ~/repos/dotfiles/config/nvim/
edit init.vim
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 67 + 102) / 204)
exe 'vert 2resize ' . ((&columns * 67 + 102) / 204)
exe 'vert 3resize ' . ((&columns * 68 + 102) / 204)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=2
setlocal fen
let s:l = 18 - ((17 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
normal! 015|
wincmd w
argglobal
if bufexists("keymap.vim") | buffer keymap.vim | else | edit keymap.vim | endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=2
setlocal fen
let s:l = 46 - ((45 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
46
normal! 01|
wincmd w
argglobal
if bufexists("plugins.vim") | buffer plugins.vim | else | edit plugins.vim | endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=2
setlocal fen
6
normal! zo
7
normal! zo
let s:l = 176 - ((37 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
176
normal! 0
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 67 + 102) / 204)
exe 'vert 2resize ' . ((&columns * 67 + 102) / 204)
exe 'vert 3resize ' . ((&columns * 68 + 102) / 204)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFsc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
