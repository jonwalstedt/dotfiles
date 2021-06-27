local nmap = U.keymap.nmap
local highlight = U.highlight

vim.g.gitgutter_map_keys = 0
highlight('GitGutterAddLine', { guifg = 'white', guibg = 'springgreen4' })
highlight('GitGutterChangeLine', { guifg = 'white', guibg = 'lightseablue' })
highlight('GitGutterDeleteLine', { guifg = '#ff0101', guibg = '#ffb733' })
highlight('GitGutterChangeDeleteLine', { guifg = 'black', guibg ='firebricks' })

nmap('<leader>nn', ':GitGutterNextHunk<CR>')
nmap('<leader>nn', ':GitGutterNextHunk<CR>')
nmap('<leader>np', ':GitGutterPrevHunk<CR>')
nmap('<leader>nf', ':GitGutterFold<CR>')
nmap('<leader>nq', ':GitGutterQuickFix<CR>')

