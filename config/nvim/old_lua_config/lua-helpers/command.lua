local function command(key, value)
    vim.cmd(string.format('command %s %s', key, value))
end

return {
    command = command
}
