#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：run_files.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 01:02
#   Description   ：
# ================================================================
LAUNCHER="dmenu -l 5 -i -p "
EDITOR="emacsclient -c"
[ -z "${DISPLAY}" ] && LAUNCHER="fzf --prompt "

declare -A files
files["user dict"]="$HOME/.config/ibus/rime/wubi86_jidian_user.dict.yaml"
files["default dict"]="$HOME/.config/ibus/rime/wubi86_jidian.dict.yaml"
files["emacs config"]="$HOME/.doom.d/my_config.org"
files["dmenu files"]="$HOME/scripts/dmenu/edit-file.sh"
files["dmenu bookmarks"]="$HOME/scripts/dmenu/list-qutebrowser-bookmarks.sh"
files["dmenu commands"]="$HOME/scripts/dmenu/run_commands.sh"
files["dmenu words"]="$HOME/scripts/dmenu/words-completion.sh"

# Create a string to display key | value pairs
file_list=""
#printf "%s\n" "${!files[@]}"
for key in "${!files[@]}"; do
    printf "key: %s\n" "$key"
    printf "value: %s\n" "${files[$key]}"
    printf "%s | %s\n" "$key" "${files[$key]}"
    file_list+="$key | ${files[$key]}\n"
done

# Show the key | value list in the launcher
choice=$(echo -e "$file_list" | $LAUNCHER "edit files:") || exit 1

# Extract the key (before the first " | ") from the selected choice
selected_file=$(echo "$choice" | cut -d'|' -f2)
#printf "Selected file: %s\n" "$selected_file"
# Execute the corresponding file
eval "$EDITOR $selected_file &"
