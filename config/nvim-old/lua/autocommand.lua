vim.cmd[[augroup highlight_yank]]
  vim.cmd[[autocmd!]]
  vim.cmd[[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()]]
vim.cmd[[augroup END]]

vim.cmd[[augroup diagnostics]]
  vim.cmd[[autocmd!]]
  vim.cmd[[autocmd CursorHold * silent! lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd[[augroup END]]

-- vim.cmd[[augroup formatting_sync]]
--   vim.cmd[[autocmd!]]
--   vim.cmd[[autocmd BufWritePost * silent! lua vim.lsp.buf.formatting_sync()]]
-- vim.cmd[[augroup END]]


