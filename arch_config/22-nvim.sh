#!/bin/bash

# Detect distribution
if [ -f /etc/arch-release ]; then
    DISTRO="arch"
elif [ -f /etc/debian_version ]; then
    DISTRO="debian"
else
    echo "Unsupported distribution!"
    exit 1
fi

# Install Neovim
echo "Installing neovim..."
case $DISTRO in
    arch)
        sudo pacman -S --needed --noconfirm neovim
        ;;
    debian)
        sudo apt-get update
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt-get update
        sudo apt-get install -y neovim
        ;;
esac

# Install Python support
echo "Installing python support..."
case $DISTRO in
    arch)
        sudo pacman -S --needed --noconfirm python-pynvim python-pip
        ;;
    debian)
        sudo apt-get install -y python3-neovim python3-pip
        ;;
esac

# Additional Python packages
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

# Install Neovide GUI
echo "Installing Neovide..."
case $DISTRO in
    arch)
        sudo pacman -S --needed --noconfirm \
            curl git cmake openssl pkg-config \
            freetype2 alsa-lib expat libxcb bzip2 \
            libxcursor fontconfig sndio
        ;;
    debian)
        sudo apt install -y \
            curl git cmake libssl-dev pkg-config \
            libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
            libbz2-dev libsndio-dev libxcursor-dev libfontconfig1-dev
        ;;
esac

# Install Rust and Neovide
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
source "$HOME/.cargo/env"

cd ~/applications
git clone https://github.com/neovide/neovide
cd neovide
cargo install --path .

echo "Neovim installation and configuration complete!"
