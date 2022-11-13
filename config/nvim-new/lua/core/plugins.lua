vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/opt/*'

local packer = require 'packer'
local plugin_path = U.os.data .. '/site/pack/packer/opt/'
local packer_compiled = U.os.data .. '/site/plugin/packer_compiled.vim'

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  packer.init { compile_path = packer_compiled, opt_default = true }

  -- Plugin Manager
  use { 'wbthomason/packer.nvim' }

  -- Collection of configurations for built-in LSP client
  use { 'neovim/nvim-lspconfig', setup = [[require('plugin.nvim-lspconfig')]] }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    setup = [[require('plugin.null-ls')]],
  }
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    setup = [[require('plugin.nvim-treesitter')]],
  }

  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Git commands in nvim
  use { 'tpope/vim-fugitive', setup = [[require('plugin.vim-fugitive')]] }

  -- UI to select things (files, grep results, open buffers...)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    setup = [[require('plugin.nvim-telescope')]],
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }

  -- Theme inspired by Atom
  use 'mjlbach/onedark.nvim'
  use 'folke/tokyonight.nvim'

  -- Movement
  use {
    'justinmk/vim-sneak',
    setup = [[require('plugin.vim-sneak')]],
  }

  -- Fancier statusline
  use { 'nvim-lualine/lualine.nvim', setup = [[require('plugin.lualine')]] }

  -- Add indentation guides even on blank lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    setup = [[require('plugin.nvim-indent-blankline')]],
  }

  -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim',
    setup = [[require('plugin.gitsigns')]],
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  }

  -- Autocomplete
  use 'rafamadriz/friendly-snippets'

  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/cmp-calc' }
  use { 'hrsh7th/cmp-cmdline' }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'plugin.nvim-cmp'
    end,
  }

  -- File browser
  use { 'justinmk/vim-dirvish', setup = [[require('plugin.dirvish')]] }

  -- "gc" to comment visual regions/lines
  use { 'numToStr/Comment.nvim', setup = [[require('plugin.comment')]] }

  -- Quickfix list
  use 'romainl/vim-qlist'
  use 'romainl/vim-qf'

  -- Show search result count
  use 'google/vim-searchindex'

  -- Complementary pairs of mappings
  use 'tpope/vim-unimpaired'

  -- Make plugin actions repeatable by .
  use 'tpope/vim-repeat'
  -- Autoinstall/compile plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then
    packer.install()
  end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then
    packer.compile()
  end
end)
