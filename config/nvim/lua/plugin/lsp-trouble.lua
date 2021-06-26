local nmap = U.keymap.nmap

-- Trouble
require("trouble").setup { }
nmap('<leader>e<cr>', ':LspTroubleOpen<cr>')
