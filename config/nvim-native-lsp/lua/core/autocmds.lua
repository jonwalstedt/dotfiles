U.nvim_create_augroup {
  ftplugin = {
    { 'FileType', 'man', 'setl laststatus=0 noruler' },
    { 'FileType', 'NvimTree', 'setl scl=no' },
    { 'FileType', 'vim,lua,css,javascript', 'setl sw=2' },
    {
      'TermOpen',
      'term://*',
      'setl nornu nonu nocul so=0 scl=no',
    },
  },

  on_save = { { 'BufWritePost', '*.vim,*.lua', 'source %' } },

  xresources = {
    { 'BufWritePost', '*Xresources,*Xdefaults', 'silent! !xrdb -load %' },
  },

  terminal = {
    { 'TermOpen', '*', 'setlocal nonumber | setlocal signcolumn=no' },
  },

  bwc_create_dir = {
    {
      'BufWritePre',
      '*',
      ':call Folders#MkNonExDir(expand("<afile>"), +expand("<abuf>"))',
    },
  },

  dirvish_config = {
    { 'FileType', 'dirvish', 'silent! unmap <buffer> <C-p>' },
    { 'FileType', 'dirvish', 'silent! unmap <buffer> <C-n>' },
  },

  -- window_management = {
  --   { 'WinEnter', '*', ':call WindowManagement#Handle_Win_Enter()' },
  --   -- { 'WinLeave', '*',  ':call WindowManagement#Handle_Win_Leave()' }
  -- },
}

-- Highlight on yank
local highlight_group =
  vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
