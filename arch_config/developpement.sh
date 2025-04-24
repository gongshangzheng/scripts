#!/bin/bash
# basic
sudo pacman -S --needed git base-devel cmake make
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo pacman -S qt5-base qt5-tools
# python
# sudo pacman -S uv
sudo pacman -S python-virtualenv
# sudo pacman -S pyenv
# Miniconda
yay -S miniconda3
sudo pacman -Syu gcc
