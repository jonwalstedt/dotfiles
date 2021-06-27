local packer_path = U.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/opt/*'

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
  use 'andymass/vim-matchup'

  -- Git
  use { 'airblade/vim-gitgutter', setup = [[require('plugin.vim-gitgutter')]]}
  use { 'tpope/vim-fugitive', setup = [[require('plugin.vim-fugitive')]]}
  use 'junegunn/gv.vim'

  -- Movement
  use { 'justinmk/vim-sneak', setup = [[require('plugin.vim-sneak')]]}

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'google/vim-searchindex'
  use { 'justinmk/vim-dirvish', setup = [[require('plugin.dirvish')]]}
  use 'romainl/vim-qlist'
  use 'romainl/vim-qf'
  use 'editorconfig/editorconfig-vim'
  use 'ryanoasis/vim-devicons'
  use 'sheerun/vim-polyglot'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'norcalli/snippets.nvim'
  use { 'folke/lsp-trouble.nvim', setup = [[require('plugin.lsp-trouble')]]}
  use { 'jose-elias-alvarez/null-ls.nvim', requires = {
   'nvim-lua/plenary.nvim'
  }}

  use 'jonwalstedt/vim-myhelp'

  -- Autopairs
  use {'windwp/nvim-autopairs', setup = [[require('plugin.nvim-autopairs')]]}
  -- Colorizer
  use {'norcalli/nvim-colorizer.lua', setup = [[require('plugin.nvim-colorizer')]]}
  -- Colorschemes
  use {
    'ChristianChiarulli/nvcode-color-schemes.vim', 'glepnir/zephyr-nvim', 'folke/tokyonight.nvim',
  }
  -- Icons
  use {'kyazdani42/nvim-web-devicons', setup = [[require('plugin.nvim-web-devicons')]]}
  -- Lsp
  use {
    'neovim/nvim-lspconfig',
    setup = [[require('plugin.nvim-lspconfig')]],
    requires = {
      {'hrsh7th/nvim-compe', setup = [[require('plugin.nvim-compe')]], event = 'InsertEnter'},
      'kabouzeid/nvim-lspinstall',
      'glepnir/lspsaga.nvim',
      -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
    },
  }
  -- Profiling
  use 'tweekmonster/startuptime.vim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    setup = [[require('plugin.nvim-treesitter')]],
    requires = {
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  }

  -- Autoinstall/compile plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then packer.install() end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
end)
