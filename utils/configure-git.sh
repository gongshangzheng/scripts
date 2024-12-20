#!bin/bash

if ! command -v git &> /dev/null
then
    echo "git is not installed. Installing..."
    # 判断系统
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
#        sudo add-apt-repository ppa:aslatter/ppa
        sudo apt update
        sudo apt-get install git
    fi
fi


read -p "Your Name pls:" git_username
git config --global user.name "$git_username"

read -p "Your Mail pls:" git_email

git config --global user.email "$git_email"

# git tool

git config --global merge.tool vimdiff
git config --global core.editor "vim"

echo "ssh-key configuration..."

ssh-keygen -t rsa -b 4096 -C "$git_email"

echo "Finished!"

