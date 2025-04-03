#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：node-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-20 17:57
#   Description   ：
# ================================================================
if [ -e "$HOME/.nvm/nvm.sh" ]; then
    echo "~/.nvm/nvm.sh detected. Loading..."
    source $HOME/.nvm/nvm.sh
fi
if ! command -v nvm &> /dev/null
then
    echo "nvm is not installed. Installing..."
    COMMAND_NAME=curl
    if ! command -v $COMMAND_NAME &> /dev/null
    then
        echo "$COMMAND_NAME is not installed. Installing..."
        # 判断系统
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    #        sudo add-apt-repository ppa:aslatter/ppa
            sudo apt update
            sudo apt-get install $COMMAND_NAME
        fi
    fi

    # installs nvm (Node Version Manager)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    source $HOME/.nvm/nvm.sh
fi
# download and install Node.js (you may need to restart the terminal)
nvm install 22.11

# verifies the right Node.js version is in the environment
node -v # should print `v22.12.0`
nvm current

# verifies the right npm version is in the environment
npm -v # should print `10.9.0`

npm install -g yarn
