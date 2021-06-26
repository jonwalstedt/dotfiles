local colors = require 'lua-helpers/colors'
local highlight = colors.highlight

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { "lua", "yaml" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      scope_incremental = 'grc',
      node_incremental = 'grn',
      node_decremental = 'grm',
    }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          javascript = "(function_definition) @function",
          javascriptreact = "(function_definition) @function",
          typescript = "(function_definition) @function",
          typescriptreact = "(function_definition) @function",
        },
      },
    },
  },
}

-- -- Misc
-- highlight('TSError', '#F44747')
-- highlight('TSPunctDelimiter', '#ABB2BF')
-- highlight('TSPunctBracket', '#ABB2BF')
-- highlight('TSPunctSpecial', '#ABB2BF')
--
-- -- Constants
-- highlight('TSConstant', '#DCDCAA')
-- highlight('TSConstBuiltin', '#569CD6')
-- highlight('TSConstMacro', '#4EC9B0')
-- highlight('TSString', '#CE9178')
-- highlight('TSStringRegex', '#CE9178')
-- highlight('TSString', '#CE9178')
-- highlight('TSStringEscape', '#D7BA7D')
-- highlight('TSCharacter', '#CE9178')
-- highlight('TSNumber', '#B5CEA8')
-- highlight('TSBoolean', '#569CD6')
-- highlight('TSFloat', '#B5CEA8')
-- highlight('TSAnnotation', '#DCDCAA')
-- highlight('TSAttribute', '#FF00FF')
-- highlight('TSNamespace', '#FF00FF')
--
-- -- Functions
-- highlight('TSFuncBuiltin', '#DCDCAA')
-- highlight('TSFunction', '#DCDCAA')
-- highlight('TSFuncMacro', '#DCDCAA')
-- highlight('TSParameter', '#9CDCFE')
-- highlight('TSParameterReference', '#9CDCFE')
-- highlight('TSMethod', '#DCDCAA')
-- highlight('TSField', '#9CDCFE')
-- highlight('TSProperty', '#9CDCFE')
-- highlight('TSConstructor', '#4EC9B0')
--
-- -- Keywords
-- highlight('TSConditional', '#C586C0')
-- highlight('TSRepeat', '#C586C0')
-- highlight('TSLabel', '#FF00FF')
--
-- -- Does not work for yield and return they should be diff then class and def
-- highlight('TSKeyword', '#569CD6')
-- highlight('TSKeywordFunction', '#FF00FF')
-- highlight('TSKeywordOperator', '#569CD6')
-- highlight('TSOperator', '#ABB2BF')
-- highlight('TSException', '#C586C0')
-- highlight('TSType', '#4EC9B0')
-- highlight('TSTypeBuiltin', '#FF00FF')
-- highlight('TSStructure', '#FF00FF')
-- highlight('TSInclude', '#C586C0')
--
-- -- Variable
-- highlight('TSVariable', '#9CDCFE')
-- highlight('TSVariableBuiltin', '#9CDCFE')
--
-- -- Text
-- highlight('TSText', '#FF00FF')
-- highlight('TSStrong', '#FF00FF')
-- highlight('TSEmphasis', '#FF00FF')
-- highlight('TSUnderline', '#FF00FF')
-- highlight('TSTitle', '#FF00FF')
-- highlight('TSLiteral', '#FF00FF')
-- highlight('TSURI', '#FF00FF')
--
-- -- Tags
-- highlight('TSTag', '#569CD6')
-- highlight('TSTagDelimiter', '#5C6370')
