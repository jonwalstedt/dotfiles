local nmap = U.keymap.nmap

vim.g.dirvish_relative_paths = 1
vim.g.dirvish_mode = vim.api.nvim_replace_termcodes(
  ":sort ,^.*[/],",
  true,
  false,
  true
)
vim.g.loaded_netrwPlugin = 0
nmap("<leader>f<CR>", "Z!")
