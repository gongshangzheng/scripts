#!/bin/bash
# ================================================================
#   Copyright (C) 2025 www.361way.com site All rights reserved.
#
#   Filename      ：youtube-dl-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2025-02-11 12:20
#   Description   ：
# ================================================================
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install curl -y
sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod 755 /usr/local/bin/youtube-dl
