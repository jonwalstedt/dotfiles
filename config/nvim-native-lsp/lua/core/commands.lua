local U = require('utils')
local command = U.command

-- Lsp
command('LspClearDiagnostics', function() vim.diagnostic.reset(0) end)
command('LspPrint', function() print(vim.inspect(vim.lsp.get_clients())) end)

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

-- Git
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
command('GitDiffWithHash', function() require('lib.fugitive').diff_with_hash() end)
command('GDiffWithHash', function() require('lib.fugitive').diff_with_hash() end)
