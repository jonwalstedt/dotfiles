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
  routes = {
    -- Suppress noisy write confirmations and LSP startup messages
    { filter = { event = 'msg_show', find = 'written' }, opts = { skip = true } },
    { filter = { event = 'msg_show', find = 'LSP started' }, opts = { skip = true } },
  },
})
