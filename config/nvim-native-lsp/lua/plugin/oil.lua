require('oil').setup {
  -- Use oil as the default file explorer (replaces netrw)
  default_file_explorer = true,
  -- Show hidden files
  view_options = {
    show_hidden = true,
    -- Sort directories first
    sort = {
      { 'type', 'asc' },
      { 'name', 'asc' },
    },
  },
  columns = {
    'icon',
  },
  -- Keep netrw disabled
  restore_win_options = true,
  skip_confirm_for_simple_edits = false,
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = false, -- don't shadow window navigation
    ['<C-t>'] = 'actions.select_tab',
    ['<leader>i'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = false, -- don't shadow window navigation
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
    ['g\\'] = 'actions.toggle_trash',
    ['yy'] = function()
      local entry = require('oil').get_cursor_entry()
      local dir = require('oil').get_current_dir()
      if entry and dir then
        local path = dir .. entry.name
        vim.fn.setreg('+', path)
        vim.fn.setreg('"', path)
        vim.notify('Copied: ' .. path)
      end
    end,
    ['yY'] = function()
      local entry = require('oil').get_cursor_entry()
      local dir = require('oil').get_current_dir()
      if entry and dir then
        local path = vim.fn.fnamemodify(dir .. entry.name, ':.')
        vim.fn.setreg('+', path)
        vim.fn.setreg('"', path)
        vim.notify('Copied: ' .. path)
      end
    end,
  },
  use_default_keymaps = false,
}

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
