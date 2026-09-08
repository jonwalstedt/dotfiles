local U = require('utils')
local nmap = U.keymap.nmap
local vmap = U.keymap.vmap

require('agentic').setup {
  provider = 'claude-agent-acp',
  window = {
    position = 'right',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'AgenticInput',
  callback = function(ev)
    vim.schedule(function()
      vim.bo[ev.buf].completefunc = ''
      -- stop agentic's TextChangedI autocmd from feeding <C-x><C-u> (causes native popup flicker)
      vim.api.nvim_clear_autocmds({ buffer = ev.buf, event = 'TextChangedI' })
    end)
  end,
})

nmap('<C-\\>', function() require('agentic').toggle() end)
nmap('<leader>an', function() require('agentic').new_session() end)
nmap('<leader>ar', function() require('agentic').restore_session() end)
vmap('<C-\'>', function() require('agentic').add_selection() end)
