local keymap = vim.api.nvim_set_keymap
local command = U.command

local api = vim.api
local fn  = vim.fn

local function map(mode, keys, exec, opts)
  vim.keymap.set(mode, keys, exec, opts or { silent = true, noremap = true })
end

vim.g.coc_global_extensions = {
  'coc-json',
  'coc-lists',
  'coc-explorer',
  'coc-actions',
  'coc-highlight',
  'coc-pairs',
  'coc-vimlsp',
  'coc-snippets',
  'coc-spell-checker',
  'coc-ultisnips',
  'coc-omni',
  'coc-sh',
  'coc-translator',
  'coc-tsserver',
  'coc-html',
  'coc-diagnostic',
  'coc-lua',
  'coc-leetcode',
  'coc-docker',
  'coc-prettier',
  'coc-eslint'
}


map("i", "<TAB>",
  function()
    local function check_backspace()
      local row, col = unpack(api.nvim_win_get_cursor(0))
      local linetext = api.nvim_get_current_line()
      return col == 0 or string.match(linetext:sub(col, col), '%s') ~= nil
    end
    if fn["coc#pum#visible"]() == 1 then
      fn["coc#pum#next"](1)
    elseif check_backspace() then
      return "<Tab>"
    else
      fn["coc#refresh"]()
    end
  end,
  { silent = true, noremap = true, expr = true }
)

map("i", "<S-TAB>",
  function()
    if fn["coc#pum#visible"]() == 1 then
      fn["coc#pum#prev"](1)
    else
      return "<C-h>"
    end
  end,
  { noremap = true, expr = true }
)

vim.api.nvim_set_keymap("i", "<CR>", "coc#pum#visible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

-- Use <C-l> for trigger snippet expand.
map("i", "<C-k>", "<Plug>(coc-snippets-expand)", {})

-- Use <C-j> for select text for visual placeholder of snippet.
map("v", "<C-j>", "<Plug>(coc-snippets-select)", {})

-- <c-space> triggers completion
map("i", "<C-space>", "coc#refresh()", { silent = true, noremap = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
map("n", "<leader>ep", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "<leader>en", "<Plug>(coc-diagnostic-next)", { silent = true })

-- Use K to show documentation in preview window.
-- nnoremap <silent> K :call ShowDocumentation()<CR>
map("n", "K", ":lua ShowDocumentation()<CR>")

-- GoTo code navigation.
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gl", "<Plug>(coc-references)", { silent = true })

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })

-- Remap keys for applying codeAction to the current buffer.
map("n", "<leader>ac", "<Plug>(coc-codeaction)", { silent = true })
-- Apply AutoFix to problem on the current line.
map("n", "<leader>af", "<Plug>(coc-fix-current)", { silent = true })

-- Run the Code Lens action on the current line.
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", { silent = true })

function ShowDocumentation()
  if fn.CocAction("hasProvider", "hover") then
    fn.CocActionAsync("doHover")
  else
    fn.feedkeys("K", "in")
  end
end

command('-nargs=0', 'Prettier :CocCommand prettier.forceFormatDocument')
