local M = {}

local prose_filetypes = {
  markdown = true,
  text = true,
  gitcommit = true,
}

local function is_prose_buffer(bufnr)
  local ft = vim.bo[bufnr].filetype
  return prose_filetypes[ft] == true
end

local function clamp(n, min, max)
  if n < min then
    return min
  end
  if n > max then
    return max
  end
  return n
end

function M.apply_to_current_window()
  local bufnr = vim.api.nvim_get_current_buf()
  if not is_prose_buffer(bufnr) then
    return
  end

  local target_width = 100
  local win_width = vim.api.nvim_win_get_width(0)

  local pad = math.floor((win_width - target_width) / 2)
  pad = clamp(pad, 0, 20)

  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.breakindent = false
  vim.opt_local.breakindentopt = ""
  vim.opt_local.showbreak = ""
  vim.opt_local.textwidth = 0

  vim.opt_local.wrapmargin = pad

  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.cursorline = false
  vim.opt_local.list = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"

  vim.opt_local.statuscolumn = string.rep(" ", pad)
  vim.opt_local.colorcolumn = ""

  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
end

function M.clear_in_current_window()
  vim.opt_local.wrapmargin = 0
  vim.opt_local.statuscolumn = ""
  vim.opt_local.colorcolumn = ""
end

function M.setup()
  local group = vim.api.nvim_create_augroup("WritingLayout", { clear = true })

  vim.api.nvim_create_autocmd({
    "BufWinEnter",
    "WinEnter",
    "VimResized",
    "WinResized",
    "FileType",
  }, {
    group = group,
    callback = function()
      pcall(M.apply_to_current_window)
    end,
  })
end

return M
