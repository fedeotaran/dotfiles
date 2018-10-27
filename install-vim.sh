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

echo -e "$G ==> Downloading vim configuration $RESET"

[[ -d dir ]] ||
  git clone https://github.com/fedeotaran/vim-config.git "${PWD}/libs/vim-config"

cd "${PWD}/libs/vim-config"

bash install.sh
