require('lazy').setup {
  -- Collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'plugin.nvim-lspconfig'
    end,
  },
  { 'MunifTanjim/prettier.nvim' },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require 'plugin.null-ls'
    end,
  },
  { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate',
    config = function()
      require 'plugin.nvim-treesitter'
    end,
  },
  'nvim-treesitter/nvim-treesitter-refactor',
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
  -- Git commands in nvim
  {
    'tpope/vim-fugitive',
    config = function()
      require 'plugin.vim-fugitive'
    end,
  },

  -- UI to select things (files, grep results, open buffers...)

  -- Themes
  'Mofiqul/vscode.nvim',
  'EdenEast/nightfox.nvim',
  'mjlbach/onedark.nvim',
  'folke/tokyonight.nvim',
  'embark-theme/vim',
  'Domeee/mosel.nvim',
  {
    'sonph/onehalf',
    rtp = 'vim',
  },

  -- Movement
  {
    'justinmk/vim-sneak',
    config = function()
      require 'plugin.vim-sneak'
    end,
  },

  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      require 'plugin.nvim-indent-blankline'
    end,
  },

  -- Add git related info in the signs columns and popups
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'plugin.gitsigns'
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  },

  -- Autocomplete
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-calc' },
  { 'hrsh7th/cmp-cmdline' },
  { 'dcampos/cmp-snippy' },
  {
    'hrsh7th/nvim-cmp',
    requires = {
      'quangnguyen30192/cmp-nvim-ultisnips',
      config = function()
        require('cmp_nvim_ultisnips').setup {}
      end,
      requires = { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require 'plugin.nvim-cmp'
    end,
  },

  -- File browser
  {
    'justinmk/vim-dirvish',
    config = function()
      require 'plugin.dirvish'
    end,
  },

  -- FZF file / content search
  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    config = function()
      require 'plugin.fzf'
    end,
    dependencies = { 'junegunn/fzf' },
    event = 'BufRead',
  },

  {
    'chengzeyi/fzf-preview.vim',
    dependencies = { 'fzf.vim', 'ryanoasis/vim-devicons' },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function()
      require 'plugin.fzf'
    end,
  },

  -- Quickfix list
  -- 'romainl/vim-qlist',
  -- 'romainl/vim-qf',
  'kevinhwang91/nvim-bqf',

  -- Misc
  { 'tpope/vim-surround' },
  { 'othree/html5.vim' },
  { 'pangloss/vim-javascript' },
  { 'evanleck/vim-svelte' },

  -- Snippets
  -- { 'SirVer/ultisnips' },
  { 'dcampos/nvim-snippy' },
  { 'honza/vim-snippets' },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'plugin.lualine'
    end,
  },

  -- Make plugin actions repeatable by .
  'tpope/vim-repeat',

  -- Complementary pairs of mappings
  'tpope/vim-unimpaired',

  -- Show search result count
  'google/vim-searchindex',

  -- Pickup and editor config files
  'editorconfig/editorconfig-vim',
}
