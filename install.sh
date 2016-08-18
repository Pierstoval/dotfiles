#!/bin/bash

echo "Installing config files"

echo "Home dir is ${HOME}"

files=( '.bashrc' '.gitconfig' '.gitignore' '.inputrc' '.tmux.conf' '.vimrc' )

for FILE in "${files[@]}"
do
    echo "Downloading file ${FILE}"
    wget --quiet -O "${HOME}/${FILE}" "https://raw.githubusercontent.com/Pierstoval/dotfiles/master/${FILE}"
    if [ -f "${HOME}/${FILE}" ];
    then
       echo "> Ok !"
    else
       echo "ERR > File ${FILE} could not be downloaded..."
    fi
done



echo "Installing composer"

sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
sudo chmod a+x /usr/local/bin/composer
sudo chown `whoami` /usr/local/bin/composer
composer --version



echo "Installing Symfony installer"

sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony
sudo chown `whoami` /usr/local/bin/symfony
symfony --version



echo "Installing phpunit"

wget https://phar.phpunit.de/phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
sudo chmod a+x /usr/local/bin/phpunit
sudo chown `whoami` /usr/local/bin/phpunit
phpunit --version



echo "Installing Box-project"

curl -LSs https://box-project.github.io/box2/installer.php | php
sudo mv box.phar /usr/local/bin/box
sudo chmod a+x /usr/local/bin/box
sudo chown `whoami` /usr/local/bin/box
box --version



echo "Compiling and installing Behat"

composer create-project behat/behat behat_install
box build -c behat_install/box.json
sudo mv behat.phar /usr/local/bin/behat
sudo chmod a+x /usr/local/bin/behat
sudo chown `whoami` /usr/local/bin/behat
rm -rf behat_install



echo "Finished!"

