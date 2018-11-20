#!/bin/bash

echo "WARNING!"
echo "This can (and WILL) override all softwares you intend to install,"
echo "bash_aliases, vimrc, git config files, etc., so be sure of"
echo "what you are doing!"

if [[ $(which git) == "" ]];
    sudo apt install git
fi

git clone git@github.com:Pierstoval/dotfiles.git ~/dotfiles

mkdir -p ~/bin

# Create bashrc if not exists
[[ -f ~/.bashrc ]] || touch ~/.bashrc

# Add source bash_aliases if not present in bashrc
(cat ~/.bashrc | grep "bash_aliases") > /dev/null 2>&1 || echo "source ~/.bash_aliases" >> ~/.bashrc

# Copy dotfiles
cp -r ~/dotfiles/* ~/
cp -r ~/bin/* ~/bin/
cp -r ~/etc/* /etc/

# Install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "------------------------------"
echo "Finished!"
echo ""
echo "Now you should load config file in current environment by executing this command:"
echo "source ~/.bash_aliases"

