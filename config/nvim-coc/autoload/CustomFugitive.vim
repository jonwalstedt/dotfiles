" Vim Fugitive {{{
function! CustomFugitive#DiffFileWithHash()
  call inputsave()
  let input = input('Enter hash: ')
  call inputrestore()
  execute ":Gvdiffsplit ".input
endfunction
