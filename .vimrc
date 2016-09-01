
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

