#!/bin/bash

echo "WARNING!"
echo "This will override all softwares you intend to install,"
echo "bash_aliases, vimrc, git config files, etc., so be sure of"
echo "what you are doing!"

# Get base user
BASE_USER=`whoami`

# Match case insensitive
shopt -s nocasematch

# Read answer
read -rsp $'Continue? [Y/n] > ' -n1 key

if [[ ${key} =~ "y" ]]
then
    echo "Processing!"
else
    echo "Ok, bye then!"
    exit 1
fi


echo "Installing config files"

echo "Home dir is ${HOME}"

files=( 'bash_aliases' 'gitconfig' 'gitignore' 'inputrc' 'tmux.conf' 'vimrc' )

for FILE in "${files[@]}"
do
    echo -e "Downloading file .${FILE}\c"
    wget --quiet -O "${HOME}/.${FILE}" "https://raw.githubusercontent.com/Pierstoval/dotfiles/master/dotfiles/${FILE}" > /dev/null 2>>install.log
    if [ -f "${HOME}/.${FILE}" ];
    then
       echo " > Ok !"
    else
       echo "\nERR > File .${FILE} could not be downloaded..."
    fi
done


echo "------------------------------"
echo "Making sure that config files are loaded on shell startup"

(cat ~/.bashrc | grep "bash_aliases") > /dev/null 2>&1 || echo "source ~/.bash_aliases" >> ~/.bashrc







echo "------------------------------"
echo "Installing binaries"

if [[ ! -d ~/bin ]]
then
    mkdir ~/bin -p
fi

cp bin/* ~/bin/ 






echo "------------------------------"
echo "Finished!"
echo ""
echo "Now you should load config file in current environment by executing this command:"
echo "source ~/.bash_aliases"

