#!/bin/bash

echo "WARNING!"
echo "This can (and WILL) override all softwares you intend to install,"
echo "bash_aliases, vimrc, git config files, etc., so be sure of"
echo "what you are doing!"

if [[ $(which git) == "" ]]
then
    sudo apt-get -y install git
fi

git clone https://github.com/Pierstoval/dotfiles "${HOME}/dotfiles"

cd "${HOME}/dotfiles"

bash ./install_local.sh
