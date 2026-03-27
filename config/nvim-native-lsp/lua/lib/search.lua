local M = {}

-- Prompt for a pattern and constrain it to the current visual selection range.
-- The result is stored in vim.g.srchstr for the caller to execute.
function M.range_search(direction)
  local srchstr = vim.fn.input(direction)
  if #srchstr > 0 then
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    vim.g.srchstr = srchstr
      .. '\\%>' .. (start_line - 1) .. 'l'
      .. '\\%<' .. (end_line + 1) .. 'l'
  else
    vim.g.srchstr = ''
  end
end

-- Grep for the word under cursor (normal) or the visual selection (v/char).
-- local_search=1 restricts to current file, 0 searches the whole project.
function M.search_and_grep(type, local_search)
  local saved = vim.fn.getreg('@')
  local word

  if type == 'v' then
    vim.cmd('normal! `<v`>y')
    word = vim.fn.getreg('@')
    vim.fn.setreg('/', word)
  elseif type == 'char' then
    vim.cmd('normal! `[v`]y')
    word = vim.fn.getreg('@')
    vim.fn.setreg('/', word)
  elseif type == 'normal' then
    word = vim.fn.expand('<cword>')
    vim.fn.setreg('/', '\\<' .. word .. '\\>')
  else
    return
  end

  if local_search == 1 then
    vim.cmd('silent! grep! ' .. vim.fn.shellescape(word) .. ' %')
  else
    if type == 'normal' then
      vim.cmd('silent! grep! -R -w ' .. vim.fn.shellescape(word) .. ' .')
    else
      vim.cmd('silent! grep! -R ' .. vim.fn.shellescape(word) .. ' .')
    end
  end

  vim.cmd('copen 28')
  vim.opt.hlsearch = true
  vim.fn.setreg('@', saved)
end

return M
