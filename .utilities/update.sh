#!/bin/bash
shopt -s expand_aliases
source $HOME/.bash_aliases

BRANCH=`config rev-parse --abbrev-ref HEAD`
PROTECTED_BRANCHES="^(master|dev)"

config add $HOME/.tmux.conf
config add $HOME/.config/lvim/config.lua
config add $HOME/.bashrc
config add $HOME/.bash_aliases
config add $HOME/.utilities/

config status -uno

config commit -m "updating from ${HOSTNAME}"
config push origin master

# if [[ "$BRANCH" =~ $PROTECTED_BRANCHES ]]; then
#   read p "Are you sure you want to push to \"$BRANCH\" ? (y/n): " -n 1 r < /dev/tty
#   echo
#   if [[ $REPLY =~ ^[Yy]$ ]]; then
#     exit 0
#   fi
#   echo "Push aborted."
#   config reset $HOME/.tmux.conf
#   config reset $HOME/.config/lvim/config.lua
#   config reset $HOME/.bashrc
#   config reset $HOME/.bash_aliases
#   config reset $HOME/.utilities/
#   exit 1
# fi
# exit 0


