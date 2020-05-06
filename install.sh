#!/usr/bin/env bash
# Script to automatically link a directory of config
# files as .files on a user's home directory
# it's meant to ease the mainainance of a centralized repo of configurations

# COLOURS
G="\033[0;32m"
R="\033[0;31m"
B="\033[0;34m"
Y="\033[0;33m"
RESET="\033[0m"

if [ "$(uname -s)" = 'Darwin' ]; then
  echo -e "$G==> Installing dependencies for mac OS $RESET"

  [ -z "$(which brew)" ] && 
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew cask install iterm2 caffeine firefox google-chrome

  brew install \
    ag coreutils cscope git graphviz imagemagick tree vim neovim wget zsh jq \
    ruby python go direnv

  brew tap universal-ctags/universal-ctags
  brew install --HEAD universal-ctags

else
  echo -e "$G==> Installing dependencies for Linux $RESET"
  apt install -y chromium-browser git jq neovim silversearcher-ag zsh
fi

git config --global user.email "otaran.federico@gmail.com"
git config --global user.name "Fede Otaran"

echo -e "$G ==> Start setup dotfiles!"

ln_files=("zshrc" "alacritty.yml")
backup_dir="${PWD}/backups/$(date "+%Y%m%d%H%M%S_backup")"

[ ! -d $backup_dir ] && mkdir -p $backup_dir

for name in *; do
  if [[ " ${ln_files[*]} " =~ " $name " ]]; then
    target="$HOME/.$name"

    if [ -a $target ]; then
      echo -e "$B [+] Backing up $target to $backup_dir/.$name"
      cp -r $target "$backup_dir/$name" 2> /dev/null
      echo -e "$R [-] Removing $target"
      rm -rf $target
    fi

    ln -s "$PWD/$name" "$target"
    echo -e "$G [>] Linked $PWD/$name to $target"
  else
    echo -e "$Y [~] Skipping ${name}"
  fi
done

echo -e "$G All done. $RESET"
