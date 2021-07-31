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
  use {
    'wbthomason/packer.nvim',
    event = 'VimEnter'
  }

  -- LSP
  use {
    'kabouzeid/nvim-lspinstall',
    event = 'BufRead'
  }

  use {
    'neovim/nvim-lspconfig',
    setup = [[require('plugin.nvim-lspconfig')]],
    after = 'nvim-lspinstall'
  }

  -- use { 'RishabhRD/nvim-lsputils',
  --   requires = { 'RishabhRD/popfix' },
  --   setup = [[require('plugin.nvim-lsputils')]],
  -- }
  -- use { 'jose-elias-alvarez/null-ls.nvim',
  --   requires = {
  --    'nvim-lua/plenary.nvim'
  --   }
  -- }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate',
    setup = [[require('plugin.nvim-treesitter')]],
    requires = {
      'windwp/nvim-ts-autotag',
      -- 'p00f/nvim-ts-rainbow',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
    },
    event = 'BufRead',
  }

  -- Autocomplete
  use {
    'hrsh7th/nvim-compe',
    event = 'InsertEnter',
    config = function()
      require 'plugin.nvim-compe'
    end,
    wants = 'LuaSnip',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        wants = 'friendly-snippets',
        event = 'InsertCharPre',
        config = function()
          require 'plugin.luasnip'
        end
      },
      {
        'rafamadriz/friendly-snippets',
        event = 'InsertCharPre'
      }
    },
  }

  -- File browser
  use { 'justinmk/vim-dirvish', setup = [[require('plugin.dirvish')]]}

  -- FZF file/content search
  use {
    'chengzeyi/fzf-preview.vim',
    requires = {
      'junegunn/fzf',
      'junegunn/fzf.vim',
      'ryanoasis/vim-devicons'
    },
    setup = [[require('plugin.fzf')]],
    opt = true,
    event = 'BufRead',
  }

  -- Git
  use {
    'tpope/vim-fugitive',
    setup = [[require('plugin.vim-fugitive')]],
    opt = true,
    event = 'BufRead',
  }

  use {
    'junegunn/gv.vim',
    requires = {
      {
        'tpope/vim-fugitive',
        setup = [[require('plugin.vim-fugitive')]],
      }
    },
    cmd = 'GV'
  }

  use {
    'airblade/vim-gitgutter',
    setup = [[require('plugin.vim-gitgutter')]],
    opt = true,
    event = 'BufRead'
  }

  -- Quickfix list
  use 'romainl/vim-qlist'
  use 'romainl/vim-qf'

  -- Language support
  use {
    'sheerun/vim-polyglot',
    event = 'BufRead'
  }

  -- Colorschemes
  use { 'ChristianChiarulli/nvcode-color-schemes.vim' }

  -- Movement
  use {
    'justinmk/vim-sneak',
    setup = [[require('plugin.vim-sneak')]],
    event = 'BufRead'
  }

  -- Autopairs
  use {
    'windwp/nvim-autopairs',
    after = 'nvim-compe',
    config = function()
      require 'plugin.nvim-autopairs'
    end
  }

  -- Misc
  -- Complementary pairs of mappings
  use 'tpope/vim-unimpaired'
  -- Make plugin actions repeatable by .
  use 'tpope/vim-repeat'
  -- Show search result count
  use 'google/vim-searchindex'
  -- Pickup and use editor config files
  use 'editorconfig/editorconfig-vim'
  -- Colorconverter
  use {
    'NTBBloodbath/color-converter.nvim',
    setup = [[require('plugin.color-converter-nvim')]],
    opt = true,
    event = 'BufRead'
  }
  -- Dim inactive windows
  use {
    'sunjon/shade.nvim',
    setup = [[require('plugin.nvim-shade')]],
    opt = true,
    event = 'BufRead'
  }

  -- Autoinstall/compile plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then packer.install() end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
end)
