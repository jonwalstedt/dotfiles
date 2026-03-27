local nmap = U.keymap.nmap
local imap = U.keymap.imap

-- Alt-p/n for history, ctrl-a select-all, --multi enables Tab for multi-select
vim.env.FZF_DEFAULT_OPTS =
  '--bind alt-p:up,alt-n:down,ctrl-a:select-all --layout=reverse --multi'

if vim.fn.executable('fd') == 1 then
  vim.env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git --exclude .DS_Store'
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

-- Files + devicons + bat/tree preview.
-- Single selection → open directly. Tab multi-select → quickfix.
local function files_with_devicons()
  local ESC = string.char(27)
  local gold  = ESC .. '[38;2;229;180;80m'
  local muted = ESC .. '[38;2;90;100;110m'
  local reset = ESC .. '[0m'

  local function strip_ansi(s)
    return s:gsub(ESC .. '%[[%d;]*m', '')
  end

  local function prepend_icon(candidates)
    local result = {}
    for _, candidate in ipairs(candidates) do
      local filename = vim.fn.fnamemodify(candidate, ':t')
      local dir      = vim.fn.fnamemodify(candidate, ':h')
      local icon = vim.fn.WebDevIconsGetFileTypeSymbol(filename, vim.fn.isdirectory(filename))
      local display
      if dir == '.' then
        display = gold .. filename .. reset
      else
        display = muted .. dir .. '/' .. reset .. gold .. filename .. reset
      end
      table.insert(result, string.format('%s %s', icon, display))
    end
    return result
  end

  local fzf_cmd = vim.env.FZF_DEFAULT_COMMAND or 'find . -type f'
  local candidates = prepend_icon(vim.fn.systemlist(fzf_cmd))

  -- bat for files (no inner quotes needed), tree for directories
  -- {2..-1} skips field 1 (the icon) and uses the rest as the file path
  local preview_cmd = string.format(
    '[[ -f {2..-1} ]] && (bat --theme=Dracula --style=numbers,changes --color=always {2..-1} | head -%d) || tree -C {2..-1} || echo {} 2>/dev/null | head -200',
    vim.o.lines
  )

  -- Pass options as a list so fzf.vim handles shell escaping correctly
  local opts = vim.fn['fzf#wrap']('files', {
    source = candidates,
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
    -- Strip icon prefix and ANSI color codes to recover the plain file path
    for i, item in ipairs(items) do
      items[i] = strip_ansi(item:match('^%S+%s+(.+)$') or item)
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
