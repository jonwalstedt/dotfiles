local cmd = require 'lua-helpers/command'
local command = cmd.command

command([[LspReload]], [[lua require'lsp_config'.lsp_reload(0)]])
command([[LspStop]], [[lua require'lsp_config'.lsp_stop(0)]])
command([[LspClearDiagnostics]], [[lua vim.lsp.diagnostic.clear(0)]])
command([[LspPrint]], [[lua print(vim.inspect(vim.lsp.buf_get_clients()))]])
command([[ProfileMe]], [[profile start profile.log <bar> profile func * <bar> profile file *]])
command([[ProfileStop]], [[profile pause]])
command([[Exec]], [[set splitright | vnew | set filetype=sh | read !sh #]])
command([[BD]], [[call fzf#run(fzf#wrap({ 'source': CustomFZF#Bufs(), 'sink*': { lines -> execute('bwipeout '.join(map(lines, {_, line -> split(line)[0]}))) }, 'options': '--multi --reverse --bind ctrl-a:select-all+accept' }))]])
command([[ToggleGStatus]], [[:call CustomFugitive#ToggleGStatus()]])
command([[GV]],[[call plug#load('vim-fugitive', 'gv.vim') | GV]])
