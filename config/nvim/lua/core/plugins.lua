vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/opt/*'

local packer = require 'packer'
local plugin_path = U.os.data .. '/site/pack/packer/opt/'
local packer_compiled = U.os.data .. '/site/plugin/packer_compiled.vim'

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  packer.init { compile_path = packer_compiled, opt_default = true }

  -- Plugin Manager
  use { 'wbthomason/packer.nvim' }

  -- Git
  use { 'tpope/vim-fugitive', setup = [[require('plugin.vim-fugitive')]] }

  -- Colorschemes
  -- use { 'ChristianChiarulli/nvcode-color-schemes.vim' }
  use "EdenEast/nightfox.nvim"
  use 'mjlbach/onedark.nvim'
  use 'folke/tokyonight.nvim'
  use { 'embark-theme/vim', as = 'embark' }
  use 'Domeee/mosel.nvim'
  use {
    'sonph/onehalf',
    rtp = 'vim'
  }

  use {
    'lewis6991/gitsigns.nvim',
    setup = [[require('plugin.gitsigns')]],
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  }

  use {
    'neoclide/coc.nvim',
    branch = "release",
    setup = [[require('plugin.coc')]]
  }

  -- File browser
  use { 'justinmk/vim-dirvish', setup = [[require('plugin.dirvish')]] }

  -- FZF file/content search
  use {
    'junegunn/fzf.vim',
    setup = [[require('plugin.fzf')]],
    requires = { 'junegunn/fzf' },
    event = 'BufRead',
  }

  use {
    'chengzeyi/fzf-preview.vim',
    after = 'fzf.vim',
    requires = { 'ryanoasis/vim-devicons' },
  }

  -- Quickfix list
  use 'romainl/vim-qlist'
  use 'romainl/vim-qf'

  -- Movement
  use {
    'justinmk/vim-sneak',
    setup = [[require('plugin.vim-sneak')]],
    event = 'BufRead',
  }
  -- Misc
  -- Statusline
  use { 'nvim-lualine/lualine.nvim', setup = [[require('plugin.lualine')]] }

  -- Make plugin actions repeatable by .
  use 'tpope/vim-repeat'

  -- Complementary pairs of mappings
  use 'tpope/vim-unimpaired'

  -- Show search result count
  use 'google/vim-searchindex'

  -- Pickup and use editor config files
  use 'editorconfig/editorconfig-vim'

  -- Autoinstall/compile plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then
    packer.install()
  end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then
    packer.compile()
  end
end)

