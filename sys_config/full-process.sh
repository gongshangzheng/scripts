#!/bin/bash

# Initialize environment
init_environment() {
    parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
    cd "$parent_path"
    bash ./basic-environment.sh
    bash ./useful-tools.sh
}

# Install and configure Git
install_git() {
    read -p "Do you want to install git and get it configured? (y|[n]): " install_git
    if [ "$install_git" == "y" ]; then
        bash ./configure-git.sh
    fi
}

# Install terminal emulator
install_alacritty() {
    read -p "Do you want to install alacritty? (y|[n]): " install_alacritty
    if [ "$install_alacritty" == "y" ]; then
        bash ./alacritty-install.sh
    fi
}

# Install shell
install_zsh() {
    read -p "Do you want to install zsh? (y|[n]): " install_zsh
    if [ "$install_zsh" == "y" ]; then
        bash ./zsh-install.sh
    fi
}

# Install keyboard remapping
install_keyd() {
    read -p "Do you want to install keyd? (y|[n]): " install_keyd
    if [ "$install_keyd" == "y" ]; then
        bash ./keyd-install.sh
    fi
}

# Install browser
install_qutebrowser() {
    read -p "Do you want to install qutebrowser? (y|[n]): " install_qutebrowser
    if [ "$install_qutebrowser" == "y" ]; then
        bash ./qutebrowser-install.sh
    fi
}

# Install editor
install_doom_emacs() {
    read -p "Do you want to install doom emacs? (y|[n]): " install_doom_emacs
    if [ "$install_doom_emacs" == "y" ]; then
        bash ./doom-emacs-install.sh
    fi
}

# Install input method
install_rime() {
    read -p "Do you want to install rime? (y|[n]): " install_rime
    if [ "$install_rime" == "y" ]; then
        bash ./rime-install.sh
    fi
}

# Configure Git repositories
configure_git_repos() {
    read -p "Have you already put the ssh key on git? (y|[n]): " put_ssh_key
    if [ "$put_ssh_key" == "y" ]; then
        bash ./git-repositories.sh
    fi
}

# Final configuration
final_config() {
    cd $HOME/MyConf
    bash $HOME/MyConf/config-env.sh all
    sudo apt install -y libev-dev
}

# Main function
main() {
    init_environment

    install_git
    install_alacritty
    install_zsh
    install_keyd
    install_qutebrowser
    install_doom_emacs
    install_rime

    configure_git_repos
    final_config
}

# Execute main function
main
