
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
bash ./basic-environment.sh

read -p "Do you want to install vim ?(y|[n]):" install_vim

if [ "$install_vim" == "y" ]; then
    bash ./vim-install.sh
fi

read -p "Do you want to install git and get it configured ?(y|[n]):" install_git

if [ "$install_git" == "y" ]; then
    bash ./configure-git.sh
fi

read -p "Do you want to install zsh ?(y|[n]):" install_zsh

if [ "$install_zsh" == "y" ]; then
    bash ./install-zsh.sh
fi

read -p "Do you want to install keyd ?(y|[n]):" install_keyd

if [ "$install_keyd" == "y" ]; then
bash ./keyd-install.sh
fi

read -p "Do you want to install qutebrowser ?(y|[n]):" install_qutebrowser

if [ "$install_qutebrowser" == "y" ]; then
bash ./qutebrowser-install.sh
fi
