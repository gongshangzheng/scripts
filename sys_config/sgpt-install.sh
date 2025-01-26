#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：sgpt-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 11:47
#   Description   ：
# ================================================================

sudo apt install python3-virtualenv
parent_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $parent_dir
cd ../py_scripts
pip install -r requirements.txt
