#!/bin/bash

echo "WARNING!"
echo "This can (and WILL) override all softwares you intend to install,"
echo "bash_aliases, vimrc, git config files, etc., so be sure of"
echo "what you are doing!"

if [[ $(which git) == "" ]]
then
    sudo apt install git
fi

mkdir -p ~/bin

# Bash
if [[ "${SHELL}" == "/bin/bash" ]]; then
  # Create bashrc if it does not exist
  [[ -f "${HOME}/.bashrc" ]] || touch "${HOME}/.bashrc"

  # Add source bash_aliases if not present in bashrc
  (cat "${HOME}/.bashrc" | grep "bash_aliases") > /dev/null 2>&1 || echo "source ${HOME}/.bash_aliases" >> "${HOME}/.bashrc"

  (cat "${HOME}/.bashrc" | grep "post-shell-start") > /dev/null 2>&1 || echo "source ./post-shell-start.bash" >> "${HOME}/.bashrc"
fi

# Zsh
if [[ "${SHELL}" == "/usr/bin/zsh" ]]; then
  if [[ ! -f "${HOME}/.zshrc" ]]; then
      touch "${HOME}/.zshrc"
  fi
  (cat "${HOME}/.bashrc" | grep "bash_aliases") > /dev/null 2>&1 || echo "source ./post-shell-start.bash" >> "${HOME}/.zshrc"
fi

# Copy dotfiles
cp -r "${HOME}"/dotfiles/dotfiles/* "${HOME}/"
cp -r "${HOME}"/dotfiles/dotfiles/.* "${HOME}/"
cp -r "${HOME}"/dotfiles/bin/* "${HOME}/bin/"

echo "------------------------------"
echo "Finished!"
echo ""
echo "Now you should load config file in current environment by executing this command:"
echo "source ~/.bash_aliases"
