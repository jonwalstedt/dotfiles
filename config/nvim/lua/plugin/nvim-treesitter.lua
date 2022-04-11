require('nvim-treesitter.configs').setup {
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  ensure_installed = 'all',
  indent = { enable = true },
  autopairs = { enable = true },
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
  autotag = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      scope_incremental = 'grc',
      node_incremental = 'grn',
      node_decremental = 'grm',
    },
  },
}
