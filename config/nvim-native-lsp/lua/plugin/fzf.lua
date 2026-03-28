local U = require('utils')
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

-- Files + colored paths + bat/tree preview.
-- Source is a shell pipeline so fzf opens instantly and results stream in.
-- Single selection → open directly. Tab multi-select → quickfix.
local function files_with_devicons()
  local ESC = string.char(27)

  local function strip_ansi(s)
    return s:gsub(ESC .. '%[[%d;]*m', '')
  end

  -- awk programs that colorize fd output in the shell (no Lua per-entry work)
  local file_awk = [[awk 'BEGIN{G="\033[38;2;229;180;80m";M="\033[38;2;90;100;110m";R="\033[0m"}{n=split($0,a,"/");if(n==1)print G $0 R;else{f=a[n];d=substr($0,1,length($0)-length(f)-1);print M d "/" R G f R}}']]
  local dir_awk  = [[awk 'BEGIN{B="\033[38;2;100;149;237m";R="\033[0m"}{print B $0 R}']]

  local source
  if vim.fn.executable('fd') == 1 then
    local base = 'fd --hidden --follow --exclude .git --exclude .DS_Store'
    source = string.format(
      '{ %s --type f | %s; %s --type d --max-depth 4 | %s; }',
      base, file_awk, base, dir_awk
    )
  else
    source = 'find . -not -name ".DS_Store" -not -path "*/.git/*" | sort'
  end

  -- Strip ANSI from {} in the preview to get the raw path
  local preview_cmd = string.format(
    'p=$(printf "%%s" {} | sed "s/\\x1b\\[[0-9;]*m//g"); [[ -d "$p" ]] && tree -C "$p" || (bat --theme=Dracula --style=numbers,changes --color=always "$p" | head -%d) 2>/dev/null',
    vim.o.lines
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
      items[i] = strip_ansi(item)
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
