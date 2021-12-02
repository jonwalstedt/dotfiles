return function(client)
  vim.notify(
    client.name .. ': Language Server Client successfully started!',
    'info'
  )
end
