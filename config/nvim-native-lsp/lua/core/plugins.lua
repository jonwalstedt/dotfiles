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
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
      { 'nvim-lua/plenary.nvim' },
      -- Test with blink.cmp
      {
        'saghen/blink.cmp',
        lazy = false,
        version = '*',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = {
          keymap = {
            preset = 'enter',
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
          },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
          },
          sources = {
            default = { 'lsp', 'path', 'buffer', 'codecompanion' },
            per_filetype = {
              codecompanion = { 'codecompanion' },
            },
            cmdline = {},
          },
        },
      },
      opts_extend = { 'sources.default' },
    },
    config = function()
      require 'plugin.codecompanion'
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
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
  },
  {
    'stevearc/dressing.nvim', -- Utilises Neovim UI hooks to manage inputs, selects etc
    opts = {
      input = {
        default_prompt = '> ',
        relative = 'editor',
        prefer_width = 50,
        prompt_align = 'center',
        win_options = { winblend = 0 },
      },
    },
  },
  -- Themes
  {
    'Shatur/neovim-ayu',
    config = function()
      require 'plugin.ayu'
    end,
  },

  -- 'Mofiqul/vscode.nvim',
  'EdenEast/nightfox.nvim',
  'mjlbach/onedark.nvim',
  'folke/tokyonight.nvim',
  'embark-theme/vim',
  'Domeee/mosel.nvim',
  {
    'sonph/onehalf',
    rtp = 'vim',
  },
  { 'rose-pine/neovim', name = 'rose-pine' },
  -- Movement
  {
    'justinmk/vim-sneak',
    config = function()
      require 'plugin.sneak'
    end,
  },

  --Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      require 'plugin.indent-blankline'
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
  { 'github/copilot.vim' },
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
