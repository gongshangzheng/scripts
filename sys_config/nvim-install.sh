#!/bin/bash

# Install latest neovim
echo "Installing neovim..."
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install -y neovim

# Install python support
echo "Installing python support..."
sudo apt-get install -y python3-neovim python3-pip
pip3 install --user pynvim

# Clone custom vim configuration
echo "Setting up custom vim configuration..."
if [ -d ~/.vim_runtime ]; then
    echo "~/.vim_runtime already exists, pulling latest changes..."
    cd ~/.vim_runtime
    git pull origin main
else
    git clone git@github.com:gongshangzheng/my_vim.git ~/.vim_runtime
fi

# Create init.vim
echo "Creating init.vim..."
mkdir -p ~/.config/nvim
cat > ~/.config/nvim/init.vim <<EOF
set runtimepath^=~/.vim_runtime
source ~/.vim_runtime/my_configs.vim

for f in split(glob('~/.vim_runtime/vimrcs/*.vim'), '\n')
    exe 'source' f
endfor
EOF

echo "Neovim installation and configuration complete!"
