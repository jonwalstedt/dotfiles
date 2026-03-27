require('lazy').setup {
  -- Collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end,
  },
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  { 'MunifTanjim/prettier.nvim' },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require 'plugin.null-ls'
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require 'plugin.autotag'
    end,
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = 'openai',
      providers = {
        openai = {
          endpoint = 'https://api.openai.com/v1',
          model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
          -- extra_request_body = {
          --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          --   temperature = 0.75,
          --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          -- },
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'hrsh7th/nvim-cmp',                                     -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua',                                     -- for file_selector provider fzf
      'stevearc/dressing.nvim',                               -- for input provider dressing
      { 'folke/snacks.nvim', lazy = false, priority = 1000 }, -- for input provider snacks
      'nvim-tree/nvim-web-devicons',                          -- or echasnovski/mini.icons
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'Avante' },
        config = function()
          require('plugin.render-markdown')
        end,
      },
    },
  },

  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   opts = {},
  -- },

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
      { "nvim-treesitter/nvim-treesitter-refactor",    branch = "master" },
      { "windwp/nvim-ts-autotag" },
    },
    config = function()
      require("plugin.treesitter")
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
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      require 'plugin.bqf'
    end,
  },

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
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
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

  'terrastruct/d2-vim',

  -- Test runner
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
    },
    keys = {
      { '<leader>Tt', function() require('neotest').run.run() end,                  desc = 'Run nearest test' },
      { '<leader>Tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run test file' },
      { '<leader>Tl', function() require('neotest').run.run_last() end,             desc = 'Run last test' },
      { '<leader>Ts', function() require('neotest').summary.toggle() end,           desc = 'Toggle test summary' },
      { '<leader>To', function() require('neotest').output_panel.toggle() end,      desc = 'Toggle output panel' },
    },
    config = function()
      require('plugin.neotest')
    end,
  },

  -- UI: replace cmdline and notifications with floating UI
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('plugin.noice')
    end,
  },
}
