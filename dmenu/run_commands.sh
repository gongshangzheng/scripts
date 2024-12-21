#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：run_commands.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 01:02
#   Description   ：
# ================================================================
LAUNCHER="dmenu -l 5 -i -p "
[ -z "${DISPLAY}" ] && LAUNCHER="fzf --prompt "

declare -A commands
commands["emacs"]="emacsclient -c"
commands["alacritty"]="alacritty"
commands["qutebrowser"]="qutebrowser"
commands["run commands"]="/home/xinyu/scripts/dmenu/run_commands.sh"
printf '%s\n' "${commands[@]}"

choice=$(printf '%s\n' "${commands[@]}" | sort | $LAUNCHER "Commands:") || exit 1
eval "${commands[$choice]}"
