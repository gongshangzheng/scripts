#!/bin/bash
#!/usr/bin/env sh 

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

REPO_URL="https://github.com/rvaiya/keyd.git"
TARGET_DIRECTORY="$APPLICATION_DIR/keyd/"
if [ -d "$TARGET_DIRECTORY" ]; then
    echo "目标目录 '$TARGET_DIRECTORY' 已存在，跳过克隆。"
else
    git clone "$REPO_URL" "$TARGET_DIRECTORY"
    cd $TARGET_DIRECTORY
    sudo systemctl enable keyd && sudo systemctl start keyd
    if [ ! -e "$HOME/.XCompose" ]; then
	ln /usr/local/share/keyd/keyd.compose $HOME/.XCompose
    fi
    sudo usermod -aG keyd $USER
fi

cd $TARGET_DIRECTORY
echo "Begining make ..."
make && sudo make install || exit 0
sudo systemctl enable --now keyd
sudo keyd reload
