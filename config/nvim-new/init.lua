vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = 'ﬁ'

require 'utils'
require 'core.plugins'
require 'core.commands'
require 'core.macros'
require 'core.keymaps'
require 'core.autocmds'
require 'core.options'
