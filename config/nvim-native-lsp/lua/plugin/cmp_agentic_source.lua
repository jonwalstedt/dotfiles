local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

function source:get_trigger_characters()
  return { '/' }
end

function source:get_keyword_pattern()
  return [==[[-a-zA-Z0-9_]\+]==]
end

function source:complete(params, callback)
  local line = params.context.cursor_before_line
  if not line:match('^/') or line:match('%s') then
    callback({ items = {}, isIncomplete = false })
    return
  end

  local commands = vim.b[0].agentic_slash_commands or {}
  local items = {}
  for _, cmd in ipairs(commands) do
    table.insert(items, {
      label = cmd.word,
      documentation = { kind = 'plaintext', value = cmd.info or cmd.menu or '' },
      kind = require('cmp.types').lsp.CompletionItemKind.Text,
    })
  end

  callback({ items = items, isIncomplete = false })
end

return source
