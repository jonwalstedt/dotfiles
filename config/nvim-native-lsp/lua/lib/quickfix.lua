local M = {}

-- Toggle the quickfix list (pfx='c') or location list (pfx='l').
-- Uses getwininfo() rather than scanning buffer names.
function M.toggle(pfx)
  for _, win in ipairs(vim.fn.getwininfo()) do
    if pfx == 'c' and win.quickfix == 1 and win.loclist == 0 then
      vim.cmd('cclose')
      return
    elseif pfx == 'l' and win.loclist == 1 then
      vim.cmd('lclose')
      return
    end
  end

  if pfx == 'l' and #vim.fn.getloclist(0) == 0 then
    vim.notify('Location List is Empty.', vim.log.levels.ERROR)
    return
  end

  local curwin = vim.fn.winnr()
  vim.cmd(pfx == 'c' and 'copen' or 'lopen')
  if vim.fn.winnr() ~= curwin then
    vim.cmd('wincmd p')
  end
end

-- Append the current cursor line to the quickfix list.
function M.add_current_line()
  local lnum = vim.fn.getpos('.')[2]
  local fname = vim.fn.expand('%:p')
  local qflist = vim.fn.getqflist()
  table.insert(qflist, { filename = fname, lnum = lnum })
  vim.fn.setqflist(qflist)
end

return M
