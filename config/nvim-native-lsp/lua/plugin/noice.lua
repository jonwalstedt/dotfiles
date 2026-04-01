require('noice').setup({
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = true,       -- keep / and ? in the classic bottom position
    long_message_to_split = true,
  },
  views = {
    notify = {
      position = {
        row = -2,
        col = 1,
      },
      anchor = 'SW',
    },
  },
  routes = {
    -- Suppress noisy write confirmations and LSP startup messages
    { filter = { event = 'msg_show', find = 'written' }, opts = { skip = true } },
    { filter = { event = 'msg_show', find = 'LSP started' }, opts = { skip = true } },
    -- Send shell command output to a split
    { filter = { event = 'msg_show', kind = { 'shell_out', 'shell_err' } }, view = 'split' },
  },
})
