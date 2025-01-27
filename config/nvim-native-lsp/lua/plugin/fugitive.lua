local nmap = U.keymap.nmap
local highlight = U.highlight
local palette = U.palette

local function toggleFugitiveGit()
  vim.cmd [[
  Git
  " wincmd H  " Open Git window in vertical split
  " setlocal winfixwidth
  " vertical resize 31
  " setlocal winfixwidth
  setlocal nonumber
  setlocal norelativenumber
  ]]
end

nmap('<space><space>', toggleFugitiveGit)
nmap('<localleader>v', ':Gdiffsplit!<CR>')
nmap('<localleader>h', ':diffget //2<CR>')
nmap('<localleader>l', ':diffget //3<CR>')
nmap('<localleader>g', ':Gclog -10 -- %<CR>')

highlight('DiffAdd', { guifg = palette.green })
highlight('DiffChange', { guifg = palette.yellow })
highlight('DiffDelete', { guifg = palette.red })
