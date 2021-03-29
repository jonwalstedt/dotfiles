function! Notes#Browse()
  :exe 'vsp ~/repos/king/docs/notes/'
endfunction

function! Notes#Create()
  :exe 'vsp ~/repos/king/docs/notes/note-'.strftime("%F").'.md'
endfunction

