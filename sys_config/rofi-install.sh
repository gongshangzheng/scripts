#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：rofi-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-22 14:49
#   Description   ：
# ================================================================

sudo apt install -y git meson ninja-build pkg-config libpango1.0-dev libcairo2-dev libxkbcommon-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-imdkit-dev libxcb-xkb-dev libxkbcommon-x11-dev libxcb-ewmh-dev \
    libxcb-icccm4-dev libstartup-notification0-dev flex bison


 # Ask about Chinese support
read -p "Do you need Chinese support? [y/N] " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
     # Create application directory if it doesn't exist
    APPLICATION_DIR="${APPLICATION_DIR:-$HOME/applications}"
    mkdir -p "$APPLICATION_DIR"
    # Clone and build rofi with Chinese support
    cd "$APPLICATION_DIR"
    git clone https://github.com/davatorium/rofi.git
    cd rofi
    git submodule update --init
    meson setup build
    ninja -C build
    sudo ninja -C build install
else
    sudo apt install -y rofi
fi

# 克隆主题并复制
if ! [[ -e $APPLICATION_DIR/rofi-themes-collection ]]; then
    git clone https://github.com/lr-tech/rofi-themes-collection.git $APPLICATION_DIR/rofi-themes-collection || exit 1
    cd $APPLICATION_DIR/rofi-themes-collection || exit 1
    mkdir -p ~/.local/share/rofi/themes
    cp themes/* ~/.local/share/rofi/themes || exit 1
fi
