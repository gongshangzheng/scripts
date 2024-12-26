#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：install-vim-anywhre.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 07:29
#   Description   ：
# ================================================================

sudo apt install -y vim-gtk3 xclip
curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/install | bash
