#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：my_git.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-13 01:26
#   Description   ：
# ================================================================

# clean: git gc --prune=now --aggressive

#!/bin/bash

# 获取当前脚本的路径
SCRIPT_PATH=$(realpath "$0")

# 定义 help 函数
help() {
  echo "Usage: mgit.sh [command]"
  echo ""
  echo "Commands:"
  echo "  help, -h         Show this help message"
  echo "  rcache, rc       remove cache"
  echo "  init             Create a symbolic link in /usr/local/bin pointing to this script"
  echo "  rm           	   Remove a file from Git tracking"
  echo "  clean            Run 'git gc --prune=now --aggressive' to clean the repository"
  echo "  -s               modify the script"
  echo "  filter	   remove a directory from the history"	
}

rm() {
    git filter-branch --tree-filter 'rm -rf $2' HEAD
}
# 定义 init 函数
init() {
  if [ -f /usr/local/bin/mgit ]; then
    echo "mgit is already installed."
    printf "%s" "Do you want to delete it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo rm /usr/local/bin/mgit
    else
        echo "The script is not initialized."
        exit 0
    fi
  fi
  sudo ln -s "$SCRIPT_PATH" /usr/local/bin/mgit
  echo "mgit has been successfully installed."
}

# 定义 clean 函数
clean() {
  git gc --prune=now --aggressive
  echo "Git garbage collection complete."
}

# 定义 git rm 函数
git_rm() {
  if [ -z "$2" ]; then
    echo "Error: Missing path for 'git rm' command."
    help
    exit 1
  fi
  git rm -r --cached "$2"
  echo "Removed $2 from Git tracking."
}

filter() {
	if [ -f "$2" ]; then
		git filter-repo --path $2 --invert-paths
	fi
}

# 根据输入的参数执行相应的功能
if [ $# -eq 0 ]; then
  echo "No command provided. Use 'help' or '-h' to see available commands."
  help
  exit 1
fi

case "$1" in
  help | -h)
    help
    ;;
  init)
    init
    ;;
  clean)
    clean
    ;;
  rm)
    rm "$@"
    ;;
  -s)
    vim "$SCRIPT_PATH"
    ;;
  rcache|rc)
    git_rm "$@"
    ;;
  *)
    echo "Unknown command: $1"
    help
    ;;
esac

