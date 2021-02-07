" Init Light

" Use <Space> as Leader key.
let mapleader = "\<Space>"
let maplocalleader = "ﬁ"

" Helpfiles can be found here
" https://github.com/jonwalstedt/vim-myhelp

source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/plugins-nvim-lsp.vim
source $HOME/.config/nvim/macros.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/config.vim

" Open Vimrc in split
nnoremap <leader>ve :vsplit ~/.config/nvim/init-nvim-lsp.vim<CR>

" Source Vimrc
nnoremap <leader>vs :source ~/.config/nvim/init-nvim-lsp.vim<CR>

