" Get visual selection
function! GetVisualSelection()
  if mode()=="v"
    let [line_start, column_start] = getpos("v")[1:2]
    let [line_end, column_end] = getpos(".")[1:2]
  else
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
  end
  if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
    let [line_start, column_start, line_end, column_end] =
          \   [line_end, column_end, line_start, column_start]
  end
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - 1]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

" Substitute current word or selection
function! Substitute#WordOrSelection(type)
  if a:type ==# 'v'
    let @/ = GetVisualSelection()
    call feedkeys(":%s//".GetVisualSelection())
  elseif a:type ==# 'V'
    let l:searchStr = @/
    let l:searchStr = substitute(l:searchStr, '\\<', '', 'g')
    let l:searchStr = substitute(l:searchStr, '\\>', '', 'g')
    call feedkeys(":'<,'>s//".l:searchStr)
  elseif a:type ==# 'normal'
    let l:currentWord = expand("<cword>")
    let @/ = '\<'.l:currentWord.'\>'
    call feedkeys(":%s//".l:currentWord)
  else
    return
  endif
endfunction

