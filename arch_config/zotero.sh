#!/bin/bash
#!/bin/bash
cd ~/Downloads
sudo pacman -Syu dbus-glib gtk3 gconf

# 下载 Zotero
wget -O zotero.tar.bz2 "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=7.0.15"

# 解压下载的文件
tar -xjf zotero.tar.bz2

# 进入解压后的目录
cd Zotero_linux-x86_64

# 安装 Zotero
sudo mkdir /opt/zotero
sudo cp -r * /opt/zotero

# 创建符号链接到 /usr/local/bin
sudo ln -s /opt/zotero/zotero /usr/local/bin/zotero

# 清理下载的文件
cd ..
rm -rf zotero.tar.bz2 Zotero_linux-x86_64

echo "Zotero 安装完成！"
