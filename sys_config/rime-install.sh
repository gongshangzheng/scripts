#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：rime-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 10:41
#   Description   ：
# ================================================================

read -p "This script is due to install rime with the wubi jidian configuration, do you want to continue? (y/n)" input
if [ "$input" == "y" ]; then
    sudo apt install ibus
    read -p "Do you want to install from source ?(y|[n]):" install_from_source
    if [ "$install_from_source" == "y" ]; then
        git clone https://github.com/rime/ibus-rime.git $APPLICATION_DIR/ibus-rime --depth=1
        cd $APPLICATION_DIR/ibus-rime
        git submodule update --init --recursive
        (cd librime; make && sudo make install)
        (cd plum; make && sudo make install)
        make
        sudo make install
        #sudo usermod -aG rime $USER
    else
        sudo apt-get install ibus-rime
    fi
    ibus-setup
    echo "Please add rime to the ibus engine list"
    ibus restart
    ibus engine rime
else
    exit 0
fi
sudo apt install librime-dev
