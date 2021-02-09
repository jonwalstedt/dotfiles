local function map_keys(mode, command, value, opts)
    if opts == nil then
        opts = {noremap = true, silent = true}
    end
    vim.api.nvim_set_keymap(mode, command, value, opts)
end

local function map(command, value, opts)
    map_keys('', command, value, opts)
end

local function nmap(command, value, opts)
    map_keys('n', command, value, opts)
end

local function imap(command, value, opts)
    map_keys('i', command, value, opts)
end

local function vmap(command, value, opts)
    map_keys('v', command, value, opts)
end

local function tmap(command, value, opts)
    map_keys('t', command, value, opts)
end

local function cmap(command, value, opts)
    map_keys('c', command, value, opts)
end

local function xmap(command, value, opts)
    map_keys('x', command, value, opts)
end

local function omap(command, value, opts)
    map_keys('o', command, value, opts)
end

local function smap(command, value, opts)
    map_keys('s', command, value, opts)
end

return {
    map = map,
    nmap = nmap,
    imap = imap,
    vmap = vmap,
    tmap = tmap,
    cmap = cmap,
    xmap = xmap,
    omap = omap,
    smap = smap,
}
