#!/bin/bash

echo "WARNING!"
echo "This can override all softwares you intend to install,"
echo "bash_aliases, vimrc, git config files, etc., so be sure of"
echo "what you are doing!"

# Get base user
BASE_USER=`whoami`

BASE_URL="https://raw.githubusercontent.com/Pierstoval/dotfiles/master"


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
echo ""
echo "------------------------------"
echo "Installing config files"

files=( 'bash_aliases' 'gitconfig' 'gitignore' 'inputrc' 'tmux.conf' 'vimrc' )

for FILE in ${files[@]}
do
    echo -e "Downloading file .${FILE}"

    # Read answer
    read -rsp $" Continue? [y/N] > " -n1 key

    if [[ ${key} =~ "y" ]]; then
        wget --quiet -O "${HOME}/.${FILE}" "${BASE_URL}/dotfiles/${FILE}" > /dev/null 2>>install.log
        if [ -f "${HOME}/.${FILE}" ];
        then
           echo " Ok !"
        else
           echo "ERR > File .${FILE} could not be downloaded..."
        fi
    else
        echo "Skip"
    fi
done


echo "------------------------------"
echo "Making sure that config files are loaded on shell startup"

# Create bashrc if not exists
[[ -f ~/.bashrc ]] || touch ~/.bashrc

# Add source bash_aliases if not present in bashrc
(cat ~/.bashrc | grep "bash_aliases") > /dev/null 2>&1 || echo "source ~/.bash_aliases" >> ~/.bashrc







echo "------------------------------"
echo "Installing binaries (some may need updates)"

# Create $HOME/bin if not exists
[[ -d "${HOME}/bin" ]] || mkdir "${HOME}/bin"

files=( 'behat' 'box' 'composer' 'docker-compose' 'php-cs-fixer' 'phpunit' 'symfony' 'touchpad-switcher.sh' )

read -rsp $" Download binaries? [Y/n] > " -n1 key

if [[ ${key} =~ "y" ]]; then
    for FILE in "${files[@]}"
    do
        echo -e "Downloading binary ${FILE}\c"
        wget --quiet -O "${HOME}/bin/${FILE}" "${BASE_URL}/bin/${FILE}" > /dev/null 2>>install.log
        if [ -f "${HOME}/bin/${FILE}" ];
        then
           echo " > Ok !"
        else
           echo "\nERR > Binary ${FILE} could not be downloaded..."
        fi

        chmod a+x ${HOME}/bin/${FILE}
    done
else
    echo "Skip"
fi



echo "Downloading other needed files"

download_file() {
    sourcefile=$1

    if [[ ${key} =~ "y" ]]; then
        for sourcefile in "${files[@]}"
        do
            echo -e "Downloading file ${sourcefile}\c"
            sudo wget --quiet -O "${sourcefile}" "${BASE_URL}/${sourcefile}" > /dev/null 2>>install.log
            if [ -f "${sourcefile}" ];
            then
               echo " > Ok !"
            else
               echo "\nERR > File ${sourcefile} could not be downloaded..."
            fi
        done
    else
        echo "Skip"
    fi
}

download_file "/etc/dnsmasq.d/localhost.dev"

echo "------------------------------"
echo "Finished!"
echo ""
echo "Now you should load config file in current environment by executing this command:"
echo "source ~/.bash_aliases"

