local function nmap(command, value, expr)
    vim.fn.nvim_set_keymap('n',command,value,{noremap = true, silent = true, expr = expr})
end

local function imap(command, value, expr)
    vim.fn.nvim_set_keymap('i',command,value,{noremap = true, silent = true, expr = expr})
end

local function vmap(command, value, expr)
    vim.fn.nvim_set_keymap('v',command,value,{noremap = true, silent = true, expr = expr})
end

local function tmap(command, value, expr)
    vim.fn.nvim_set_keymap('t',command,value,{noremap = true, silent = true, expr = expr})
end

imap('<C-Space>', [[compe#complete()]], true)
imap('<CR>', [[compe#confirm('<CR>')]], true)
imap('<C-e>',[[compe#close('<C-e>')]], true)

return {
    nmap = nmap,
    imap = imap,
    vmap = vmap,
    tmap = tmap,
}
