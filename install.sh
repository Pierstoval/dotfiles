#!/bin/bash

type curl >/dev/null 2>&1 || { echo >&2 "You need 'curl', please install it before."; exit 127; }
type wget >/dev/null 2>&1 || { echo >&2 "You need 'wget', please install it before."; exit 127; }
type php >/dev/null 2>&1  || { echo >&2 "You need 'php', please install it before."; exit 127; }

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

files=( '.bash_aliases' '.gitconfig' '.gitignore' '.inputrc' '.tmux.conf' '.vimrc' )

for FILE in "${files[@]}"
do
    echo "Downloading file ${FILE}"
    wget --quiet -O "${HOME}/${FILE}" "https://raw.githubusercontent.com/Pierstoval/dotfiles/master/${FILE}" > /dev/null 2>>install.log
    if [ -f "${HOME}/${FILE}" ];
    then
       echo "> Ok !"
    else
       echo "ERR > File ${FILE} could not be downloaded..."
    fi
done

# Check if sudo exists
SUDO=''
if [[ -f /usr/bin/sudo ]]
then
    SUDO='/usr/bin/sudo'
fi




echo "------------------------------"
echo "Installing composer"

$SUDO php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
$SUDO php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
$SUDO php composer-setup.php > /dev/null 2>>install.log
$SUDO rm composer-setup.php
$SUDO cp composer.phar /usr/local/bin/composer
$SUDO chmod a+x /usr/local/bin/composer
$SUDO chown $BASE_USER /usr/local/bin/composer
composer --version



echo "------------------------------"
echo "Installing Symfony installer"

$SUDO curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony --silent > /dev/null 2>>install.log
$SUDO chmod a+x /usr/local/bin/symfony
$SUDO chown $BASE_USER /usr/local/bin/symfony
symfony --version



echo "------------------------------"
echo "Installing phpunit"

$SUDO wget --quiet -O "/usr/local/bin/phpunit" "https://phar.phpunit.de/phpunit.phar" > /dev/null 2>>install.log
$SUDO chmod a+x /usr/local/bin/phpunit
$SUDO chown $BASE_USER /usr/local/bin/phpunit
phpunit --version



echo "------------------------------"
echo "Installing Box-project"

curl -LSs https://box-project.github.io/box2/installer.php --silent | php > /dev/null 2>>install.log
$SUDO cp box.phar /usr/local/bin/box
$SUDO chmod a+x /usr/local/bin/box
$SUDO chown $BASE_USER /usr/local/bin/box
box --version



echo "------------------------------"
echo "Compiling and installing Behat"

/usr/local/bin/composer create-project behat/behat behat_install
box build -c behat_install/box.json
$SUDO cp behat.phar /usr/local/bin/behat
$SUDO chmod a+x /usr/local/bin/behat
$SUDO chown $BASE_USER /usr/local/bin/behat
rm -rf behat_install



echo "Finished!"
