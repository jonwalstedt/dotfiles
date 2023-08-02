" Files + devicons
function! CustomFZF#FilesWithDevIcons()

  " Adds the lines to the quickfix list
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  " Returns the fzf options for files
  function! s:get_fzf_files_options()
    let l:preview_command = "--preview '([[ -f {2..-1} ]] && (bat --theme=''Dracula'' --style=numbers,changes --color always {2..-1} | head -".&lines." || cat {2..-1})) || tree -C {2..-1} || echo {} 2> /dev/null | head -200'"
    let l:expect_options = "--expect=ctrl-t,ctrl-v,ctrl-x"
    let l:multi_option = "--multi"
    let l:header = "--header='? to toggle preview | ctrl-a to select all | ctrl-d to deselect all | ctrl-q to populate quickfix list | ctrl-y to yank list'"
    let l:bind_options = "--bind=?:toggle-preview,ctrl-a:select-all,ctrl-d:deselect-all"

    return printf(" %s %s %s %s %s", l:preview_command, l:expect_options, l:multi_option, l:header, l:bind_options)
  endfunction

  " Returns the map of actions for fzf
  let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-b': 'split',
        \ 'ctrl-v': 'vsplit',
        \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

  " Prepends the icon to the candidates
  function! s:prepend_icon(candidates)
    let result = []
    for candidate in a:candidates
      let filename = fnamemodify(candidate, ':p:t')
      let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
      call add(result, printf("%s %s", icon, candidate))
    endfor
    return result
  endfunction

  " Returns the files with their respective icons
  function! s:files_with_icons()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  " Removes the icon from the files and opens them
  function! s:open_files(items)
    let items = a:items
    let i = 1
    let ln = len(items)
    while i < ln
      let item = items[i]
      let parts = split(item, ' ')
      let file_path = get(parts, 1, '')
      let items[i] = file_path
      let i += 1
    endwhile
    call s:Sink(items)
  endfunction

  let opts = fzf#wrap({})
  let opts.source = <sid>files_with_icons()
  let s:Sink = opts['sink*']
  let opts['sink*'] = function('s:open_files')
  let opts.options .= s:get_fzf_files_options()
  call fzf#run(opts)
endfunction

" FZF BD to close buffers
function! CustomFZF#Bufs()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

