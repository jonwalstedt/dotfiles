" Toggle QuickFix list
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! QuickFix#Toggle(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! QuickFix#AddCurrentLineToQuickfixList()
    " Get the current line number and file name
    let l:lnum = getpos('.')[1]
    let l:fname = expand('%:p')

    " Get the current quickfix list
    let l:qf_list = getqflist()

    " Add the current line to the quickfix list
    call add(l:qf_list, {'filename': l:fname, 'lnum': l:lnum})

    " Set the quickfix list
    call setqflist(l:qf_list)

    " Open the quickfix window
    " copen
endfunction
