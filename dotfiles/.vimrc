" Plugins to install:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set hidden
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins load STARTS HERE
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'nelsyeung/twig.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ctrlspace/vim-ctrlspace'

" Plugins load ENDS HERE
call vundle#end()            " required
filetype plugin indent on    " required

let g:vundle_default_git_proto = 'git'


"
" Custom config not related to plugins
"

" Automatic syntax highlighting if available
syntax on


" Show line numbers
set number

" Sudo saving
cmap w!! w !sudo tee > /dev/null %

" Convert tabs to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Color theme
colors torte

" Force background to be transparent
hi Normal ctermbg=none

" Enable highlight for search terms
set hlsearch

