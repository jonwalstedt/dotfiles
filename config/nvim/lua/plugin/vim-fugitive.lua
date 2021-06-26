local nmap = U.keymap.nmap

nmap('<localleader><space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('§<space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('<localleader>v', ':Gdiffsplit!<CR>')
nmap('<localleader>h', ':diffget //2<CR>')
nmap('<localleader>l', ':diffget //3<CR>')
nmap('<localleader>g', ':Gclog -10 -- %<CR>')
