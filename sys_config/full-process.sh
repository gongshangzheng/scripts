#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
bash ./basic-environment.sh
bash ./useful-tools.sh

read -p "Do you want to install vim ?(y|[n]):" install_vim

if [ "$install_vim" == "y" ]; then
    bash ./vim-install.sh
fi

read -p "Do you want to install git and get it configured ?(y|[n]):" install_git

if [ "$install_git" == "y" ]; then
    bash ./configure-git.sh
fi

read -p "Dow you want to install alacritty ?(y|[n]):" install_alacritty

if [ "$install_alacritty" == "y" ]; then
    bash ./alacritty-install.sh
fi

read -p "Do you want to install zsh ?(y|[n]):" install_zsh

if [ "$install_zsh" == "y" ]; then
    bash ./zsh-install.sh
fi

read -p "Do you want to install keyd ?(y|[n]):" install_keyd

if [ "$install_keyd" == "y" ]; then
bash ./keyd-install.sh
fi

read -p "Do you want to install qutebrowser ?(y|[n]):" install_qutebrowser

if [ "$install_qutebrowser" == "y" ]; then
bash ./qutebrowser-install.sh
fi

read -p "Do you want to install doom emacs ?(y|[n]):" install_doom_emacs

if [ "$install_doom_emacs" == "y" ]; then
bash ./doom-emacs-install.sh
fi

read -p "Do you want to install rime ?(y|[n]):" install_rime

if [ "$install_rime" == "y" ]; then
    bash ./rime-install.sh
fi

read -p "Have You already put the ssh key on git ?(y|[n]):" put_ssh_key

if [ "$put_ssh_key" == "y" ]; then
    bash  ./git-repositories.sh
fi


cd $HOME/MyConf

bash $HOME/MyConf/config-env.sh all
sudo apt install libev-dev
