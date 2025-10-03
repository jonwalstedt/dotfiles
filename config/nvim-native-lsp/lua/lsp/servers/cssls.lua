local util = require("lspconfig.util")

return {
  root_dir = util.root_pattern '.git',
  cmd = { 'vscode-css-language-server', '--stdio' },
}
