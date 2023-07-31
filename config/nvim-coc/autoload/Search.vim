" Search within range
function! Search#RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction

" Search and then Grep
function! Search#SearchAndGrep(type, local)
  let savedUnnamedRegister = @@

  if a:type ==# 'v'
    normal! `<v`>y
    let @/ = @@
    if a:local ==# 1
      silent! execute "grep! " . shellescape(@@) . " %"
    else
      silent! execute "grep! -R " . shellescape(@@) . " ."
    endif
  elseif a:type ==# 'char'
    normal! `[v`]y
    let @/ = @@
    if a:local ==# 1
      silent! execute "grep! " . shellescape(@@) . " %"
    else
      silent! execute "grep! -R " . shellescape(@@) . " ."
    endif
  elseif a:type ==# 'normal'
    let l:currentWord = expand("<cword>")
    let @/ = '\<'.l:currentWord.'\>'
    if a:local ==# 1
      silent! execute ":grep! " . shellescape(l:currentWord)  . " %"
    else
      silent! execute ":grep! -R -w " . shellescape(l:currentWord) . " ."
    endif
  else
    return
  endif

  copen 28
  set hlsearch

  let @@ = savedUnnamedRegister
endfunction
