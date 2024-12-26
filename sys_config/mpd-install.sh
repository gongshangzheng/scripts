#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：mpd-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-22 03:41
#   Description   ：
# ================================================================

sudo apt-get install mpd
sudo --user systemctl enable mpd
sudo apt install mpc
