" Create missing folders when creating new file
function! Folders#MkNonExDir(file, buf)
  " Ensure the buffer is not an internal one
  if empty(getbufvar(a:buf, '&buftype'))
        \ && a:file !~# '^\w\+:/' " Exclude remote files like scp:// or http://
    let dir = simplify(fnamemodify(a:file, ':h'))
    if !isdirectory(dir)
      try
        call mkdir(dir, 'p')
      catch
        echohl WarningMsg | echom "Failed to create directory: " . dir | echohl None
      endtry
    endif
  endif
endfunction
