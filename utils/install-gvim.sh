#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：configure-mac.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 15:07
#   Description   ：
# ================================================================
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo port install macvim

if [ -e "/usr/local/bin/gvim" ]; then
    sudo rm /usr/local/bin/gvim
fi

sudo ln -s /Applications/MacVim.app/Contents/bin/gvim /usr/bin/gvim

