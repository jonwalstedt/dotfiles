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
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require 'plugin.null-ls'
    end,
  },
  { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require 'plugin.autotag'
    end,
  },
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   opts = {},
  -- },

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate',
    config = function()
      require 'plugin.treesitter'
    end,
    dependencies = {
      -- { 'andymass/vim-matchup' },
      { 'windwp/nvim-ts-autotag' },
    },
  },
  'nvim-treesitter/nvim-treesitter-refactor',
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
  -- Git commands in nvim
  {
    'tpope/vim-fugitive',
    config = function()
      require 'plugin.fugitive'
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        '<leader>v<leader>',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>vv',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>vs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>vl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>vL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>v<CR>',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
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
  { 'rose-pine/neovim',    name = 'rose-pine' },
  -- Movement
  {
    'justinmk/vim-sneak',
    config = function()
      require 'plugin.sneak'
    end,
  },

  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    -- config = function()
    --   require 'plugin.indent-blankline'
    -- end,
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
      require 'plugin.cmp'
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
      require 'plugin.comment'
    end,
  },

  -- Quickfix list
  -- 'romainl/vim-qlist',
  -- 'romainl/vim-qf',
  'kevinhwang91/nvim-bqf',

  -- Misc
  -- Skipping copilot for now
  -- { 'github/copilot.vim' },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'canary',
  --   dependencies = {
  --     { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
  --     { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  --   },
  --   opts = {
  --     debug = true, -- Enable debugging
  --     -- See Configuration section for rest
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },

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

  'terrastruct/d2-vim',
}
