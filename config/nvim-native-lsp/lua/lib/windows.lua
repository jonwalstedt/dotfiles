local M = {}

-- Move to an adjacent split, creating one if it doesn't exist.
-- If no split exists in the given direction, create a vertical split for
-- h/l and a horizontal split for j/k, then move into it.
function M.move(key)
  local curwin = vim.fn.winnr()
  vim.cmd('wincmd ' .. key)
  if curwin == vim.fn.winnr() then
    if key:match('[jk]') then
      vim.cmd('wincmd s')
    else
      vim.cmd('wincmd v')
    end
    vim.cmd('wincmd ' .. key)
  end
end

return M
