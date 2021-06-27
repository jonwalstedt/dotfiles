U = {}

-- Os
U.os = {
  home = os.getenv('HOME'),
  data = vim.fn.stdpath('data'),
  cache = vim.fn.stdpath('cache'),
  config = vim.fn.stdpath('config'),
  name = vim.loop.os_uname().sysname,
  is_git_dir = os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1'),
}

-- Autocmds
function U.nvim_create_augroup(definitions) -- {{{1
  for group_name, definition in pairs(definitions) do
    vim.cmd('augroup ' .. group_name)
    vim.cmd('autocmd!')

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
      vim.cmd(command)
    end

    vim.cmd('augroup END')
  end
end

-- Keybindings
local function map_keys(mode, command, value, opts)
  if opts == nil then
    opts = {noremap = true, silent = true}
  end
  vim.api.nvim_set_keymap(mode, command, value, opts)
end

local function map(command, value, opts)
  map_keys('', command, value, opts)
end

local function nmap(command, value, opts)
  map_keys('n', command, value, opts)
end

local function imap(command, value, opts)
  map_keys('i', command, value, opts)
end

local function vmap(command, value, opts)
  map_keys('v', command, value, opts)
end

local function tmap(command, value, opts)
  map_keys('t', command, value, opts)
end

local function cmap(command, value, opts)
  map_keys('c', command, value, opts)
end

local function xmap(command, value, opts)
  map_keys('x', command, value, opts)
end

local function omap(command, value, opts)
  map_keys('o', command, value, opts)
end

local function smap(command, value, opts)
  map_keys('s', command, value, opts)
end

local function buf_nmap(lhs, rhs, opts)
  return map_keys('n', lhs, rhs, opts, 'buffer')
end


U.keymap = {
  map = map,
  nmap = nmap,
  imap = imap,
  vmap = vmap,
  tmap = tmap,
  cmap = cmap,
  xmap = xmap,
  omap = omap,
  smap = smap,
  buf_nmap = buf_nmap,
}

local function isempty(s)
  return s == nil or s == ''
end
-- Highlights
function U.highlight(key, opts)
  local highlight = 'highlight '..key..' '
  for k, val in pairs(opts) do
    highlight = highlight..k.."="..val.." "
  end
  vim.cmd(highlight)
end

U.palette = {
  green = '#30d130',
  cyan = '#30d130',
  yellow = '#f5ee27',
  red = '#f52727',
}


function U.command(key, value)
  vim.cmd(string.format('command! %s %s', key, value))
end

function U.set(key, value)
    if value == true or value == nil then
  vim.cmd(string.format('set %s', key))
    elseif value == false then
  vim.cmd(string.format('set no%s', key))
    else
  vim.cmd(string.format('set %s=%s', key, value))
    end
end
