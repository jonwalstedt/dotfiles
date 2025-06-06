require('nvim-treesitter.configs').setup {
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  ensure_installed = 'all',
  indent = { enable = true },
  autopairs = { enable = true },
  -- autotag = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 800, -- Do not enable for files with more than 1000 lines, int
    colors = {
      '#bf616a',
      '#d08770',
      '#ebcb8b',
      '#a3be8c',
      '#88c0d0',
      '#5e81ac',
      '#b48ead',
    },
  },
  context_commentstring = { enable = true, enable_autocmd = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>', -- Start selection
      node_incremental = '<CR>', -- Expand to the next node
      -- scope_incremental = '<CR>', -- Also using <CR> for expanding to scope
      node_decremental = '<S-CR>', -- Shrink to the previous node
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

require('nvim-ts-autotag').setup {
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close on trailing </
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.d2 = {
  install_info = {
    url = 'https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = 'd2',
}
