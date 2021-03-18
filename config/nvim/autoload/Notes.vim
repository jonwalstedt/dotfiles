" Vim Fugitive {{{
function! Notes#OpenKingNotes()
  :exe 'vsp ~/repos/king/docs/notes/note-'.strftime("%F").'.md'
endfunction

