#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：aliases.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 12:35
#   Description   ：
# ================================================================
#
# https://www.youtube.com/watch?v=P7Jd0iNSCQA
alias la="ls -a"
alias ll="ls -alF"
alias lla="ls -la"
alias l="ls -CF"
# shopt -s autocd #自动进入目录
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias .3="cd ../../../.."
alias .4="cd ../../../../.."
alias .5="cd ../../../../../.."
alias .6="cd ../../../../../../.."
alias gs="git status"
alias ga="git add"
alias gc="git commit"

# export
export HISTCONTROL=ignoreboth #忽略重复命令
export EDITOR="emacsclient -c"
export TERMINAL="alacritty"
export BROWSER=qutebrowser

# bspc
# bspc rule -a Gimp desktop='^8' state=floating follow=on
# bspc rule -a Chromium desktop='^2'
# 10/2

