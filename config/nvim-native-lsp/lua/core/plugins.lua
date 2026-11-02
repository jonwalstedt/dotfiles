require('lazy').setup {
  -- Collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    -- Gated behind DevMode (see core.dev_mode / :DevStart). Loading the
    -- plugin just registers its default configs on the rtp; nothing starts
    -- until core.dev_mode calls require('lsp').setup().
    lazy = true,
    dependencies = { 'b0o/schemastore.nvim' },
  },
  { 'MunifTanjim/prettier.nvim', cmd = 'Prettier' },
  {
    'nvimtools/none-ls.nvim',
    -- NOTE: intentionally not depending on 'neovim/nvim-lspconfig' here —
    -- that plugin is gated behind DevMode (see above) and listing it as a
    -- dependency would force it to load eagerly again.
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugin.null-ls').setup()
    end,
  },
  {
    -- Gated behind DevMode. `require 'plugin.autotag'` runs the setup call,
    -- triggered from core.dev_mode on :DevStart.
    'windwp/nvim-ts-autotag',
    lazy = true,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    config = function()
      require 'plugin.render-markdown'
    end,
  },

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
      { 'nvim-treesitter/nvim-treesitter-refactor', branch = 'master' },
      -- NOTE: nvim-ts-autotag is intentionally NOT listed here — it has its
      -- own spec further up and stays `lazy = true` behind DevMode. Listing
      -- it as a dependency here would force it to load eagerly with
      -- treesitter regardless of its own lazy setting.
    },
    config = function()
      require 'plugin.treesitter'
    end,
  },
  -- Git commands in nvim
  {
    'tpope/vim-fugitive',
    config = function()
      require 'plugin.fugitive'
    end,
  },
  { 'nvim-tree/nvim-web-devicons', opts = {} },
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
        '<leader>vb',
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

  {
    'stevearc/dressing.nvim', -- Utilises Neovim UI hooks to manage inputs, selects etc
    event = 'VeryLazy',
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

  { 'rose-pine/neovim', name = 'rose-pine' },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      window = {
        backdrop = 1,
        width = 82,
        height = 1,
        options = {
          signcolumn = 'no',
          number = false,
          relativenumber = false,
          cursorline = false,
          foldcolumn = '0',
          list = false,
          statuscolumn = '',
          wrapmargin = 0,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        gitsigns = { enabled = false },
      },
      on_open = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
      end,
    },
  },
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
    event = { 'BufReadPost', 'BufNewFile' },
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
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'plugin.oil'
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
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf', -- only ever needed inside the quickfix window
    config = function()
      require 'plugin.bqf'
    end,
  },

  -- Misc
  { 'github/copilot.vim' },
  { 'tpope/vim-surround' },
  { 'othree/html5.vim', ft = { 'html', 'templ' } },
  { 'pangloss/vim-javascript', ft = { 'javascript', 'javascriptreact', 'javascript.jsx' } },
  { 'evanleck/vim-svelte', ft = 'svelte' },

  -- Completion — gated behind DevMode (see core.dev_mode / :DevStart).
  -- No `event`/`cmd` trigger on purpose: stays fully unloaded until
  -- core.dev_mode explicitly loads + requires 'plugin.cmp'.
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- Snippets — gated behind DevMode.
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    lazy = true,
  },

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

  { 'terrastruct/d2-vim', ft = 'd2' },

  -- Ordna Today / Worktrees TUI (same vault as the desktop app)
  {
    dir = vim.fn.expand '~/repos/jonwalstedt/ordna/extensions/ordna.nvim',
    name = 'ordna.nvim',
    lazy = false,
    opts = {
      open_on_startup = true,
      open_worktree = 'auto',
    },
  },
}
