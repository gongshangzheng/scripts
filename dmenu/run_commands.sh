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
commands["qutebrowser"]="qutebrowser"
commands["emacs"]="emacsclient -c"
commands["run commands"]="bash /home/xinyu/scripts/dmenu/run_commands.sh"
commands["alacritty"]="alacritty"

# Create a string to display key | value pairs
command_list=""
for key in "${!commands[@]}"; do
    command_list+="$key | ${commands[$key]}\n"
done

# Show the key | value list in the launcher
choice=$(echo -e "$command_list" | $LAUNCHER "Commands:") || exit 1

# Extract the key (before the first " | ") from the selected choice
selected_command=$(echo "$choice" | cut -d'|' -f2)
#printf "Selected command: %s\n" "$selected_command"
# Execute the corresponding command
eval "$selected_command"
