local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- FileType-specific settings
local ftplugin = augroup('ftplugin', { clear = true })
autocmd('FileType', {
  group = ftplugin,
  pattern = 'man',
  callback = function()
    vim.opt_local.laststatus = 0
    vim.opt_local.ruler = false
  end,
})
autocmd('FileType', {
  group = ftplugin,
  pattern = { 'vim', 'lua', 'css', 'javascript' },
  callback = function() vim.opt_local.shiftwidth = 2 end,
})
autocmd('TermOpen', {
  group = ftplugin,
  pattern = 'term://*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.opt_local.scrolloff = 0
    vim.opt_local.signcolumn = 'no'
  end,
})

-- Source vimscript config files immediately on save
autocmd('BufWritePost', {
  group = augroup('on_save', { clear = true }),
  pattern = { '*.vim' },
  command = 'source %',
})

-- Reload xresources
autocmd('BufWritePost', {
  group = augroup('xresources', { clear = true }),
  pattern = { '*Xresources', '*Xdefaults' },
  command = 'silent! !xrdb -load %',
})

-- Terminal window settings
autocmd('TermOpen', {
  group = augroup('terminal', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
  end,
})

-- Create missing parent directories on write
autocmd('BufWritePre', {
  group = augroup('bwc_create_dir', { clear = true }),
  pattern = '*',
  callback = function(args)
    require('lib.folders').mk_non_ex_dir(args.file, args.buf)
  end,
})

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function() vim.hl.on_yank() end,
})

-- Prose display: word-boundary wrapping + no link underlines
autocmd('FileType', {
  group = ftplugin,
  pattern = { 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    -- Strip underline/undercurl from treesitter markdown link highlights
    -- (preserves fg/bg/bold; only removes the decoration)
    local groups = {
      '@markup.link',
      '@markup.link.label',
      '@markup.link.label.markdown_inline',
      '@markup.link.url',
      '@markup.underline',
    }
    for _, group in ipairs(groups) do
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      if next(hl) ~= nil then
        hl.underline = nil
        hl.undercurl = nil
        vim.api.nvim_set_hl(0, group, hl)
      end
    end
  end,
})
