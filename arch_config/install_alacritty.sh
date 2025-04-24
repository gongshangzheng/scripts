#!/bin/bash
#!/bin/bash

# Alacritty 编译安装脚本 for Arch Linux

set -e  # 出错时退出脚本

# 安装编译依赖
sudo pacman -S --needed --noconfirm \
    git \
    cmake \
    freetype2 \
    fontconfig \
    pkg-config \
    make \
    libxcb \
    libxkbcommon \
    python3

# 安装 Rust 工具链（如果尚未安装）
if ! command -v rustc &> /dev/null; then
    echo "安装 Rust 工具链..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

mkdir -p ~/applications
# 克隆 Alacritty 源码
if [ ! -d "alacritty" ]; then
    git clone https://github.com/alacritty/alacritty.git ~/applications/alacritty
fi
cd ~/applications/alacritty

# 编译
echo "开始编译 Alacritty..."
cargo build --release

# 安装到系统
echo "安装到 /usr/local/bin/"
sudo cp target/release/alacritty /usr/local/bin/

# 可选：安装桌面文件
echo "安装桌面文件和图标..."
sudo cp extra/linux/Alacritty.desktop /usr/share/applications/
sudo mkdir -p /usr/share/pixmaps/
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg

# 可选：安装 terminfo
echo "安装 terminfo..."
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# 可选：添加 shell 补全
echo "安装 shell 补全文件..."
mkdir -p "${HOME}/.bash_completion"
cp extra/completions/alacritty.bash "${HOME}/.bash_completion/"

echo "Alacritty 安装完成！"
echo "可以运行 'alacritty' 启动终端"
