#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：install-qutebrowser.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 14:37
#   Description   ：
# ================================================================
set -x

# 检查当前操作系统是否是 macOS
if [[ "$(uname)" == "Darwin" ]]; then

    sudo ln /Applications/qutebrowser.app/Contents/MacOS/qutebrowser /usr/local/bin/qutebrowser
    # 定义源文件和目标文件路径
    SOURCE="$HOME/scripts/utils/assets/qutebrowser-autoconfig.yml"
    TARGET="$HOME/Library/Preferences/qutebrowser/autoconfig.yml"

    # 创建目标目录（如果不存在）
    sudo mkdir -p "$(dirname "$TARGET")"

    # 检查目标文件是否已经存在，如果存在则删除
    if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
        sudo rm "$TARGET"
    fi

    # 创建软链接
    sudo ln "$SOURCE" "$TARGET"
    echo "Successfully created symlink: $SOURCE -> $TARGET"
elif [[ "$(uname)" == "Linux" ]]; then
    # 判断是否已经安装了 qutebrowser
    if [ ! -d $APPLICATION_DIR ]; then
	    git clone git@github.com:qutebrowser/qutebrowser.git "$APPLICATION_DIR"
	    cd $APPLICATION_DIR/qutebrowser
	    python3 scripts/mkenv.py
    fi
fi

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
 # 定义源文件和目标文件路径
SOURCE="$parent_path/assets/qutebrowser-config.py"
TARGET="$HOME/.config/qutebrowser/config.py"

# 创建目标目录（如果不存在）
mkdir -p "$(dirname "$TARGET")"

# 检查目标文件是否已经存在，如果存在则删除
if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
    sudo rm -f "$TARGET"
fi

# 创建软链接
ln "$SOURCE" "$TARGET"
if [ $? -eq 0 ]; then
    echo "Successfully created symlink: $SOURCE -> $TARGET"
else
    echo "Failed to create symlink: $SOURCE -> $TARGET"
fi
wget https://raw.githubusercontent.com/adlered/CSDNGreener/refs/heads/master/csdngreener_openuserjs.user.js -O ~/.local/share/qutebrowser/greasemonkey/csdngreener_openuserjs.user.js
wget 'https://greasyfork.org/scripts/9165-auto-close-youtube-ads/code/Auto%20Close%20YouTube%20Ads.user.js' -O ~/.local/share/qutebrowser/greasemonkey/yt-autoclose.js
