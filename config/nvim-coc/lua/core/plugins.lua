require('lazy').setup {
  -- Git
  {
    'tpope/vim-fugitive',
    config = function()
      require 'plugin.vim-fugitive'
    end,
  },

  -- Colorschemes
  -- { 'ChristianChiarulli/nvcode-color-schemes.vim' }
  'Mofiqul/vscode.nvim',
  'EdenEast/nightfox.nvim',
  'mjlbach/onedark.nvim',
  'folke/tokyonight.nvim',
  { 'embark-theme/vim' },
  'Domeee/mosel.nvim',
  {
    'sonph/onehalf',
    rtp = 'vim',
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'plugin.gitsigns'
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate',
    config = function()
      require 'plugin.treesitter'
    end,
  },

  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      require 'plugin.coc'
    end,
  },

  -- File browser
  {
    'justinmk/vim-dirvish',
    config = function()
      require 'plugin.dirvish'
    end,
  },

  -- FZF file/content search
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

  -- Quickfix list
  'romainl/vim-qlist',
  'romainl/vim-qf',

  -- Movement

  -- Misc
  { 'tpope/vim-surround' },
  { 'othree/html5.vim' },
  { 'pangloss/vim-javascript' },
  { 'evanleck/vim-svelte' },

  -- Snippets
  { 'SirVer/ultisnips' },
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
