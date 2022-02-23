
# Using .bash_aliases allows keeping default .bashrc or .bash_profile files.

# If not in interactive mode, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

export EDITOR=vim
export MAILTO=pierstoval+prod@gmail.com

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Update window size after each command
shopt -s checkwinsize

# Don't put duplicate lines or empty lines in history
HISTCONTROL=ignoreboth

# Add bash completion if exists
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# Command aliases
alias l='ls -lah --color=always --group-directories-first'
alias cdr='cd -P' # Runs "cd" with real paths instead of symlinked paths

# Git
alias gd='git diff'
alias gst='git status'
alias gl='git log'

# Want to generate a password?
# Example:
#   $ genpw 8
#   rF5ecY4G
# Copyright @jpauli for this trick 🐍
alias genpw='_genpw() { len="${1:-36}"; tr -dc A-Za-z0-9_!? < /dev/urandom | head -c ${len} | xargs; }; _genpw'

alias phpqa='mkdir -p $(pwd)/tmp-phpqa && docker run --init -it --rm -v $(pwd):/project -v $(pwd)/tmp-phpqa:/tmp -w /project jakzal/phpqa:alpine'

# Symfony aliases
alias sf='php bin/console'
alias sf2='php app/console'
alias dsf='docker-compose exec php bin/console'

# For Symfony CLI to be in the PATH by default.
export PATH=$PATH:"${HOME}/.symfony/bin/"

# To be used within a WSL setup ONLY.
# On native linux, you don't need that.
# export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

# Webserver alias
if [[ -d "~/www" ]]; then
    alias ww="cd ~/www"
elif [[ -d "/var/www" ]]; then
    alias ww="cd /var/www"
else
    alias ww='echo "No \"www\" directory found"'
fi


# Load custom bin directory because it contains cool stuff & personal binaries
export PATH=$PATH:"${HOME}/bin/"

# Change locale if needed
[[ $LANG ]] || export LANG=fr_FR.utf8
[[ $LC_ALL ]] || export LC_ALL=$LANG

# Start tmux if login shell + tmux exists + not running tmux inside tmux
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

