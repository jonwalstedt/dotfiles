local nmap = U.keymap.nmap

local function showFugitiveGit()
  if vim.fn.FugitiveHead() ~= '' then
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
end

local function toggleFugitiveGit()
  if vim.fn.buflisted(vim.fn.bufname('fugitive:///*/.git//$')) ~= 0 then
    vim.cmd[[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
  else
    showFugitiveGit()
  end
end

nmap('<space><space>', toggleFugitiveGit)
nmap('§<space>', ':call CustomFugitive#ToggleGStatus()<cr>')
nmap('<localleader>v', ':Gdiffsplit!<CR>')
nmap('<localleader>h', ':diffget //2<CR>')
nmap('<localleader>l', ':diffget //3<CR>')
nmap('<localleader>g', ':Gclog -10 -- %<CR>')
