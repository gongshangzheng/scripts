#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：install-zsh.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 23:07
#   Description   ：
# ================================================================

sudo apt install zsh

git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
#cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# 安装zsh
parent_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
if [ -L "$HOME/.zshrc" ]; then
    read -p "Symlink .$HOME/.zshrc exists, do you want to replace it?(y|[n]):" replace
    if [ "$replace" == "y" ]; then
        rm $HOME/.zshrc
    fi
fi
ln -s $parent_dir/assets/.zshrc $HOME/.zshrc
sudo apt-get install zsh
# 终端输入命令，然后输入密码即可将zsh切换成默认shell
chsh -s /bin/zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo apt-get install fonts-powerline

# 安装oh-my-zsh插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
