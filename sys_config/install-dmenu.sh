# 依赖于X11, 参考[[https://www.reddit.com/r/suckless/comments/nu8by3/dmenu_on_mac_os/?rdt=33527][dmenu on mac os : r/suckless]]进行安装

# 1. [[https://www.xquartz.org/][XQuartz]]安装XQartz,一个MacOS下的X11
# if it's in macos
if [[ "$(uname)" == "Darwin" ]]; then
    cd $APPLICATION_DIR
    git clone https://git.suckless.org/dmenu
    cd dmenu
    vim config.mk #修改必要的参数
    # END_COMMENT

    { echo "#TODO X11INC = /opt/X11/include"; echo "#TODO X11LIB = /opt/X11/lib"; echo "#TODO FREETYPEINC = /usr/local/include/freetype2"; } | cat - config.mk > temp && mv temp config.mk

    : << "END_COMMENT"
    Change X11INC = /usr/X11R6/include to X11INC = /opt/X11/include and X11LIB = /usr/X11R6/lib to X11LIB = /opt/X11/lib. I then had an issue where it couldn't find ft2build.h, so I also changed FREETYPEINC = /usr/include/freetype2 to FREETYPEINC = /usr/local/include/freetype2.
END_COMMENT

    make clean install
elif [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get install dmenu
fi
