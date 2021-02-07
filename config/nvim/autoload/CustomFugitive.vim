" Vim Fugitive {{{
function! CustomFugitive#ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    Gstatus
  endif
endfunction
