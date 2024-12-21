#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：bspwm-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-20 19:48
#   Description   ：
# ================================================================

sudo apt install bspwm sxhkd -y
parent_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
#cd $parent_dir

ln $parent_dir/assets/bspwmrc $HOME/.config/bspwm/bspwmrc
ln $parent_dir/assets/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

sudo chmod a+x $HOME/.config/bspwm/bspwmrc
sudo chmod a+x $HOME/.config/sxhkd/sxhkdrc
#source $HOME/.zshrc
if [ -d $APPLICATION_DIR ]; then
    echo "picom is going to be installed in $APPLICATION_DIR/picom"
    cd $APPLICATION_DIR
    pwd
    git clone git@github.com:jonaburg/picom.git
    cd picom
    sudo apt install ninja meson
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
fi
