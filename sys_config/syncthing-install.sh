#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename        ：syncthing-install.sh
#   Author          ：yangbk <itybku@139.com>
#   Create Time     ：2024-12-22 16:45
#   Description     ：
#   Reference Source: https://computingforgeeks.com/how-to-install-and-use-syncthing-on-ubuntu/
# ================================================================
sudo apt install curl apt-transport-https
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing release" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt update
sudo apt install syncthing
