func! DeleteCurBufferNotCloseWindow() abort
  if &modified
    echohl ErrorMsg
    echom "E89: no write since last change"
    echohl None
  elseif winnr('$') == 1
    bd
  else  " multiple window
    let oldbuf = bufnr('%')
    let oldwin = winnr()
    while 1   " all windows that display oldbuf will remain open
      if buflisted(bufnr('#'))
        b#
      else
        bn
        let curbuf = bufnr('%')
        if curbuf == oldbuf
          enew    " oldbuf is the only buffer, create one
        endif
      endif
      let win = bufwinnr(oldbuf)
      if win == -1
        break
      else        " there are other window that display oldbuf
        exec win 'wincmd w'
      endif
    endwhile
    " delete oldbuf and restore window to oldwin
    exec oldbuf 'bd'
    exec oldwin 'wincmd w'
  endif
endfunc
