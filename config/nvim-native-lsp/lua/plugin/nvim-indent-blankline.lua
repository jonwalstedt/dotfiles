local highlight = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowBlue',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowViolet',
  'RainbowCyan',
}

local hooks = require 'ibl.hooks'
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#542429' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#594725' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#20425e' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#825a34' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#465e35' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#5f366b' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#2e595e' })
end)

require('ibl').setup {
  indent = {
    char = '┊',
    highlight = highlight,
    show_trailing_blankline_indent = false,
  },
  scope = {
    show_start = false,
  },
}
