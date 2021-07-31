local packer_path = U.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/opt/*'

-- disable plugins
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

local packer = require('packer')
local plugin_path = U.os.data .. '/site/pack/packer/opt/'
local packer_compiled = U.os.data .. '/site/plugin/packer_compiled.vim'

return packer.startup(function(use)
  packer.init({compile_path = packer_compiled, opt_default = true})

  -- Plugin Manager
  use 'wbthomason/packer.nvim'

  -- FZF file/content search
  use 'junegunn/fzf'
  use { 'junegunn/fzf.vim',
    after = 'fzf',
    setup = [[require('plugin.fzf')]]
  }
  use { 'stsewd/fzf-checkout.vim',
    after = 'fzf',
    setup = [[require('plugin.fzf-checkout')]]
  }
  use { 'chengzeyi/fzf-preview.vim', after = 'fzf'}
  -- use 'andymass/vim-matchup'

  -- Git
  use { 'tpope/vim-fugitive', setup = [[require('plugin.vim-fugitive')]]}
  use 'junegunn/gv.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    setup = [[require('plugin.nvim-gitsigns')]]
  }

  -- Movement
  use { 'justinmk/vim-sneak', setup = [[require('plugin.vim-sneak')]]}

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'google/vim-searchindex'

  -- File browser and quick fix list
  use { 'justinmk/vim-dirvish', setup = [[require('plugin.dirvish')]]}
  use 'romainl/vim-qlist'
  use 'romainl/vim-qf'
  use 'editorconfig/editorconfig-vim'
  use 'sheerun/vim-polyglot'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'norcalli/snippets.nvim'

  use 'jonwalstedt/vim-myhelp'

  -- Autopairs
  use {'windwp/nvim-autopairs', setup = [[require('plugin.nvim-autopairs')]], event = 'InsertEnter'}

  -- Colorizer
  -- use {'norcalli/nvim-colorizer.lua', setup = [[require('plugin.nvim-colorizer')]]}
  use { 'NTBBloodbath/color-converter.nvim', setup = [[require('plugin.color-converter-nvim')]] }

  -- Colorschemes
  use { 'ChristianChiarulli/nvcode-color-schemes.vim' }

  -- Icons
  use {'sunjon/shade.nvim', setup = [[require('plugin.nvim-shade')]]}
  use 'ryanoasis/vim-devicons'

  -- Lsp
  use {
    'neovim/nvim-lspconfig',
    setup = [[require('plugin.nvim-lspconfig')]],
    requires = {
      {'hrsh7th/nvim-compe', setup = [[require('plugin.nvim-compe')]], event = 'InsertEnter'},
      'kabouzeid/nvim-lspinstall',
      -- 'glepnir/lspsaga.nvim',
      -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
    },
  }

  -- LSP Setup
  use { 'RishabhRD/nvim-lsputils',
    requires = { 'RishabhRD/popfix' },
    setup = [[require('plugin.nvim-lsputils')]],
  }
  use { 'jose-elias-alvarez/null-ls.nvim',
    requires = {
     'nvim-lua/plenary.nvim'
    }
  }

  -- Profiling
  -- use 'tweekmonster/startuptime.vim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate',
    setup = [[require('plugin.nvim-treesitter')]],
    requires = {
      -- 'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
    },
  }

  -- Autoinstall/compile plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then packer.install() end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
end)
