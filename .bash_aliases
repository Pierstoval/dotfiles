
# If not in interactive mode, don't do anything.
case "$-" in
    *i*)    echo "Shell seems interactive" ;;
    *)      echo "Shell does not seem to be interactive." && return ;;
esac

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Add bash completion if exists
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# Command aliases
alias l='ls -lah --color=always --group-directories-first'
alias cdr='cd -P' # Runs "cd" with real paths instead of symlinked paths
alias ww='cdr ~/www'

# Git
alias gd='git diff'
alias gst='git status'
alias gl='git log'

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local exit_code="$?"

    # Bash prompt look & colors
    PS1=''
    PS1=$PS1'\[\033[0;32m\]' # Green
    PS1=$PS1'\u@\h'          # Username and host
    PS1=$PS1'\[\e[0m\]'      # Reset color
    PS1=$PS1' '
    PS1=$PS1'\[\033[0;33m\]' # Brown/orange
    PS1=$PS1'\w'             # Current directory
    PS1=$PS1'\[\e[0m\]'      # Reset color
    PS1=$PS1''
    if [ -f "/etc/bash_completion.d/git-prompt" ]
    then
        # Git branch in bash if completion available
        source /etc/bash_completion.d/git-prompt
        PS1=$PS1'\[\033[0;36m\]' # teal/light blue
        PS1=$PS1'$(__git_ps1)\[\e[0m\] ' # Git branch
    fi

    # Dollar (or sharp) will change color depending on last exit code
    if [ $exit_code != "0" ]
    then
        PS1=$PS1'\[\033[0;31m\]' # Red
    else
        PS1=$PS1'\[\033[0;32m\]' # Green
    fi

    PS1=$PS1'\$'        # Final dollar (or sharp) sign
    PS1=$PS1'\[\e[0m\]' # Reset color
    PS1=$PS1' '         # Space
}
