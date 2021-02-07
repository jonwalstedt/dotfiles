local function highlight(key, fg, bg)
  if bg == nil then
    vim.cmd(string.format('highlight %s guifg=%s', key, fg))
  else
    vim.cmd(string.format('highlight %s guifg=%s guibg=%s gui=NONE', key, fg, bg))
  end
end


return {
    highlight = highlight
}
