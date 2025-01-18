vim.g.dirvish_relative_paths = 1
-- vim.g.dirvish_mode = 1
vim.g.dirvish_mode = ':sort ,^\v(.*[/])|\ze,'
-- vim.g.dirvish_mode =
--   vim.api.nvim_replace_termcodes(':sort ,^.*[/],', true, false, true)

-- vim.g.loaded_netrwPlugin = 0

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dirvish',
  callback = function()
    -- ensure syntax is enabled
    vim.cmd 'syntax enable'
    -- this makes sure the text is actually hidden
    vim.opt_local.conceallevel = 3
    -- makes conceal apply in normal and visual mode
    vim.opt_local.concealcursor = 'nv'
  end,
})
