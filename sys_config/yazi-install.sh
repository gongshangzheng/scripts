#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：yazi-install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-26 11:06
#   Description   ：
# ================================================================
sudo apt install make gcc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
cd $HOME/application
git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo build --release --locked
./target/release/yazi
