" Init Light

" Use \ as Leader key (default).
let mapleader = "\<Space>"
let maplocalleader = "ﬁ"

" Helpfiles can be found here
" https://github.com/jonwalstedt/vim-myhelp

" Plugins {{{
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
call plug#end()
" }}}
" Setup syntax {{{
augroup typescript
  au!
  autocmd BufNewFile,BufRead *.tsx set syntax=javascript
  autocmd BufNewFile,BufRead *.ts set syntax=javascript
augroup END
" }}}

source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/macros.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/config.vim

" Load project specific vim settings
silent! source .vimlocal

