require('nvim-ts-autotag').setup {
  ensure_installed = {
    'typescript',
    'tsx',
    'javascript',
    'python',
    'html',
    'css',
    'scss',
    'json',
    'lua',
    'terraform',
  },
  highlight = {
    enable = true, -- False will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      scope_incremental = '<CR>',
      node_decremental = '<S-CR>',
    },
  },
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ['html'] = {
      enable_close = false,
    },
  },
}
