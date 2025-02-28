#!/bin/bash

# Install latest neovim
guix install neovim

# Install python support
# echo "Installing python support..."
# guix install python3-neovim python3-pip
# cd ~/scripts/py_scripts
# uv pip install --user pynvim

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

