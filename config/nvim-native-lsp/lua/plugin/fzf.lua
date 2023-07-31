local nmap = U.keymap.nmap
local imap = U.keymap.imap

-- nmap("<C-p>", ":call CustomFZF#FilesWithDevIcons()<CR>")
nmap("<C-p>", ":FzfLua files<CR>")
nmap("<leader>p", ":FzfLua buffers<CR>")
nmap("<leader>ff", ":FzfLua live_grep<CR>")
-- nmap("<leader>fg", ":FZFAg<CR>")
nmap("<leader>hh", ":FzfLua command_history<CR>")
nmap("<leader>fl", ":FzfLua lines<CR>")
nmap("<leader>fh", ":FzfLua command_history<CR>")

imap("<C-f>", ":FzfLua complete_path<CR>")
imap("<C-l>", ":FzfLua complete_line<CR>")
