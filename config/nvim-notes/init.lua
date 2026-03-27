local base = vim.fn.expand("~/repos/jonwalstedt/dotfiles/config/nvim-native-lsp")
local base_lua = base .. "/lua"

vim.g.notes_mode = true
vim.g.base_config_root = base

-- Lua paths (needed early)
package.path = table.concat({
  base_lua .. "/?.lua",
  base_lua .. "/?/init.lua",
  package.path,
}, ";")

-- Load config
dofile(base .. "/init-note-taking.lua")

-- 🔥 CRITICAL: set runtimepath AFTER
vim.opt.runtimepath:prepend(base)
vim.opt.packpath:prepend(base)
