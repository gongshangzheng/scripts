#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：yabi.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-26 11:27
#   Description   ：
# ================================================================
brew install koekeishiya/formulae/yabai --HEAD
codesign -fs 'yabai-cert' $(brew --prefix yabai)/bin/yabai
brew install koekeishiya/formulae/skhd
skhd --start-service
yabai --start-service
