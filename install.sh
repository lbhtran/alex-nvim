#!/usr/bin/sh

ALEX_NVIM=~/.config/alex-nvim
export ALEX_NVIM

rm -rf $ALEX_NVIM

mkdir -p $ALEX_NVIM/share
mkdir -p $ALEX_NVIM/nvim

stow --restow --target=$ALEX_NVIM/nvim .

alias lvim='XDG_DATA_HOME=$ALEX_NVIM/share XDG_CONFIG_HOME=$ALEX_NVIM nvim'
