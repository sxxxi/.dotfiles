export XDG_CONFIG_HOME="$HOME/.config";

OS_NAME=$(uname -s)

# Make sure the config folder is created
[ ! -d $XDG_CONFIG_HOME ] && mkdir $XDG_CONFIG_HOME

# SSH agent
if [ -z $SSH_AUTH_SOCK ] && [ -z "$(pgrep -u $USER ssh-agent)" ]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/gitkey > /dev/null
fi

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [ "$OS_NAME" = "Linux" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export PATH="/snap/bin:$PATH"
  export PATH="/home/seiji/.config/herd-lite/bin:$PATH"
  export PHP_INI_SCAN_DIR="/home/seiji/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
