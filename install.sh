#!/bin/bash -e
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

#
# Installs a symlink for the given file.
#
# Used like:
#  $ install_alias HomeBasename [ Dotfiles basename ]
#
# @param $1 The dotfile basename to alias from the Dotfiles dir.
# @param $2 Optional. If provided is defined to be the basename of the file in Dotfiles.
#
function install_alias {
  HOME_BASENAME="$1"
  DOTFILES_BASENAME="$1"

  if [ ! -z "$2" ]; then
    # Second argument provided.
    DOTFILES_BASENAME="$2"
  fi

  if [[ -f "$HOME/$HOME_BASENAME" || -L "$HOME/$HOME_BASENAME" ]]; then
    if [ ! -f /.dockerenv ]; then
      echo "WARNING: ~/$HOME_BASENAME exists"
      diff -u "$HOME/$HOME_BASENAME" "$SCRIPT_DIR/$DOTFILES_BASENAME" && ret=0 || ret=$?
      if [ "$ret" -ne 0 ]; then
        while true; do
          read -p "Overwrite [y/n]?" yn
          case $yn in
              [Yy]* ) break;;
              [Nn]* ) exit;;
              * ) echo "Please answer y/n.";;
          esac
        done
      fi
    else
      # If we're in docker, backup the original in case we want to reference later.
      mv "$HOME/$HOME_BASENAME" "$HOME/$HOME_BASENAME.bak"
    fi

    ln -sf "$SCRIPT_DIR/$DOTFILES_BASENAME" "$HOME/$HOME_BASENAME"
  else
    ln -s "$SCRIPT_DIR/$DOTFILES_BASENAME" "$HOME/$HOME_BASENAME"
  fi
}

install_alias ".zshrc"
install_alias ".inputrc"

if [ ! -f /.dockerenv ]; then
  GITCONFIG_LOCAL_DOTFILE="$SCRIPT_DIR/.gitconfig.$HOSTNAME"
  if [ ! -f "$GITCONFIG_LOCAL_DOTFILE" ]; then
    echo "Creating machine-specific file: $GITCONFIG_LOCAL_DOTFILE"
    touch "$GITCONFIG_LOCAL_DOTFILE"
  fi

  # Only sync gitconfig if we're not in a docker container.
  install_alias ".gitconfig.local" ".gitconfig.$HOSTNAME"
  install_alias ".gitconfig"
fi

if [[ `uname` == "Darwin" ]]; then
  echo "The following packages need to be installed:"
  echo " $ brew install coreutils"
  echo ""
  echo "Also install Fira Code:"
  echo " $ brew tap homebrew/cask-fonts"
  echo " $ brew install --cask font-fira-code"
  echo ""
else
  echo "Don't forget to install Fira Code."
fi