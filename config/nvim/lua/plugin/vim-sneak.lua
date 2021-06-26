local nmap = U.keymap.nmap
local xmap = U.keymap.xmap
local omap = U.keymap.omap

vim.g['sneak#s_next'] = 0
vim.g['sneak#use_ic_scs'] = 1
nmap('s', '<Plug>Sneak_s', {})
nmap('S', '<Plug>Sneak_S', {})


-- visual-mode
xmap('s', '<Plug>Sneak_s', {})
xmap('S', '<Plug>Sneak_S', {})


-- operator-pending-mode
omap('s', '<Plug>Sneak_s', {})
omap('S', '<Plug>Sneak_S', {})
