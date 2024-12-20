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

cp /usr/share/doc/bspwm/examples/bspwmrc $HOME/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

sudo chmod a+x $HOME/.config/bspwm/bspwmrc
sudo chmod a+x $HOME/.config/sxhkd/sxhkdrc
