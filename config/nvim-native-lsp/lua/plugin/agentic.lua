local U = require('utils')
local nmap = U.keymap.nmap
local vmap = U.keymap.vmap

require('agentic').setup {
  provider = 'claude-agent-acp',
  window = {
    position = 'right',
  },
}

nmap('<C-\\>', function() require('agentic').toggle() end)
nmap('<leader>an', function() require('agentic').new_session() end)
nmap('<leader>ar', function() require('agentic').restore_session() end)
vmap('<C-\'>', function() require('agentic').add_selection() end)
