local command = U.command

-- Lsp
command('LspReload', "lua require'lsp_config'.lsp_reload(0)")
command('LspStop', "lua require'lsp_config'.lsp_stop(0)")
command('LspClearDiagnostics', 'lua vim.lsp.diagnostic.clear(0)')
command('LspPrint', 'lua print(vim.inspect(vim.lsp.buf_get_clients()))')

-- Profiling
command(
  'ProfileMe',
  'profile start profile.log <bar> profile func * <bar> profile file *'
)
command('ProfileStop', 'profile pause')

-- Misc
-- execute shell script in file
command('Exec', 'set splitright | vnew | set filetype=sh | read !sh #')
-- copy buffer file path
command('CopyBufferPath', ":let @+ = expand('%:p')")

command(
  'BD',
  "call fzf#run(fzf#wrap({ 'source': CustomFZF#Bufs(), 'sink*': { lines -> execute('bwipeout '.join(map(lines, {_, line -> split(line)[0]}))) }, 'options': '--multi --reverse --bind ctrl-a:select-all+accept' }))"
)
command(
  'Ag',
  ":call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)"
)

-- Git
command('ToggleGStatus', 'call CustomFugitive#ToggleGStatus()')
command(
  '-nargs=* Glg',
  "vertical Git --paginate log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local <args>"
)
command(
  '-nargs=* GV',
  "vertical Git --paginate log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local <args>"
)
command('GitFileHistory', '0Gclog')
command('GFileHistory', '0Gclog')
command('GitDiffWithHash', 'call CustomFugitive#DiffFileWithHash()')
command('GDiffWithHash', 'call CustomFugitive#DiffFileWithHash()')
