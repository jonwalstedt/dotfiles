local M = {}

-- Run a macro over every line in the visual selection.
-- Prompts for the register name, then replays it across '<,'>.
function M.execute_over_visual_range()
  local char = vim.fn.nr2char(vim.fn.getchar())
  vim.notify('@' .. char)
  vim.cmd("'<,'>normal @" .. char)
end

return M
