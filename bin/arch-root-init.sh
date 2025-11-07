#!/bin/sh

# RUN AS ROOT

# Locale
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen

# Deps
pacman -Syu --noconfirm sudo stow zsh git xclip vim base-devel

# User and groups
NEW_USER="domino"
NEW_USER_PASS="$(openssl rand -hex 4)"
NEW_USER_GROUPS="docker wheel"
# NEW_USER_PASS="$(tr -cd '[:graph:]' < /dev/urandom | head -c 8)" # Use this instead if it works on mac

if [ -z "$(getent passwd $NEW_USER)" ]; then
    useradd -m --shell /bin/zsh $NEW_USER

    echo "$NEW_USER:$NEW_USER_PASS" | chpasswd

    echo "The temp password for '$NEW_USER' is '$NEW_USER_PASS'"

    for group in $NEW_USER_GROUPS; do
        if [ -z "$(getent group $group)" ]; then
            groupadd $group
        fi
        usermod -a -G $group $NEW_USER
    done
fi

