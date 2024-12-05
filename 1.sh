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
    echo "  init                   Initialize the script by creating a symbolic link in /usr/local/bin/1."
    echo "  ====================================================="
    echo "  begin                  Begin the system."
    echo "  halt                   Halt the system."
    echo "  reboot                 Reboot the system."
    echo "  ====================================================="
    echo "  -h, help               Show this help message."
    echo "  -s, modify-script      Modify the script (opens vim for editing)."
    echo "  -n, novel              Update the novel directory from git."
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
    echo "  server                  Connect to the server."
    echo "  server2                Connect to the server2."
    echo "  server-aws             Connect to the server-aws."
    echo "  dict                   Add words to the dictionary."
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

connect_to_server(){
    #ssh -i ~/.ssh/id_rsa gongshang@47.93.37.219
    ssh -i ~/.ssh/id_rsa xinyu@47.93.27.152
}

connect_to_server2(){
    #ssh -i ~/.ssh/id_rsa gongshang@47.93.37.219
    # ssh-copy-id xinyu@87.106.191.101
    ssh -i ~/.ssh/id_rsa xinyu@87.106.191.101
}

connect_to_server_aws(){
    sudo ssh -i ~/Documents/configs/servers/AWS-EC2-key.pem ubuntu@16.170.255.25
}

dict(){
    echo "========================================================"
    echo "Adding words to the dictionary..."
    echo "========================================================"
    # judge the operating system
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        vim "$HOME/Library/Rime/wubi86_jidian.user.yaml"
    elif [[ "$(uname)" == "Linux" ]]; then
        # Linux
        vim "$HOME/.config/ibus/rime/wubi86_jidian_user.dict.yaml"
    else
        echo "Unsupported operating system."
        return 1
    fi
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

init_system(){

    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        sudo softwareupdate -i -a || return 1
        # homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"|| return 1
        # git
        brew install git || return 1
        # vim
        brew install vim || return 1
        # required dependencies
        brew install git ripgrep || return 1
        # optional dependencies
        brew install coreutils fd || return 1
        # Installs clang
        xcode-select --install || return 1
        # emacs
        brew --cask install emacs || return 1
        # alfred
        brew install --cask alfred || return 1
    elif [[ "$(uname)" == "Linux" ]]; then
        # Linux
        sudo apt update || return 1
        sudo apt upgrade || return 1
        sudo apt install -y git || return 1
        sudo apt install -y vim || return 1
        sudo apt install -y fish || return 1
        sudo apt install -y python3 || return 1
        sudo apt install -y python3-pip || return 1
        sudo apt install -y python3-venv || return 1
        #sudo apt install -y nodejs || return 1
        #sudo apt install -y npm || return 1
        #sudo apt install -y hugo || return 1
        #sudo apt install -y cmake || return 1
        #emacs
        snap install emacs --classic || return 1
        sudo apt-get install ripgrep fd-find || return 1
    fi
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d || return 1
    ~/.emacs.d/bin/doom install || return 1
    git config --global core.quotepath false || return 1
    git config merge.tool vimdiff || return 1
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
    init)
        script_path=$(realpath "$0") || return 1
        #if [ -L "/usr/local/bin/1" ]; then
        #echo "The script is already initialized."
        #exit 0
        #fi
        if [ -f "/usr/local/bin/1" ]; then
            # delete it
            printf "%s" "Do you want to delete it? (y/n)"
            read -r response
            if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
                sudo rm /usr/local/bin/1
            else
                echo "The script is not initialized."
                exit 0
            fi
        fi
        sudo ln -s "$script_path" /usr/local/bin/1
        echo "The script has been initialized."
        ;;
    server-aws)
        connect_to_server_aws
        ;;
    markdown-org)
        markdown_org
        ;;
    halt)
        . 1 pla || return 1
        . 1 pa || return 1
        sudo shutdown -h now || return 1
        ;;
    reboot)
        . 1 pla || return 1
        . 1 pa || return 1
        sudo reboot -h now || return 1
        ;;

    begin)
        . 1 pla || return 1
        . 1 pa || return 1
        ;;
    server)
        connect_to_server
        ;;
    server2)
        connect_to_server2
        ;;
    dict)
        dict
        ;;
    -s|modify-script)
        echo "Modifying script..."
        vim /usr/local/bin/1
        ;;
    -c|code)
        pull_git_directory ~/Code
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
        push_git_directory ~/Code
        ;;
    push-post|pp)
        push_git_directory ~/blogs/content/zh/posts
        ;;
    push-all|pa)
        bash 1 push-vim-config || return 1
        bash 1 push-blog || return 1
        bash 1 push-rime || return 1
        bash 1 push-doom || return 1
        bash 1 push-scripts || return 1
        bash 1 push-note || return 1
        #bash 1 push-code || return 1
        bash 1 push-post || return 1
        ;;
    pull-all|pla)
        bash 1 novel || return 1
        bash 1 doom || return 1
        bash 1 rime || return 1
        bash 1 scripts || return 1
        bash 1 vim || return 1
        bash 1 blog || return 1
        #bash 1 code || return 1
        bash 1 note || return 1
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
    push-scripts|psc)
        push_git_directory ~/scripts
        ;;
    *)
        echo "Error: Invalid option '$1'"
        show_help
esac
