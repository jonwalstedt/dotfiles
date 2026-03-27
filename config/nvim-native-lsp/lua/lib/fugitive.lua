local M = {}

-- Prompt for a git hash and open a vertical diff split against it.
function M.diff_with_hash()
  local hash = vim.fn.input('Enter hash: ')
  if hash ~= '' then
    vim.cmd('Gvdiffsplit ' .. hash)
  end
end

return M
