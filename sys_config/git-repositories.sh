#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：git-repositories.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 00:07
#   Description   ：
# ================================================================

if [ ! -d "$HOME/.ssh" ]; then
    echo "ssh dir not exist, please generate ssh key first"

    exit 1
fi

git clone git@github.com:gongshangzheng/MyConf.git ~/MyConf
git clone git@github.com:gongshangzheng/my_vim.git ~/.vim_runtime
git clone git@github.com:gongshangzheng/my_rime.git ~/.config/ibus/rime
git clone git@github.com:gongshangzheng/emacs.git ~/.doom.d
git clone git@github.com:gongshangzheng/gsai.git ~/blogs
