#!/bin/zsh

# This is SLLLOOOOOOWWWWW
function formula_installed () {
  brew list $1 > /dev/null 2>&1
  return $?
}

function package_installed () {
  if [ -z $(command -v $1) ]; then
    return 1
  else
    return 0
  fi
}


# Make sure brew is installed before installing packages
if ! package_installed brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

deps=("nvim" "tmux" "ghostty" "stow" "git" "ripgrep")
to_install=()

# Queue package names not found in the system
for package in "${deps[@]}"; do
  if ! formula_installed "$package"; then
    echo "adding $package"
    to_install+=("$package")
  fi
done

# Install pacakges from the queue
if [ ${#to_install} -gt 0 ]; then
  echo "installing ${to_install[@]}"
  # brew install ${to_install[*]}
fi

# Create .config dir if not exist
if [ ! -d ~/.config ]; then;
  mkdir ~/.config
fi;

# Stow config files
stow -d ~/.dotfiles/config -t ~ .
source "$HOME/.zprofile"

