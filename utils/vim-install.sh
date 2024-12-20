#!usr/env bash

read -p "Which type of installation do you prefer ?(1- source, 2- apt):" installation_type

if [ "$installation_type" == "1" ]; then
	echo "To develop.."
	exit 1
elif [ "$installation_type" == "2" ]; then
	# https://itsfoss.com/install-latest-vim-ubuntu/
    REPO_URL="ppa:jonathonf/vim"

    if ! grep -q "^deb.*$REPO_URL" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        sudo add-apt-repository ppa:jonathonf/vim
        sudo apt update
    fi
    sudo apt install vim
	echo "You have installed vim !"
	vim --version
else
	echo "Bad choice ! You should input 1 or 2."
	exit 0
fi

read -p "Do you want to install the configuration of me ?(y|[n]):" install_my_configuration

if [ "$install_my_configuration" == "y" ]; then
	git clone git@github.com:gongshangzheng/my_vim.git $HOME/.vim_runtime
	sh $HOME/.vim_runtime/install_awesome_vimrc.sh
    vim -c PlugInstall
    sudo apt install curl
    vim -c Codeium Auth
else
	echo "Tant pis:("
	exit 0
fi

read -p "Do you want to install gvim(y|[n]) ?" install_gvim

if [ "$install_gvim" == "y" ]; then
    sudo apt install gvim
else
    echo "Gvim is not installed."
fi
