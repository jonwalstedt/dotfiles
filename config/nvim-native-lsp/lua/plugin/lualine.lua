local function dev_mode_status()
  local ok, dev_mode = pcall(require, 'core.dev_mode')
  if not ok then return '' end
  return dev_mode.is_enabled() and 'DEV' or 'dev off'
end

local function dev_mode_color()
  local ok, dev_mode = pcall(require, 'core.dev_mode')
  if ok and dev_mode.is_enabled() then
    return { fg = '#30d130', gui = 'bold' }
  end
  return { fg = '#585858' }
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'ayu',
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = { 'ordna', 'ordna-help' },
      winbar = { 'ordna', 'ordna-help' },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = {
      { dev_mode_status, color = dev_mode_color },
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
