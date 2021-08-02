" Change highlight group of active/inactive windows
function! WindowManagement#Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" function! WindowManagement#Handle_Win_Leave()
" endfunction
