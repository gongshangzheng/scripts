#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：open-qutebrowser.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-22 01:11
#   Description   ：
# ================================================================
# Determine the operating system
OS_TYPE=$(uname)

if [ "$OS_TYPE" == "Darwin" ]; then
    # macOS-specific commands
    echo "Running on macOS"
    /usr/local/bin/qutebrowser "$@"
    # Example command for macOS
    # brew install some_package
elif [ "$OS_TYPE" == "Linux" ]; then
    # Linux-specific commands
    echo "Running on Linux"
    /home/xinyu/application/qutebrowser/.venv/bin/python3 -m qutebrowser "$@"
    # Example command for Linux
    # sudo apt-get install some_package
else
    echo "Unsupported OS: $OS_TYPE"
fi
