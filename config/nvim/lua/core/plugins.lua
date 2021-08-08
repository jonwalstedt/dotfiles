local packer_path = U.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/opt/*'

local packer = require('packer')
local plugin_path = U.os.data .. '/site/pack/packer/opt/'
local packer_compiled = U.os.data .. '/site/plugin/packer_compiled.vim'

return packer.startup(
  function(use)
    packer.init({ compile_path = packer_compiled, opt_default = true })

    -- Plugin Manager
    use { 'wbthomason/packer.nvim' }

    -- LSP
    use { 'kabouzeid/nvim-lspinstall', event = 'BufRead' }

    use {
      'neovim/nvim-lspconfig',
      setup = [[require('plugin.nvim-lspconfig')]],
      after = 'nvim-lspinstall',
      requires = { 'glepnir/lspsaga.nvim' }
    }

    use {
      'RishabhRD/nvim-lsputils',
      requires = { 'RishabhRD/popfix' },
      setup = [[require('plugin.nvim-lsputils')]]
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      branch = '0.5-compat',
      run = ':TSUpdate',
      setup = [[require('plugin.nvim-treesitter')]],
      requires = { 'windwp/nvim-ts-autotag' }
    }

    -- Autocomplete
    use {
      'hrsh7th/nvim-compe',
      event = 'InsertEnter',
      config = function() require 'plugin.nvim-compe' end,
      wants = 'vim-vsnip',
      requires = {
        {
          'hrsh7th/vim-vsnip',
          event = 'InsertCharPre',
          config = function() require 'plugin.vsnip' end,
          requires = { 'hrsh7th/vim-vsnip-integ' }
        }
      }
    }

    -- File browser
    use { 'justinmk/vim-dirvish', setup = [[require('plugin.dirvish')]] }

    -- FZF file/content search
    use {
      'junegunn/fzf.vim',
      setup = [[require('plugin.fzf')]],
      requires = { 'junegunn/fzf' },
      event = 'BufRead'
    }

    use {
      'chengzeyi/fzf-preview.vim',
      after = 'fzf.vim',
      requires = { 'ryanoasis/vim-devicons' }
    }

    -- Git
    use { 'tpope/vim-fugitive', setup = [[require('plugin.vim-fugitive')]] }

    use {
      'lewis6991/gitsigns.nvim',
      setup = [[require('plugin.nvim-gitsigns')]],
      requires = { 'nvim-lua/plenary.nvim' },
      event = 'BufRead'
    }

    -- Quickfix list
    use 'romainl/vim-qlist'
    use 'romainl/vim-qf'

    -- Language support
    use { 'sheerun/vim-polyglot' }

    -- Colorschemes
    use { 'ChristianChiarulli/nvcode-color-schemes.vim' }

    -- Movement
    use {
      'justinmk/vim-sneak',
      setup = [[require('plugin.vim-sneak')]],
      event = 'BufRead'
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
    -- Colorizer
    use {
      'norcalli/nvim-colorizer.lua',
      setup = [[require('plugin.nvim-colorizer')]]
    }
    -- Colorconverter
    use {
      'NTBBloodbath/color-converter.nvim',
      setup = [[require('plugin.color-converter-nvim')]],
      event = 'BufRead'
    }

    -- Autoinstall/compile plugins
    if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then packer.install() end
    if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
  end
)
