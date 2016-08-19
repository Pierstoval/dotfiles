
# Command aliases
alias l='ls -lah --color=always --group-directories-first'
alias cdr='cd -P' # Runs "cd" with real paths instead of symlinked paths
alias ww='cdr ~/www'

# Git
alias gd='git diff'
alias gst='git status'
alias gl='git log'

# Symfony
alias sf='php bin/console'
alias sf2='php app/console'

# Git branch in bash if completion available
if [ -f "/etc/bash_completion.d/git-prompt" ]
then
    source /etc/bash_completion.d/git-prompt
    PS1=\[\033[0;32m\]\u\[\e[0m\]:\[\033[0;33m\]\w\[\033[0;36m\]$(__git_ps1)\[\e[0m\] $ 
else
    PS1=\[\033[0;32m\]\u\[\e[0m\]:\[\033[0;33m\]\w\[\033[0;36m\]\[\e[0m\] $ 
fi

