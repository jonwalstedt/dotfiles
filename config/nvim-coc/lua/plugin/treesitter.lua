require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "typescript", "tsx", "javascript", "python", "html", "css", "scss", "json", "lua", "terraform"
  },
  highlight = {
    enable = true, -- False will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<CR>",
      node_decremental = "<S-CR>",
    },
  },
}
