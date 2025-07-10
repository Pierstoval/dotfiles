

##
## <Bash specific>
##
if [[ "${SHELL}" == "/bin/bash" ]]; then

  # If not in interactive mode, don't do anything.
  case $- in
      *i*) ;;
        *) return;;
  esac

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
fi
##
## </Bash specific>
##

##
## <Zsh specific>
##
if [[ "${SHELL}" == "/bin/zsh" ]]; then
  export ZSH_THEME="powerlevel10k/powerlevel10k"

  # Path to your oh-my-zsh installation.
  if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    export ZSH="${HOME}/.oh-my-zsh"
  fi
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ -f "${HOME}/.p10k.zsh" ]] && "${HOME}/.p10k.zsh"

  CASE_SENSITIVE="false"
  HYPHEN_INSENSITIVE="true"
  DISABLE_UPDATE_PROMPT="true"
  DISABLE_MAGIC_FUNCTIONS="true"

  plugins=(git)

  setopt nullglob
  setopt cshnullglob

  [[ -f "${ZSH}/oh-my-zsh.sh" ]] && source "${ZSH}/oh-my-zsh.sh"
  setopt HIST_EXPIRE_DUPS_FIRST
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_FIND_NO_DUPS
  setopt HIST_SAVE_NO_DUPS

  # Keypad
  # 0 . Enter
  bindkey -s "^[Op" "0"
  bindkey -s "^[Ol" "."
  bindkey -s "^[OM" "^M"
  # 1 2 3
  bindkey -s "^[Oq" "1"
  bindkey -s "^[Or" "2"
  bindkey -s "^[Os" "3"
  # 4 5 6
  bindkey -s "^[Ot" "4"
  bindkey -s "^[Ou" "5"
  bindkey -s "^[Ov" "6"
  # 7 8 9
  bindkey -s "^[Ow" "7"
  bindkey -s "^[Ox" "8"
  bindkey -s "^[Oy" "9"
  # + -  * /
  bindkey -s "^[Ok" "+"
  bindkey -s "^[Om" "-"
  bindkey -s "^[Oj" "*"
  bindkey -s "^[Oo" "/"

fi
##
## </Zsh specific>
##


export EDITOR=vim
export MAILTO=pierstoval+prod@gmail.com
export LANG=fr_FR.utf8
export LC_ALL=$LANG

export PATH="${PATH}:${HOME}/.symfony/bin/"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:/usr/local/go/bin"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.composer/vendor/bin/"
export PATH="${PATH}:${HOME}/.rvm/bin"

# Load custom bin directory because it contains cool stuff & personal binaries
export PATH="${PATH}:${HOME}/bin/"
mkdir -p ~/bin

# In case Jetbrains Toolbox creates scripts
export PATH="${PATH}:${HOME}/.local/share/JetBrains/Toolbox/scripts/"

# In case Deno is installed
export DENO_INSTALL="${HOME}/.deno"
export PATH="${PATH}:${DENO_INSTALL}/bin"

# In case Bin is installed
export bun_install="$HOME/.bun"
export PATH="${PATH}:${bun_install}"

export WSL_IP=$(grep nameserver /etc/resolv.conf  | cut -d ' ' -f2)
export localhost=$WSL_IP

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[yellow]%}%(!.%1~.%~)%{$fg_bold[blue]%} $(git_prompt_info)%(?.%F{green}.%F{red}) $%{$reset_color%} '

# Command aliases
alias l='ls -lah --color=always --group-directories-first'
alias cdr='cd -P' # Runs "cd" with real paths instead of symlinked paths
alias dcp='docker compose'
alias dps='docker ps --format "{{\"\033[90m\"}} {{.ID}} {{\"\033[31m\"}}{{.Names}}{{\"\033[0m\"}} ({{.Status}}) {{\"\033[90m\"}}{{.Ports}}"'
alias digs='dig +noquestion +nostats +nocomments +nocmd'

# Git
alias gd='git diff'
alias gst='git status'
alias gl='git log'

# Symfony aliases
alias sf='php bin/console'
alias sf2='php app/console'
alias dsf='docker-compose exec php bin/console'

# Display connection, to run graphics apps in the host, when not possible.
# ⚠ To be used within a WSL1 setup (WSL2 seems to have that natively).
# On native linux, you don't need that.
# Uncomment if you need:
#export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

# Webserver alias
if [[ -d "~/www" ]]; then
    alias ww="cd ~/www"
elif [[ -d "/var/www" ]]; then
    alias ww="cd /var/www"
elif [[ -d "${HOME}/work" ]]; then
    alias ww="cd ${HOME}/work"
else
    alias ww='echo "No \"www\" directory found"'
fi

# Custom man config with colors
man () {
    env \
        LESS_TERMCAP_mb=$(print "\e[1;31m") \
        LESS_TERMCAP_md=$(print "\e[1;31m") \
        LESS_TERMCAP_me=$(print "\e[0m") \
        LESS_TERMCAP_se=$(print "\e[0m") \
        LESS_TERMCAP_so=$(print "\e[1;41;37m") \
        LESS_TERMCAP_ue=$(print "\e[0m") \
        LESS_TERMCAP_us=$(print "\e[1;35m") \
            man "$@"
}

# Start tmux if login shell + tmux exists + not running tmux inside tmux
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi
