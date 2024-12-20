#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：install-zsh.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 23:07
#   Description   ：
# ================================================================
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# 安装zsh
sudo apt-get install zsh
# 终端输入命令，然后输入密码即可将zsh切换成默认shell
chsh -s /bin/zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

