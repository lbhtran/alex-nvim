#!/usr/bin/sh

ALEX_NVIM=~/.config/alex-nvim
export ALEX_NVIM

alias lvim='XDG_DATA_HOME=$ALEX_NVIM/share XDG_CONFIG_HOME=$ALEX_NVIM nvim'
export lvim

lvim
