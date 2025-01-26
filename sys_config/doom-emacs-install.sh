#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：doom-emacs-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-20 23:03
#   Description   ：
# ================================================================

sudo apt install libtool
sudo apt install libvterm-dev
sudo apt install libsqlite3-dev

git clone git@github.com:gongshangzheng/emacs.git $HOME/.doom.d
if [ ! -d "$HOME/.doom.d" ]; then
    exit 1
fi
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install emacs
sudo apt install ripgrep df-find
# On 18.04 or older, ripgrep and fd-find won't be available in
# official repos. You'll need to install them another way, e.g.
sudo dpkg -i fd_8.2.1_amd64.deb  # adapt version number and architecture
git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install
$HOME/.emacs.d/bin/doom sync
sudo apt install librime-dev
# org music
sudo apt install mpv
sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
