" Load project specific vim settings
silent! so .vimlocal

" Use \ as Leader key (default).
let mapleader = "\\"
let maplocalleader = "`"

" Cheatsheet see:
" https://bitbucket.org/Jonwalstedt/vim-cheatsheet/src/master/README.md

source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/config.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/macros.vim
source $HOME/.config/nvim/keymap.vim
