local function highlight(key, fg, bg)
  if bg == nil then
    vim.cmd(string.format('highlight %s guifg=%s', key, fg))
  else
    vim.cmd(string.format('highlight %s guifg=%s guibg=%s gui=NONE', key, fg, bg))
  end
end

local palette = {
    green = '#30d130',
    cyan = '#30d130',
    yellow = '#f5ee27',
    red = '#f52727',
}

return {
    highlight = highlight,
    palette = palette,
}
