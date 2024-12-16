#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：install-qutebrowser.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 14:37
#   Description   ：
# ================================================================

ln -s /Applications/qutebrowser.app/Contents/MacOS/qutebrowser /usr/local/bin/qutebrowser
# 检查当前操作系统是否是 macOS
if [[ "$(uname)" == "Darwin" ]]; then
    # 定义源文件和目标文件路径
    SOURCE="/Users/xinyu/scripts/utils/assets/qutebrowser-autoconfig.yml"
    TARGET="/Users/xinyu/Library/Preferences/qutebrowser/autoconfig.yml"

    # 创建目标目录（如果不存在）
    sudo mkdir -p "$(dirname "$TARGET")"

    # 检查目标文件是否已经存在，如果存在则删除
    if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
        sudo rm "$TARGET"
    fi

    # 创建软链接
    sudo ln -s "$SOURCE" "$TARGET"
    echo "Successfully created symlink: $SOURCE -> $TARGET"

     # 定义源文件和目标文件路径
    SOURCE="/Users/xinyu/scripts/utils/assets/qutebrowser-config.py"
    TARGET="/Users/xinyu/.qutebrowser/config.py"

    # 创建目标目录（如果不存在）
    sudo mkdir -p "$(dirname "$TARGET")"

    # 检查目标文件是否已经存在，如果存在则删除
    if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
        sudo rm "$TARGET"
    fi

    # 创建软链接
    sudo ln -s "$SOURCE" "$TARGET"
    echo "Successfully created symlink: $SOURCE -> $TARGET"

else
    echo "This script is only intended to run on macOS."
fi

