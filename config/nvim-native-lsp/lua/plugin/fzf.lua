local nmap = U.keymap.nmap
local imap = U.keymap.imap

-- Ensure fzf uses Alt-p and Alt-n to go through history instead of Ctrl-p/Ctrl-n
vim.env.FZF_DEFAULT_OPTS =
  '--bind alt-p:up,alt-n:down,ctrl-a:select-all --layout=reverse'

-- Set the custom fzf keybindings
vim.g.fzf_command_extra_args = '--bind="alt-p:preview-up,alt-n:preview-down"'

-- Configure fzf history directory
vim.g.fzf_history_dir = vim.env.HOME .. '/.local/share/fzf-history'

-- nmap('<C-p>', ':call CustomFZF#FilesWithDevIcons()<CR>')
nmap('<C-p>', ':FZF<CR>')
nmap('<leader>p', ':Buffers<CR>')
nmap('<leader>o', ':GFiles?<CR>')
nmap('<leader>ff', ':Ag<CR>')
nmap('<leader>fg', ':Ag<CR>')
nmap('<leader>hh', ':History:<CR>')
nmap('<leader>fl', ':BLines<CR>')
nmap('<leader>fh', ':History<CR>')
nmap('<leader>fd', ':BD<CR>')
nmap('<leader>fb', ':FzfGBranches<CR>')

imap('<C-f>', '<Plug>(fzf-complete-path)', {})
imap('<C-l>', '<Plug>(fzf-complete-line)', {})

-- Function to build the quickfix list
local function build_quickfix_list(lines)
  local quickfix_list = {}
  for _, line in ipairs(lines) do
    table.insert(quickfix_list, { filename = line })
  end
  vim.fn.setqflist(quickfix_list)
  vim.cmd 'copen'
  vim.cmd 'cc'
end

-- Configure fzf actions
vim.g.fzf_action = {
  ['ctrl-q'] = function(lines)
    build_quickfix_list(lines)
  end,
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}
