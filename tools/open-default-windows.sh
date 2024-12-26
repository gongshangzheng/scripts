#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：open-default-windows.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-22 15:45
#   Description   ：
# ================================================================
qutebrowser="bash $HOME/scripts/tools/open-qutebrowser.sh"

bspc desktop -f '^2'
$qutebrowser &
sleep 2
bspc desktop -f '^3'
emacsclient -c &
sleep 0.4
bspc node -t fullscreen
bspc desktop -f '^6'
emacsclient -c ~/.doom.d/org/inbox.org &
sleep 0.8
bspc node -t fullscreen
bspc desktop -f '^7'
$qutebrowser gmail.com --target window &
$qutebrowser  https://mail.centralelille.fr/zimbra/mail  --target window &
sleep 2
bspc desktop -f '^1'
alacritty &
