#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：rofi-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-22 14:49
#   Description   ：
# ================================================================

sudo apt install rofi

if [ $APPLICATION_DIR -ne 0 ]; then
    mkdir -p $APPLICATION_DIR
fi

git clone https://github.com/lr-tech/rofi-themes-collection.git $APPLICATION_DIR/rofi-themes-collection
cd $APPLICATION_DIR/rofi-themes-collection
mkdir -p ~/.local/share/rofi/themes
cp themes/* ~/.local/share/rofi/themes
