#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：git-repositories.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 00:07
#   Description   ：
# ================================================================

declare -A REPOS=(
    ["MyConf"]="git@github.com:gongshangzheng/MyConf.git $HOME/MyConf"
    ["vim_runtime"]="git@github.com:gongshangzheng/my_vim.git $HOME/.vim_runtime"
    ["rime"]="git@github.com:gongshangzheng/my_rime.git $HOME/.config/ibus/rime"
    ["doom"]="git@github.com:gongshangzheng/emacs.git $HOME/.doom.d"
    ["blogs"]="git@github.com:gongshangzheng/gsai.git $HOME/blogs"
    ["org"]="git@github.com:gongshangzheng/Org.git $HOME/org"
)


function git_sync_repo() {
    local name=$1
    local repo_info=(${REPOS[$name]})
    local repo_url=${repo_info[0]}
    local repo_path=${repo_info[1]}

    if [ -d "$repo_path" ]; then
        echo "Updating $name..."
        git -C "$repo_path" pull
    else
        echo "Cloning $name..."
        git clone "$repo_url" "$repo_path"
    fi
}

if [ ! -d "$HOME/.ssh" ]; then
    echo "ssh dir not exist, please generate ssh key first"
    exit 1
fi

# Get list of repo names
repo_names=(${!REPOS[@]})

# Let user select repos using fzf
selected_repos=($(printf '%s\n' "${repo_names[@]}" | fzf -m --prompt="Select repos to sync: "))

# Sync selected repos
for repo in "${selected_repos[@]}"; do
    git_sync_repo "$repo"
done
