local nmap = U.keymap.nmap

vim.g.dirvish_relative_paths = 0
vim.g.dirvish_mode = vim.api.nvim_replace_termcodes(
  ':sort ,^.*[/],',
  true,
  false,
  true
)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nmap('<leader>f<CR>', 'Z!')
