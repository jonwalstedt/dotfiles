" Load project specific vim settings
silent! so .vimlocal

" Use \ as Leader key (default).
let mapleader = "\\"
let maplocalleader = "ﬁ"

" Helpfiles can be found here
" https://github.com/jonwalstedt/vim-myhelp

source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/plugins-medium.vim
source $HOME/.config/nvim/macros.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/config.vim

autocmd BufRead,BufNewFile *.ts set filetype=javascript
autocmd BufRead,BufNewFile *.tsx set filetype=javascript
