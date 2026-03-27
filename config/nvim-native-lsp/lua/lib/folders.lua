local M = {}

-- Create missing parent directories when writing a new file.
-- Skips special buffers and remote paths (scp://, http://, etc.).
function M.mk_non_ex_dir(file, buf)
  if vim.fn.getbufvar(buf, '&buftype') ~= '' then
    return
  end
  if file:match('^%w+:/') then
    return
  end
  local dir = vim.fn.fnamemodify(vim.fn.simplify(file), ':h')
  if vim.fn.isdirectory(dir) == 0 then
    local ok = pcall(vim.fn.mkdir, dir, 'p')
    if not ok then
      vim.notify('Failed to create directory: ' .. dir, vim.log.levels.WARN)
    end
  end
end

return M
