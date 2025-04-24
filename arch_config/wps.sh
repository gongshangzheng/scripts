#!/bin/bash
# 安装依赖
sudo pacman -S base-devel git

# 克隆 AUR 仓库（选任一版本）
git clone https://aur.archlinux.org/wps-office.git       # 国际版
# git clone https://aur.archlinux.org/wps-office-cn.git    # 中文版

# 编译安装（进入对应目录）
cd wps-office* && makepkg -si
