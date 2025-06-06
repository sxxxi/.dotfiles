#!/bin/zsh

# !!REQUIRES!! -> [ zsh, tmux ]
# SOURCE THIS AT THE VERY END OF THE ZSHRC

# Starship
if [ ! -s /usr/local/bin/starship ]; then
    echo "Installing starship...";
    curl -sS https://starship.rs/install.sh | sh;
fi;

# |=============================|
# |		Zinit shennanigans				|
# |=============================|
# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# Use emacs mode
bindkey -e
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# |=============================|
# |         Aliases             |
# |=============================|
alias ls="ls --color"
alias l="ls --color"
alias la="ls -a --color"
alias lla="ls -la --color"
a() {
    if [ -z "$TMUX" ]; then
        tmux new-session -As DEV -c "$1" -n "VIM" \; \
        send-keys "nvim" C-m \; \
        new-window -d \; \
        new-window -d \; \
        new-window -d \;
    else
        echo 'Already in a session';
    fi;
}

alias psvn="svn --username 'akakabe.seiji.ap' --password '3269akakabe.seiji.ap'"

# |=============================|
# |         Variables           |
# |=============================|
export FUNAI="https://tr2p.poweredge.co.jp/repos/funai_jinzai/branches";
export FUNAI_ROOT="https://tr2p.poweredge.co.jp/repos/funai_jinzai";

# |=============================|
# |         Entrypoint          |
# |=============================|
clear && eval "$(starship init zsh)";
