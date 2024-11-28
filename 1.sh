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
    echo "  ss, show-size               Show the size of all files in the current directory."
    echo "  hn, hugo-new               Create a new hugo post."
    echo ""
    echo "Example: $0 novel"
    echo "PS: if you want to use -n, -b, -c, or note, you need to add . before the command."
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
        echo "The script has been initialized."
        ;;
    halt)
        . 1 pa || return 1
        . 1 pla || return 1
        sudo shutdown -h now || return 1
        ;;
    begin)
        1 pla || return 1
        ;;
    -s|modify-script)
        echo "Modifying script..."
        vim /usr/local/bin/1
        ;;
    -c|code)
        echo "Updating code directory..."
        if [ ! -d ~/Code ]; then
            echo "Code directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/Code || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    -n|novel)
        echo "Updating novel directory..."
        if [ ! -d ~/blogs/content/zh/novel ]; then
            echo "Novel directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs/content/zh/novel || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    -p|post)
        echo "Updating post directory..."
        if [ ! -d ~/blogs/content/zh/posts ]; then
            echo "Post directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs/content/zh/posts || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    -b|blog)
        echo "Updating blog directory..."
        if [ ! -d ~/blogs ]; then
            echo "Blog directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    note)
        echo "Updating note directory..."
        if [ ! -d ~/note ]; then
            echo "Note directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/note || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
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
        echo "Opening Vim configuration..."
        if [ ! -d ~/.vim_runtime ]; then
            echo "Vim directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/.vim_runtime || return 1
        git checkout master || return 1
        git pull origin master || return 1
        #vim my_configs.vim
        ;;
    ss|show-size)
        du -sh .[!.]* * | sort -h
        ;;

    push-vim-config|pvc)
        echo "Pushing Vim config..."
        if [ ! -d ~/.vim_runtime ]; then
            echo "Vim directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/.vim_runtime || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add my_configs.vim || return 1
        git add vimrcs || return 1
        git add UltiSnips || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    push-blog|pb)
        if [ ! -d ~/blogs ]; then
            echo "Blog directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    push-note|pn)
        echo "Pushing note..."
        if [ ! -d ~/note ]; then
            echo "Note directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/note || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    push-code|pc)
        if [ ! -d ~/Code ]; then
            echo "Code directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/Code || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    push-post|pp)
        echo "Pushing post..."
        if [ ! -d ~/blogs/content/zh/posts ]; then
            echo "Post directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/blogs/content/zh/posts || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    push-scripts|ps)
        echo "Pushing scripts..."
        if [ ! -d ~/scripts ]; then
            echo "Scripts directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/scripts || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
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

        echo "Pushing Rime configuration..."
        # Check if the Rime directory exists
        if [ ! -d "$RIME_DIR" ]; then
            echo "Rime directory not found. Please clone the repository first."
            return 1
        fi

        # Navigate to the Rime directory and update the repository
        cd "$RIME_DIR" || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        pwd
        ;;
    init-system|is)
        # Detect the operating system
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
        ;;
    push-doom|pd)
        echo "Pushing doom configuration..."
        if [ ! -d ~/.doom.d ]; then
            echo "Doom directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/.doom.d || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    doom)
        echo "Updating doom configuration..."
        if [ ! -d ~/.doom.d ]; then
            echo "Doom directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/.doom.d || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    scripts|sc)
        echo "Updating scripts..."
        if [ ! -d ~/scripts ]; then
            echo "Scripts directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/scripts || return 1
        git checkout master || return 1
        git pull origin master || return 1
        pwd
        ;;
    push-scrpits|psc)
        echo "Pushing scripts..."
        if [ ! -d ~/scripts ]; then
            echo "Scripts directory not found. Please clone the repository first."
            return 1
        fi
        cd ~/scripts || return 1
        git checkout master || return 1
        git pull origin master || return 1
        git add . || return 1
        git commit || return 1
        git push origin master || return 1
        ;;
    *)
        echo "Error: Invalid option '$1'"
        show_help
esac
