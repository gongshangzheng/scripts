#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：download-alacritty.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 20:36
#   Description   ：
# ================================================================
# https://www.cnblogs.com/xyz/p/15944908.html
# 判断是否已经安装
if ! command -v alacritty &> /dev/null
then
    echo "alacritty is not installed. Installing..."
    # 判断系统
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo add-apt-repository ppa:aslatter/ppa
        sudo apt update
        sudo apt-get install alacritty
    fi
fi

# 创建目标目录（如果不存在）
mkdir -p "$HOME/.config/alacritty"

# 检查源文件是否存在
SOURCE="$HOME/scripts/utils/assets/alacritty-config.toml"
TARGET="$HOME/.config/alacritty/alacritty.toml"

if [ ! -e "$SOURCE" ]; then
    echo "Source file does not exist: $SOURCE"
    exit 1
fi

# 检查目标文件是否已经存在，如果存在则删除
if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
    echo "Deleting existing target: $TARGET"
    rm "$TARGET"
fi

# 创建软链接
ln -s "$SOURCE" "$TARGET"
if [ $? -eq 0 ]; then
    echo "Successfully created symlink: $SOURCE -> $TARGET"
else
    echo "Failed to create symlink: $SOURCE -> $TARGET"
fi

# 检查软链接是否存在
if [ -L "$TARGET" ]; then
    echo "Symlink created successfully: $TARGET"
else
    echo "Failed to create symlink: $TARGET"
fi
# delete
# sudo apt remove --auto-remove alacritty
# sudo add-apt-repository --remove ppa:aslatter/ppa
