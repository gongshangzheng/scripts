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

mkdir $HOME/.config/bspwm/
mkdir $HOME/.config/sxhkd/
ln $parent_dir/assets/bspwmrc $HOME/.config/bspwm/bspwmrc
ln $parent_dir/assets/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

sudo chmod a+x $HOME/.config/bspwm/bspwmrc
sudo chmod a+x $HOME/.config/sxhkd/sxhkdrc
#source $HOME/.zshrc

#################################################
#picom
#################################################

sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
if [ -d $APPLICATION_DIR ]; then
    echo "picom is going to be installed in $APPLICATION_DIR/picom"
    cd $APPLICATION_DIR
    pwd
    git clone git@github.com:jonaburg/picom.git $APPLICATION_DIR/picom
    cd picom
    sudo apt install ninja meson
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
fi

#################################################
#polybar
#################################################

sudo apt install polybar

#################################################
#rofi
#################################################

sudo apt install rofi

#################################################
#brightness
#################################################
sudo usermod -aG video $USER
sudo apt install brightnessctl
sudo apt install amixer
