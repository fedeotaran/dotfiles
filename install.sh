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

# Install direnv
echo -e "$G Installing direnv..."

if [[ ! -d ~/.direnv ]]; then
  current_dir=`pwd`
  git clone https://github.com/direnv/direnv ~/.direnv
  cd .direnv
  make install
  cd $current_dir
fi

echo -e "$G done. $RESET"

# Files to create symbolics links
echo -e "$G Config dotfiles..."

ln_files=("zshrc")
bckpdir="${PWD}/backups/$(date "+%Y%m%d%H%M%S_backup")"
[ ! -d $bckpdir ] && mkdir -p $bckpdir
for name in *; do
  if [[ ${ln_files[*]} =~ $name ]]; then
    target="$HOME/.$name"

    if [ -a $target ]; then
      echo -e "$B [+] Backing up $target to $bckpdir/.$name"
      cp -r $target $bckpdir
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
