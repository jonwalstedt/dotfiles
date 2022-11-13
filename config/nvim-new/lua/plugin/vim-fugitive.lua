local nmap = U.keymap.nmap
local highlight = U.highlight
local palette = U.palette

nmap('<localleader><space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('§<space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('<localleader>v', ':Gdiffsplit!<CR>')
nmap('<localleader>h', ':diffget //2<CR>')
nmap('<localleader>l', ':diffget //3<CR>')
nmap('<localleader>g', ':Gclog -10 -- %<CR>')

highlight('DiffAdd', { guifg = palette.green })
highlight('DiffChange', { guifg = palette.yellow })
highlight('DiffDelete', { guifg = palette.red })
