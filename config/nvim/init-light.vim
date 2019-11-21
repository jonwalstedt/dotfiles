" Init Light

" Use <Space> as Leader key.
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lsp'
Plug 'ryanoasis/vim-devicons'
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


" FZF Fuzzyfinder {{{
command! -bar -bang Snippets call fzf#vim#snippets({'options': '-n ..'}, <bang>0)
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,2'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

nnoremap <silent> <C-p> :call FZFWithDevIcons()<CR>
"nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>p :Buffers<CR>
nnoremap <silent> <leader>ff :Ag<CR>
nnoremap <silent> <leader>fc :History:<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fg :Ag <C-R><C-W><CR>
inoremap <silent> <c-space> <esc>:Snippets<CR>

imap <c-f> <plug>(fzf-complete-path)
imap <c-l> <plug>(fzf-complete-line)
" }}}

" Vim Fugitive {{{
function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    Gstatus
  endif
endfunction

command! ToggleGStatus :call ToggleGStatus()

" Fugitive (toggle git status panel)
nnoremap <silent> <localleader><space> :call ToggleGStatus()<cr>
nnoremap <leader>fv :Gvdiff<CR>
nnoremap <leader>fl :Glog -10 -- %<CR>
"}}}

:lua << EOF
local nvim_lsp = require 'nvim_lsp'
nvim_lsp.tsserver.setup({config})
EOF
