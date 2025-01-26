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
cd ~/scripts/py_scripts
uv pip install --user pynvim

# Clone custom vim configuration
echo "Setting up custom vim configuration..."
if [ -d ~/.vim_runtime ]; then
    echo "~/.vim_runtime already exists, pulling latest changes..."
    cd ~/.vim_runtime
    git pull origin master
else
    git clone git@github.com:gongshangzheng/my_vim.git ~/.vim_runtime
fi

# Create init.vim
echo "Creating init.vim..."
mkdir -p ~/.config/nvim
cat > ~/.config/nvim/init.vim <<EOF
set runtimepath^=~/.vim_runtime

for f in split(glob('~/.vim_runtime/vimrcs/*.vim'), '\n')
    exe 'source' f
endfor
source ~/.vim_runtime/my_configs.vim
EOF

# install GUI - Neovide

sudo apt install -y curl \
    gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
    libxcursor-dev

curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh

cd ~/applications
git clone https://github.com/neovide/neovide
cd neovide
cargo install --path .

echo "Neovim installation and configuration complete!"
