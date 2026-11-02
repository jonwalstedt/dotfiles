local U = require('utils')
local nmap = U.keymap.nmap
local imap = U.keymap.imap

-- Alt-p/n for history, ctrl-a select-all, --multi enables Tab for multi-select
vim.env.FZF_DEFAULT_OPTS =
  '--bind alt-p:up,alt-n:down,ctrl-a:select-all --layout=reverse --multi'

-- No --follow: symlink cycles in large repos (kibana, bazel, node_modules/.bin)
-- pin the CPU and balloon nvim's RAM. fd still respects .gitignore by default.
local fd_excludes = table.concat({
  '--exclude .git',
  '--exclude .DS_Store',
  '--exclude node_modules',
  '--exclude target',
  '--exclude dist',
  '--exclude coverage',
}, ' ')
local fd_base = 'fd --hidden ' .. fd_excludes

if vim.fn.executable('fd') == 1 then
  vim.env.FZF_DEFAULT_COMMAND = fd_base .. ' --type f'
else
  vim.env.FZF_DEFAULT_COMMAND = 'find . -type f -not -name ".DS_Store"'
end

vim.g.fzf_command_extra_args = '--bind="alt-p:preview-up,alt-n:preview-down"'
vim.g.fzf_history_dir = vim.env.HOME .. '/.local/share/fzf-history'

local function build_quickfix_list(lines)
  local qf = {}
  for _, f in ipairs(lines) do
    table.insert(qf, { filename = f, lnum = 1 })
  end
  vim.fn.setqflist(qf)
  vim.cmd 'copen'
  vim.cmd 'cfirst'
end

vim.g.fzf_action = {
  ['ctrl-q'] = function(lines) build_quickfix_list(lines) end,
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

-- ---------------------------------------------------------------------------
-- Background icon cache
-- Two jobstart calls (files + dirs) run on plugin load / DirChanged.
-- Results are written to a per-directory cache file.
-- ctrl+p uses `cat <cache>` when ready (icons + instant), falls back to a
-- streaming shell pipeline while the cache is still building.
-- ---------------------------------------------------------------------------
local _cache = { path = nil, cwd = nil, ready = false }
local _jobs = {}
local _generation = 0
local _rebuild_timer = nil
local MAX_CACHE_ENTRIES = 40000

local function cache_path_for(cwd)
  return vim.fn.stdpath('cache') .. '/fzf_files_' .. vim.fn.sha256(cwd):sub(1, 12)
end

local function stop_cache_jobs()
  for _, id in ipairs(_jobs) do
    pcall(vim.fn.jobstop, id)
  end
  _jobs = {}
end

local function build_icon_cache_async()
  if vim.fn.executable('fd') ~= 1 then return end

  _generation = _generation + 1
  local gen = _generation
  stop_cache_jobs()

  local cwd  = vim.fn.getcwd()
  local dest = cache_path_for(cwd)
  _cache.ready = false

  local ESC   = string.char(27)
  local gold  = ESC .. '[38;2;229;180;80m'
  local muted = ESC .. '[38;2;90;100;110m'
  local blue  = ESC .. '[38;2;100;149;237m'
  local reset = ESC .. '[0m'

  -- Icon lookup cached by extension — only a handful of WebDevIcons calls total
  local icon_ext_cache = {}
  local function get_icon(filename, is_dir)
    local key = is_dir and '__dir__' or (filename:match('%.([^.]+)$') or '__noext__')
    if not icon_ext_cache[key] then
      icon_ext_cache[key] = vim.fn.WebDevIconsGetFileTypeSymbol(filename, is_dir)
    end
    return icon_ext_cache[key]
  end

  local function basename(p) return p:match('([^/]+)$') or p end
  local function dirname(p)  return p:match('^(.+)/[^/]+$') or '.' end

  local file_results, dir_results, done = {}, {}, 0

  local function finalize()
    if #file_results + #dir_results > MAX_CACHE_ENTRIES then
      -- Too large to decorate in Lua; ctrl-p will keep using the streaming fd source
      return
    end
    local lines = {}
    for _, p in ipairs(file_results) do
      local fn   = basename(p)
      local dir  = dirname(p)
      local icon = get_icon(fn, false)
      local display = dir == '.'
        and (gold .. fn .. reset)
        or  (muted .. dir .. '/' .. reset .. gold .. fn .. reset)
      lines[#lines + 1] = icon .. ' ' .. display
    end
    for _, p in ipairs(dir_results) do
      local icon = get_icon(basename(p), true)
      lines[#lines + 1] = icon .. ' ' .. blue .. p .. reset
    end
    vim.fn.writefile(lines, dest)
    _cache.path  = dest
    _cache.cwd   = cwd
    _cache.ready = true
  end

  local function on_chunk(bucket)
    return function(_, data)
      if gen ~= _generation then return end
      for _, line in ipairs(data) do
        if line ~= '' then bucket[#bucket + 1] = line end
      end
    end
  end

  local function on_done()
    return function()
      if gen ~= _generation then return end
      done = done + 1
      if done == 2 then
        _jobs = {}
        finalize()
      end
    end
  end

  local opts = { cwd = cwd, stdout_buffered = true }
  _jobs = {
    vim.fn.jobstart(fd_base .. ' --type f', vim.tbl_extend('keep', {
      on_stdout = on_chunk(file_results),
      on_exit = on_done(),
    }, opts)),
    vim.fn.jobstart(fd_base .. ' --type d', vim.tbl_extend('keep', {
      on_stdout = on_chunk(dir_results),
      on_exit = on_done(),
    }, opts)),
  }
end

local function rebuild_cache()
  if _rebuild_timer then
    _rebuild_timer:stop()
  end
  _rebuild_timer = vim.defer_fn(function()
    _rebuild_timer = nil
    build_icon_cache_async()
  end, 300)
end

-- fzf.vim is lazy-loaded on BufRead, so VimEnter has already fired.
-- Rebuild when cwd changes; <leader>r refreshes manually. Do not scan on
-- BufWritePost / FocusGained — that stacked overlapping fd jobs in kibana.
vim.api.nvim_create_autocmd('DirChanged', {
  callback = rebuild_cache,
})
rebuild_cache()

-- Manual rebuild (e.g. after git pull, file deletions)
nmap('<leader>r', function()
  _cache.ready = false
  rebuild_cache()
  vim.notify('fzf: rebuilding file cache…')
end)

-- ---------------------------------------------------------------------------
-- ctrl+p entry point
-- ---------------------------------------------------------------------------
local function files_with_devicons()
  local ESC = string.char(27)

  local function strip_ansi(s)
    return s:gsub(ESC .. '%[[%d;]*m', '')
  end

  local source

  if _cache.ready and _cache.cwd == vim.fn.getcwd() then
    -- Cache is ready: instant popup with icons
    source = 'cat ' .. vim.fn.shellescape(_cache.path)
  else
    -- Fallback: streaming shell pipeline (instant popup, no icons)
    local file_awk = [[awk 'BEGIN{G="\033[38;2;229;180;80m";M="\033[38;2;90;100;110m";R="\033[0m"}{n=split($0,a,"/");if(n==1)print G $0 R;else{f=a[n];d=substr($0,1,length($0)-length(f)-1);print M d "/" R G f R}}']]
    local dir_awk  = [[awk 'BEGIN{B="\033[38;2;100;149;237m";R="\033[0m"}{print B $0 R}']]
    local base     = fd_base
    source = string.format(
      '{ %s --type f | %s; %s --type d | %s; }',
      base, file_awk, base, dir_awk
    )
  end

  -- Strip ANSI + optional icon prefix (icon<space>) from {} to get the raw path
  local deicon = 'printf "%s" {} | sed "s/\\x1b\\[[0-9;]*m//g" | sed "s/^[^ ]\\{1,\\} //"'
  local preview_cmd = string.format(
    'p=$(%s); [[ -d "$p" ]] && tree -C "$p" || (bat --theme=Dracula --style=numbers,changes --color=always "$p" | head -%d) 2>/dev/null',
    deicon, vim.o.lines
  )

  local opts = vim.fn['fzf#wrap']('files', {
    source = source,
    options = {
      '--ansi',
      '--preview', preview_cmd,
      '--multi',
      '--header', '? toggle preview | ctrl-a select all | ctrl-d deselect all | ctrl-q quickfix',
      '--bind', '?:toggle-preview,ctrl-d:deselect-all',
    },
  }, 0)

  opts['sink*'] = function(items)
    local key = table.remove(items, 1)
    for i, item in ipairs(items) do
      local plain = strip_ansi(item)
      -- Strip icon prefix if present (icon glyph + space before path)
      items[i] = plain:match('^%S+%s+(.+)$') or plain
    end
    if #items == 0 then return end
    if #items == 1 then
      local open = { ['ctrl-t'] = 'tabedit', ['ctrl-x'] = 'split', ['ctrl-v'] = 'vsplit' }
      vim.cmd((open[key] or 'edit') .. ' ' .. vim.fn.fnameescape(items[1]))
    else
      build_quickfix_list(items)
    end
  end
  opts['sink'] = nil

  vim.fn['fzf#run'](opts)
end

nmap('<C-p>', files_with_devicons)
nmap('<leader>p', ':Buffers<CR>')
nmap('<leader>o', ':GFiles?<CR>')
nmap('<leader>ff', ':Rg<CR>')
nmap('<leader>hh', ':History:<CR>')
nmap('<leader>fl', ':BLines<CR>')
nmap('<leader>fh', ':History<CR>')
nmap('<leader>fd', ':BD<CR>')
nmap('<leader>fb', ':FzfGBranches<CR>')

imap('<C-f>', '<Plug>(fzf-complete-path)', {})
imap('<C-l>', '<Plug>(fzf-complete-line)', {})
