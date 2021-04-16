" Vim Fugitive {{{
function! CustomFugitive#ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
    setlocal cursorline
  else
    Gstatus
    setlocal nocursorline
  endif
endfunction

function! CustomFugitive#DiffFileWithHash()
  call inputsave()
  let input = input('Enter hash: ')
  call inputrestore()
  execute ":Gvdiffsplit ".input
endfunction
