#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：zotero-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-24 11:09
#   Description   ：
# ================================================================

# https://github.com/retorquere/zotero-deb
# zotero
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
sudo apt update
sudo apt install zotero
# jurism
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
sudo apt update
sudo apt install jurism
