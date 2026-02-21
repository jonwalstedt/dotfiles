local nmap = U.keymap.nmap
local imap = U.keymap.imap
local vmap = U.keymap.vmap
local xmap = U.keymap.xmap
local omap = U.keymap.omap
local tmap = U.keymap.tmap

-- Open Vimrc in split
nmap('<leader>ve', ':vsplit $MYVIMRC<CR>')

-- Source Vimrc
nmap('<leader>vs', ':source $MYVIMRC<CR>')

-- Use jj as escape
imap('jj', '<Esc>')

-- Update and go to previous file with backspace
nmap('<BS>', ':update<CR><c-^>')

-- Open previous file in vertical split with shift backspace
nmap('<leader><BS>', ':vsp<CR><c-^>')

-- Store current position to global mark J
nmap('<leader>j', 'mJ')

-- Go to global mark J
nmap('<leader>k', '`J')

-- Close and update buffer
nmap('<leader>q', 'ZZ<C-w><C-p>')

-- Update current buffer and close it without saving (needed to close terminal buffers)
nmap('<leader>dd', ':bd!<CR>')
-- nmap('bd', ':<C-u>call DeleteCurBufferNotCloseWindow()<CR>')

-- Write buffer and close window
nmap('<leader>w', ':update<CR>')

-- Refresh buffer
nmap('<leader>er', ':e<CR>:syntax on<CR>')

-- Execute current file in bash
nmap('<leader>ee', ':Exec<CR>')

-- Run Prettier
nmap('<leader>rr', ':Prettier<CR>')

-- Close all other windows
nmap('<leader>do', ':only<CR>')

-- Update current buffer and close all other buffers
nmap('<leader>d<CR>', ':wa<bar>lua FilterAndCloseBuffers()<CR>')

-- Move window to new tab
nmap('<leader>tt', '<C-w>T')

-- Use light theme
nmap('<leader>tl', ':colorscheme rose-pine-dawn<CR>')

-- Use dark theme
nmap('<leader>td', ':colorscheme rose-pine-moon<CR>')

-- Select last paste in visual mode
nmap('gb', "`[' . strpart(getregtype(), 0, 1) . '`]")

-- Escape to clear highlighting in normal mode
nmap('<esc>', ':nohlsearch<return><esc>')

-- New tab
nmap('<leader>tn', ':tabnew<CR>')

-- Previous tab (override unimpaired jump to next tag)
nmap('[t', ':tabp<CR>')

-- Next tab (override unimpaired jump to previous tag)
nmap(']t', ':tabn<CR>')

-- Run macro over selected rows using @
xmap('@', ':<C-u>call Macros#ExecuteMacroOverVisualRange()<CR>')

-- Emacs style movement in commandline (as in bash or Zsh)
-- cmap('<C-a>', '<Home>', {})
-- cmap('<C-b>', '<Left>', {})
-- cmap('<C-f>', '<Right>', {})
-- cmap('<C-d>', '<Delete>', {})
-- cmap('<M-b>', '<S-Left>', {})
-- cmap('<M-f>', '<S-Right>', {})
-- cmap('<M-d>', '<S-right><Delete>', {})
-- cmap('<Esc>b', '<S-Left>', {})
-- cmap('<Esc>f', '<S-Right>', {})
-- cmap('<Esc>d', '<S-right><Delete>', {})

-- Move to end of line
nmap('L', '$')
vmap('L', '$')
omap('L', '$')

-- Move to start of line
nmap('H', '^')
vmap('H', '^')
omap('H', '^')

-- Terminal
nmap('<Leader>t<Leader>', ':te<CR>')

-- Escape to exit to normal mode in terminal
tmap('<Esc>', '<C-\\><C-n>')
tmap('jj', '<C-\\><C-n>')

-- Yank to end of line
nmap('Y', 'y$')

-- Smooth way of creating and moving between splits
nmap('<C-h>', ':call Windows#Move("h")<CR>')
nmap('<C-j>', ':call Windows#Move("j")<CR>')
nmap('<C-k>', ':call Windows#Move("k")<CR>')
nmap('<C-l>', ':call Windows#Move("l")<CR>')

-- Search within selection
vmap(
  '<leader>/',
  ':<C-U>call Search#RangeSearch("/")<CR>:if strlen(g:srchstr) > 0|exec "/".g:srchstr|endif<CR>'
)
vmap(
  '<leader>?',
  ':<C-U>call Search#RangeSearch("?")<CR>:if strlen(g:srchstr) > 0|exec "?".g:srchstr|endif<CR>'
)

-- Grep word under cursor
nmap('<leader>g', ':call Search#SearchAndGrep("normal", 0)<CR>')
vmap('<leader>g', ':<c-u>call Search#SearchAndGrep(visualmode(), 0)<CR>')

nmap('<leader>l', ':call Search#SearchAndGrep("normal", 1)<CR>')
vmap('<leader>l', ':<c-u>call Search#SearchAndGrep(visualmode(), 1)<CR>')

-- Search for selection
vmap('*', 'y/\\V<C-R>=escape(@","/")<CR><CR>')

-- Search and highlight word under the cursor
nmap(
  '<leader><CR>',
  [[:let @/ = '\<'.expand('<cword>').'\>'|set hlsearch<C-M>]]
)

nmap('<leader>y', ':call Search#YankPattern()<CR>')

-- Substitute current search result
nmap('<leader>s', ':%s//')

-- Toggle LocationList
-- nmap('<leader>fl', ':call QuickFix#Toggle("Location List", "l")<CR>')

-- Toggle QuickFixList
nmap('<leader>f<leader>', ':call QuickFix#Toggle("Quickfix List", "c")<CR>')

-- Clear QuickFixList
nmap('<leader>fq', ':call setqflist([])<CR>')

-- Add current line to QuickFixList
nmap('<leader><tab>', ':call QuickFix#AddCurrentLineToQuickfixList()<CR>')

nmap('<leader>§', ":call setqflist([], 'r')<CR>")

-- Diff two open files
nmap('<leader>df', ':windo diffthis<CR>')
-- Close diff view
nmap('<leader>fd', ':windo diffoff<CR>')

nmap('<leader>cc', ':CopilotChatToggle<CR>')

-- Find next snake case word
nmap('<leader>[', 'f_xv~n')
nmap('<leader>]', '/\\w_<CR>')

tmap('›', '<Esc>b', { noremap = true })

-- Folding
vim.keymap.set("n", "<Space><Tab>", function()
  if vim.fn.foldlevel(".") == 0 then
    return
  end

  -- toggle fold under cursor, but don't error
  pcall(vim.cmd, "normal! za")
end, { desc = "Toggle fold under cursor", silent = true })

nmap('<leader>kb', ':Kibana<CR>')
