#!/bin/zsh

# !!REQUIRES!! -> [ zsh, tmux ]
# SOURCE THIS AT THE VERY END OF THE ZSHRC

# |=============================|
# |         Variables           |
# |=============================|
export XDG_CONFIG_HOME="$HOME/.config"

# |=============================|
# |    Zinit shennanigans       |
# |=============================|
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit packages
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# Enable emacs mode
bindkey -e
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
export HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Add Brew home if installed in Linux
if [ "$(uname -s)" = "Linux" ] && [ -d "/home/linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# |=============================|
# |         Aliases             |
# |=============================|
alias ls="ls --color"
alias l="ls"
alias la="ls -a"
alias lla="ls -la"
alias ll="ls -l"

# |=============================|
# |         Entrypoint          |
# |=============================|
clear && eval "$(starship init zsh 2> /dev/null)"
