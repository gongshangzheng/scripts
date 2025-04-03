#!/bin/bash
# 安装终端工具和窗口管理工具
sudo pacman -S zellij fzf zoxide eza waybar jq brightnessctl unrar unzip xdg-desktop-portal-wlr

# 安装自动化工具和开发工具
sudo pacman -S xdotool

# 安装Kitty终端shell集成
# curl -L https://sw.kovidgoyal.net/kitty/shell-integration/zsh | zsh
sudo pacman -S wmctrl
