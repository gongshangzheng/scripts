#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：run_commands.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 01:02
#   Description   ：
# ================================================================
#LAUNCHER="dmenu -l 5 -i -p "
LAUNCER="rofi -dmenu -i -p "
[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "

declare -A commands
commands["qutebrowser"]="bash ~/scripts/tools/open-qutebrowser.sh"
commands["firefox"]="firefox"
commands["emacs"]="emacs"
commands["emacsclient"]="emacsclient -c"
commands["run commands"]="bash /home/xinyu/scripts/dmenu/run_commands.sh"
commands["alacritty"]="alacritty"
commands["sxhkd reload"]="pkill -x sxhkd; sxhkd &"
#commands["keyd reload" ]="sudo keyd reload" #need sudo, please just run it in the terminal
commands["polybar reload"]="~/.config/polybar/hack/launch.sh"
commands["bspwm reload"]="bspc wm -r"
commands["logout"]="bspc quit"
commands["shutdown"]="shutdown now"
commands["screen shot"]="flameshot gui"
commands["default windows"]="bash /home/xinyu/scripts/tools/open-default-windows.sh"

# Create a string to display key | value pairs
command_list=""
for key in "${!commands[@]}"; do
    command_list+="$key | ${commands[$key]}\n"
done

# Show the key | value list in the launcher
choice=$(echo -e "$command_list" | $LAUNCER "Commands:") || exit 1

# Extract the key (before the first " | ") from the selected choice
selected_command=$(echo "$choice" | cut -d'|' -f2)
#printf "Selected command: %s\n" "$selected_command"
# Execute the corresponding command
eval "$selected_command"
