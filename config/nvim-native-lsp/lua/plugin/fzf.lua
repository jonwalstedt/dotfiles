local nmap = U.keymap.nmap
local imap = U.keymap.imap

-- nmap('<C-p>', ':call CustomFZF#FilesWithDevIcons()<CR>')
nmap('<C-p>', ':FZF<CR>')
nmap('<leader>p', ':Buffers<CR>')
nmap('<leader>ff', ':Ag<CR>')
nmap('<leader>fg', ':Ag<CR>')
nmap('<leader>hh', ':History:<CR>')
nmap('<leader>fl', ':BLines<CR>')
nmap('<leader>fh', ':History<CR>')
nmap('<leader>fd', ':BD<CR>')
nmap('<leader>fb', ':FzfGBranches<CR>')

imap('<C-f>', '<Plug>(fzf-complete-path)', {})
imap('<C-l>', '<Plug>(fzf-complete-line)', {})
