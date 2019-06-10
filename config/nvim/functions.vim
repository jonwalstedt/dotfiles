" Functions
" Search within range {{{
function! RangeSearch(direction)
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

vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
"}}}
" Toggle relative line numbers {{{
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set nocursorline
    set noshowmode
    set noruler
    set noshowcmd
  else
    set relativenumber
    set cursorline
    set showmode
    set ruler
    set showcmd
  endif
endfunc

nnoremap <silent> <leader><leader> :call NumberToggle()<cr>
"}}}
" Run macro over selected rows {{{
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Run macro over selected rows using @
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
"}}}
" Create missing folders when creating new file {{{
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
"}}}
" Load node modules{{{
function! LoadMainNodeModule(fname)
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"

    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        return nodeModules . a:fname
    endif
endfunction

set includeexpr=LoadMainNodeModule(v:fname)
"}}}
" Quit netrw {{{
function! QuitNetrw()
  for i in range(1, bufnr($))
    if buflisted(i)
      if getbufvar(i, '&filetype') == "netrw"
        silent exe 'bwipeout ' . i
      endif
    endif
  endfor
endfunction
"
augroup Netrw
  autocmd!
  autocmd Netrw VimLeavePre *  call QuitNetrw()
augroup END
"}}}
" Navigate between folds {{{
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
" }}}
