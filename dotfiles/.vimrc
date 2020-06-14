" Plugins to install:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set hidden
set nocompatible              " be iMproved, required
filetype off                  " required

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

