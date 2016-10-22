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



echo "Home dir is ${HOME}"




echo "------------------------------"
echo "Installing config files"

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
echo "Installing binaries (some may need updates)"

files=( 'behat' 'box' 'composer' 'docker-compose' 'php-cs-fixer' 'phpunit' 'symfony' )

for FILE in "${files[@]}"
do
    echo -e "Downloading binary ${FILE}\c"
    wget --quiet -O "${HOME}/${FILE}" "https://raw.githubusercontent.com/Pierstoval/dotfiles/master/bin/${FILE}" > /dev/null 2>>install.log
    if [ -f "${HOME}/bin/${FILE}" ];
    then
       echo " > Ok !"
    else
       echo "\nERR > Binary ${FILE} could not be downloaded..."
    fi

    chmod a+x ${HOME}/bin/${FILE}
done





echo "------------------------------"
echo "Finished!"
echo ""
echo "Now you should load config file in current environment by executing this command:"
echo "source ~/.bash_aliases"

