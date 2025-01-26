#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：bspwm-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-20 19:48
#   Description   ：Install bspwm and related components
# ================================================================

parent_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

install_bspwm() {
    echo "Installing bspwm and sxhkd..."
    sudo apt install bspwm sxhkd -y
    
    [ -d $HOME/.config/bspwm ] || mkdir -p $HOME/.config/bspwm
    [ -d $HOME/.config/sxhkd ] || mkdir -p $HOME/.config/sxhkd
    
    ln -sf $parent_dir/assets/bspwmrc $HOME/.config/bspwm/bspwmrc
    ln -sf $parent_dir/assets/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
    
    sudo chmod a+x $HOME/.config/bspwm/bspwmrc
    sudo chmod a+x $HOME/.config/sxhkd/sxhkdrc
    echo "bspwm installation complete"
}

install_picom() {
    echo "Installing picom dependencies..."
    sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev \
        libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev \
        libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev \
        libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev \
        libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y

    if [ -d "$APPLICATION_DIR" ]; then
        echo "Installing picom from source..."
        mkdir -p $APPLICATION_DIR/picom
        git clone git@github.com:jonaburg/picom.git $APPLICATION_DIR/picom
        cd $APPLICATION_DIR/picom
        sudo apt install ninja meson -y
        meson --buildtype=release . build
        ninja -C build
        sudo ninja -C build install
        echo "picom installation complete"
    else
        echo "APPLICATION_DIR not found, skipping picom installation"
    fi
}

install_polybar() {
    echo "Installing polybar..."
    sudo apt install polybar -y
    echo "polybar installation complete"
}

install_rofi() {
    echo "Installing rofi..."
    sudo apt install rofi -y
    echo "rofi installation complete"
}

install_brightness() {
    echo "Setting up brightness controls..."
    sudo usermod -aG video $USER
    sudo apt install brightnessctl amixer -y
    echo "brightness controls setup complete"
}

usage() {
    echo "Usage: $0 [all|bspwm|picom|polybar|rofi|brightness]"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

case $1 in
    all)
        install_bspwm
        install_picom
        install_polybar
        install_rofi
        install_brightness
        ;;
    bspwm)
        install_bspwm
        ;;
    picom)
        install_picom
        ;;
    polybar)
        install_polybar
        ;;
    rofi)
        install_rofi
        ;;
    brightness)
        install_brightness
        ;;
    *)
        usage
        ;;
esac
