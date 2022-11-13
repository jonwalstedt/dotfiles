local nmap = U.keymap.nmap

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  file_browser = {
    theme = 'ivy',
    mappings = {
      ['i'] = {
        -- your custom insert mode mappings
      },
      ['n'] = {
        -- your custom normal mode mappings
      },
    },
  },
}

vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#1A1B26' })

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

require('telescope').load_extension 'file_browser'

local builtin = require 'telescope.builtin'

--Add leader shortcuts
nmap('<leader>p', builtin.buffers)
nmap('<C-p>', builtin.find_files)
-- nmap('<leader><space>', builtin.current_buffer_fuzzy_find)
nmap('<leader><space>', ':Telescope file_browser<cr>')
nmap('<leader>ff', builtin.live_grep)
nmap('<leader>hh', builtin.command_history)
