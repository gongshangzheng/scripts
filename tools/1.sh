#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：1.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-11-18 23:34
#   Description   ：
# ================================================================
#
# this script is dedicated to restore some common commands, I can calling them by running this script. for example, I can run this script and give it a parameter --help to see the help of this script.
#
# =========================================================

#!/bin/bash

# Function to display the help message
show_help() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  ====================================================="
    echo "  begin                  Begin the system."
    echo "  halt                   Halt the system."
    echo "  reboot                 Reboot the system."
    echo "  ====================================================="
    echo "  -h, help               Show this help message."
    echo "  -s, modify-script      Modify the script (opens vim for editing)."
    echo "  -n, novel              Update the novel directory from git."
    echo "  conf                   Update the conf directory from git."
    echo "  -b, blog               Update the blog directory from git."
    echo "  -c, code               Update the code directory from git."
    echo "  -r, rime                   Update the rime directory from git."
    echo "  -v, vim                Update vim configuration from git."
    echo "  -p, post               Update the post directory from git."
    echo "  note                   Update the note directory from git."
    echo "  -d, doom                   Update doom emacs configuration."
    echo "  sc, scripts                   Update scripts."
    echo "  ====================================================="
    echo "  hugo                   Run hugo server for the blog."
    echo "  markdown-org           convert markdown to org."
    echo "  hn, hugo-new               Create a new hugo post."
    echo "  ss, show-size               Show the size of all files in the current directory."
    echo "  sd, show-dpkg               Show the size of all dpkg packages."
    echo "  sk, sk-conf                change surfingkeys configuration."
    echo "  grep                   grep phrase."
    echo "  ====================================================="
    echo "  pla, pull-all               Pull all content from git."
    echo "  ====================================================="
    echo "  pr, push-rime              Push rime configuration to git."
    echo "  pvc, push-vim-config          Push vim configuration to git."
    echo "  pb, push-blog              Push blog content to git."
    echo "  pn, push-note             Push note content to git."
    echo "  pc, push-code             Push code content to git."
    echo "  pp, push-post              Push post content to git."
    echo "  pa, push-all               Push all content to git."
    echo "  pd, push-doom              Push doom configuration to git."
    echo "  psc, push-scripts          Push scripts to git."
    echo "  ====================================================="
    echo ""
    echo "Example: $0 novel"
    echo "PS: if you want to use -n, -b, -c, or note, you need to add . before the command."
}

surfingkeyChangeConfiguration(){
    cd ~/application/surfingkeys-conf/
    npm use 22.11.0
    npm run gulp install
    cp ~/.config/surfingkeys.js ~/scripts/
    #append surfingkeys_custom.js to the end of surfingkeys.js
    #cat ~/scripts/surfingkeys_custom.js >> ~/scripts/surfingkeys.js
    cd ~/scripts/
    git add surfingkeys.js
    # get a new parameter as the commit message
    read -p "Enter the commit message: " commit_message
    git commit -m "$commit_message"
    git push
    cd ~/application/surfingkeys-conf
    git add src
    git commit -m "$commit_message"
}

grep_phrase(){
    phrase="$1"
    echo "========================================================"
    echo "Grep phrase: $phrase"
    echo "========================================================"
    grep -rn --exclude-dir={".git","node_modules","build","assets"} "$phrase" .
}

push_git_directory(){
    dirname="$1"
    echo "========================================================"
    echo "Pushing $dirname..."
    echo "========================================================"
    if [ ! -d "$dirname" ]; then
        echo "Directory $dirname not found. Please clone the repository first."
        return 1
    fi
    cd "$dirname" || return 1
    git checkout master || return 1
    git pull origin master || return 1
    git add . || return 1
    git commit
    git push origin master || return 1
}

pull_git_directory(){
    dirname="$1"
    echo "========================================================"
    echo "Pulling $dirname..."
    echo "========================================================"
    if [ ! -d "$dirname" ]; then
        echo "Directory $dirname not found. Please clone the repository first."
        return 1
    fi
    cd "$dirname" || return 1
    git checkout master || return 1
    git add . || return 1
    git commit
    git pull origin master || return 1
}

markdown_org(){
    # 定义路径
    ORG_DIR="$HOME/.doom.d/org/novel"
    MD_DIR="$(pwd)"

    # 使用 zsh 和 bash 兼容的方式读取用户输入
    echo -n "是否递归处理子目录？(y/n): "
    read recursive
    echo -n "确认开始转换吗？(y/n): "
    read confirm

    if [[ "$confirm" != "y" ]]; then
        echo "操作已取消。"
        return 0
    fi

    # 创建 Org 保存目录
    mkdir -p "$ORG_DIR"

    # 定义查找方式（递归或非递归）
    if [[ "$recursive" == "y" ]]; then
        find_command="find $MD_DIR -type f -name '*.md'"
    else
        find_command="find $MD_DIR -maxdepth 1 -type f -name '*.md'"
    fi

    # 转换 .md 文件为 .org 文件
    eval "$find_command" | while read -r f; do
    # 获取相对路径
    relative_path=$(realpath --relative-to="$MD_DIR" "$f")
    # 构造输出目录
    output_dir="$ORG_DIR/$(dirname "$relative_path")"
    mkdir -p "$output_dir"
    # 构造输出文件路径
    output_file="$output_dir/$(basename "${f%.md}.org")"
    # 转换文件
    pandoc -f markdown -t org -o "$output_file" "$f"
    echo "已转换: $f -> $output_file"
done

echo "所有转换已完成。"
}
# If no argument is provided, show help

if [ -z "$1" ]; then
    show_help
    return 1
fi

# Use a case statement for cleaner handling of commands
case "$1" in
    -h|help)
        show_help
        ;;
    markdown-org)
        markdown_org
        ;;
    halt)
        . 1 pa || return 1
        sudo shutdown -h now || return 1
        ;;
    reboot)
        sudo reboot -h now || return 1
        ;;

    begin)
        . 1 pla || return 1
        ;;
     -s|modify-script)
        echo "Modifying script..."
        vim $HOME/scripts/tools/1.sh
        ;;
    -c|code)
        echo "This is your git file"
        ;;
    -n|novel)
        pull_git_directory ~/blogs/content/zh/novel
        ;;
    -p|post)
        pull_git_directory ~/blogs/content/zh/posts
        ;;
    -b|blog)
        pull_git_directory ~/blogs
        ;;
    conf)
        pull_git_directory ~/MyConf
        ;;
    note)
        pull_git_directory ~/note
        ;;
    hugo)
        echo "Starting Hugo server..."
        if [ ! -d ~/blogs ]; then
            echo "Blog directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs || return 1
        git checkout master || return 1
        git pull origin master || return 1
        hugo server
        ;;
    hn|hugo-new)
        echo "Creating a new hugo post..."
        if [ ! -d ~/blogs ]; then
            echo "Blog directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs || return 1
        git checkout master || return 1
        #git pull origin master || return 1
        python create_file.py
        ;;
    -v|vim)
        pull_git_directory ~/.vim_runtime
        ;;
    ss|show-size)
        du -sh .[!.]* * | sort -h
        ;;
    sd|show-dpkg)
	dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 20
	;;
    conf)
        push_git_directory ~/MyConf
        ;;
    push-vim-config|pvc)
        push_git_directory ~/.vim_runtime
        ;;
    push-blog|pb)
        push_git_directory ~/blogs
        ;;
    push-note|pn)
        push_git_directory ~/note
        ;;
    push-code|pc)
        echo "This is your code file"
        ;;
    push-post|pp)
        push_git_directory ~/blogs/content/zh/posts
        ;;
    push-all|pa)
        bash $HOME/scripts/tools/1.sh push-vim-config || return 1
        bash $HOME/scripts/tools/1.sh  push-blog || return 1
        bash $HOME/scripts/tools/1.sh  push-rime || return 1
        bash $HOME/scripts/tools/1.sh  push-doom || return 1
        bash $HOME/scripts/tools/1.sh  push-scripts || return 1
        #bash $HOME/scripts/tools/1.sh  push-note || return 1
        bash $HOME/scripts/tools/1.sh  push-conf || return 1
        bash $HOME/scripts/tools/1.sh push-post || return 1
        ;;
    pull-all|pla)
        bash $HOME/scripts/tools/1.sh novel || return 1
        bash $HOME/scripts/tools/1.sh doom || return 1
        bash $HOME/scripts/tools/1.sh rime || return 1
        bash $HOME/scripts/tools/1.sh scripts || return 1
        bash $HOME/scripts/tools/1.sh vim || return 1
        bash $HOME/scripts/tools/1.sh blog || return 1
        bash $HOME/scripts/tools/1.sh conf || return 1
        #bash $HOME/scripts/tools/1.sh note || return 1
        ;;
    rime|-r)
        # Detect the Rime directory based on OS
        if [[ "$(uname)" == "Darwin" ]]; then
            # macOS
            RIME_DIR=~/Library/Rime
        elif [[ "$(uname)" == "Linux" ]]; then
            # Linux
            RIME_DIR=~/.config/ibus/rime
        else
            echo "Unsupported operating system."
            return 1
        fi

        # Check if the Rime directory exists
        if [ ! -d "$RIME_DIR" ]; then
            echo "Rime directory not found. Please clone the repository first."
            return 1
        fi

        # Navigate to the Rime directory and update the repository
        cd "$RIME_DIR" || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    push-rime|pr)
        # Detect the Rime directory based on OS
        if [[ "$(uname)" == "Darwin" ]]; then
            # macOS
            RIME_DIR=~/Library/Rime
        elif [[ "$(uname)" == "Linux" ]]; then
            # Linux
            RIME_DIR=~/.config/ibus/rime
        else
            echo "Unsupported operating system."
            return 1
        fi
        push_git_directory "$RIME_DIR"
        ;;
    init-system|is)
        # Detect the operating system
        init_system
        ;;
    push-doom|pd)
        push_git_directory ~/.doom.d
        ;;
    doom)
        pull_git_directory ~/.doom.d
        ;;
    scripts|sc)
        pull_git_directory ~/scripts
        ;;
    sk|sk-conf)
        surfingkeyChangeConfiguration
        ;;
    push-scripts|psc)
        push_git_directory ~/scripts
        ;;
    grep)
        grep_phrase "$2"
        ;;
    *)
        echo "Error: Invalid option '$1'"
        show_help
esac
