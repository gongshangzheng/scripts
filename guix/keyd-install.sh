#!/usr/bin/env sh
#
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
# rm $HOME/.Xmodmap
#ln $parent_path/assets/.Xmodmap $HOME/.Xmodmap
#xmodmap $HOME/.Xmodmap

######### keyd

REPO_URL="https://github.com/rvaiya/keyd.git"
TARGET_DIRECTORY="$APPLICATION_DIR/keyd/"
if [ -d "$TARGET_DIRECTORY" ]; then
    echo "目标目录 '$TARGET_DIRECTORY' 已存在，跳过克隆。"
else
    git clone "$REPO_URL" "$TARGET_DIRECTORY"
    cd $TARGET_DIRECTORY
    # sudo systemctl enable keyd && sudo systemctl start keyd
    if [ ! -e "$HOME/.XCompose" ]; then
	ln /usr/local/share/keyd/keyd.compose $HOME/.XCompose
    fi
    sudo usermod -aG keyd $USER
fi

cd $TARGET_DIRECTORY
echo "Begining make ..."
make && sudo make install || exit 0
# sudo systemctl enable --now keyd

sudo rm /etc/keyd/default.conf


sudo ln -s ~/MyConf/keyd-default.conf /etc/keyd/default.conf
sudo keyd reload


# to specialzed

# 检查是否传入参数
# read -p "Do you want to download the keyd extension ? (y/n): " answer
# answer="n"
#
# if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
#     # 删除旧的扩展
#     rm -r $HOME/.local/share/gnome-shell/extensions/keyd
#     # 创建目录
#     mkdir -p $HOME/.local/share/gnome-shell/extensions
#     # 创建符号链接
#     sudo ln /usr/local/share/keyd/gnome-extension-45 $HOME/.local/share/gnome-shell/extensions/keyd
#     # 启用扩展
#
#     echo "Keyd extension installed and enabled."
# else
#     echo "No action taken. Use 'y' as an argument to install the keyd extension."
# fi
# gnome-extensions enable keyd
# sudo bash -c 'cat << EOF | tee /home/xinyu/.config/keyd/app.conf > /dev/null
# [chromium]
#
# alt.[ = C-S-tab
# alt.] = macro(C-tab)
#
# EOF'
# keyd-application-mapper

sudo chmod a+w /var/run/keyd.socket
sudo chmod a+r /var/run/keyd.socket

: <<'END_COMMENT'

Other Useful functions:
macro:
           •   macro(C-a)
           •   macro(leftcontrol+leftmeta) # simultaneously taps the left meta and left control keys
           •   A-M-x
           •   macro(Hello space World)
           •   macro(h e l l o space w o r ld) (identical to the above)
           •   macro(C-t 100ms google.com enter)

       macro2(<timeout>, <repeat timeout>, <macro>)
           Creates a macro with the given timeout and repeat timeout. If a timeout value of 0 is used, macro repeat is disabled.

           Note that <macro> must be a valid macro expression.

           E.g.
                macro2(400, 50, macro(Hello space World))
                macro2(120, 80, left)
       command(<shell command>)
           Execute the given shell command.

           E.g.

           command(brightness down)

       NOTE: Commands are executed by the user running the keyd process (probably root), use this feature judiciously.

# how get key xev ?
# application
END_COMMENT
