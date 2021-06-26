local nmap = U.keymap.nmap
local highlight = U.highlight

vim.g.gitgutter_map_keys = 0
highlight('GitGutterAddLine', 'white', 'springgreen4')
highlight('GitGutterChangeLine', 'white', 'lightseablue')
highlight('GitGutterDeleteLine', '#ff0101', '#ffb733')
highlight('GitGutterChangeDeleteLine', 'black', 'firebricks')

nmap('<leader>nn', ':GitGutterNextHunk<CR>')
nmap('<leader>nn', ':GitGutterNextHunk<CR>')
nmap('<leader>np', ':GitGutterPrevHunk<CR>')
nmap('<leader>nf', ':GitGutterFold<CR>')
nmap('<leader>nq', ':GitGutterQuickFix<CR>')

