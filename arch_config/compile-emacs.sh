#!/bin/bash
#!/bin/bash

version="29.2"
build_dir="$HOME/applications/emacs_build"
source_file="emacs-$version.tar.gz"
sig_file="emacs-$version.tar.gz.sig"

# 检测是否为 Arch Linux
if grep -q "Arch Linux" /etc/os-release; then
    echo "检测到 Arch Linux，使用 pacman 安装依赖..."
    sudo pacman -S --needed base-devel git gnutls libx11 libxpm libjpeg-turbo libpng libgif libtiff
        gtk3 libxpm libgnutls libtree-sitter gcc-libs jansson mailutils sqlite3

    # 移除旧版 Emacs（如果存在）
    sudo pacman -Rns --noconfirm emacs emacs-common emacs-gtk emacs-lucid
else
    echo "非 Arch Linux，使用 apt 安装依赖..."
    sudo apt-get remove --purge emacs emacs-common emacs-gtk emacs-lucid
    sudo apt-get install -y build-essential libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev
        libgtk2.0-dev libncurses-dev libxpm-dev libgnutls28-dev libmagickwand-dev libtree-sitter-de
        libgccjit-12-dev libjansson-dev libmailutils-dev mailutils libsqlite3-dev
fi

# 创建构建目录
mkdir -p "$build_dir"
cd "$build_dir" || exit

# 下载源码和签名文件
if [ ! -f "$source_file" ]; then
    wget -c "https://ftpmirror.gnu.org/emacs/$source_file"
fi

if [ ! -f "$sig_file" ]; then
    wget -c "https://ftpmirror.gnu.org/emacs/$sig_file"
fi

# 验证签名
gpg --keyserver keyserver.ubuntu.com --recv-keys 17E90D521672C04631B1183EE78DAE0F3115E06B
gpg --verify "$sig_file"

# 解压源码
if [ ! -d "emacs-$version" ]; then
    tar xvfz "$source_file"
fi

cd "emacs-$version" || exit

# 配置编译选项
./configure --with-native-compilation=aot \
            --with-tree-sitter \
            --with-gif \
            --with-png \
            --with-jpeg \
            --with-rsvg \
            --with-tiff \
            --with-x-toolkit=gtk \
            --with-json \
            --with-mailutils \
            --with-sound=alsa

# 编译并安装
make clean
make -j$(nproc)
sudo make install

# 验证安装
emacs --version
