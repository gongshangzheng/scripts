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
  echo "Usage: my_git.sh [command]"
  echo ""
  echo "Commands:"
  echo "  help, -h         Show this help message"
  echo "  rcache, rc       remove cache"
  echo "  init             Create a symbolic link in /usr/local/bin pointing to this script"
  echo "  clean            Run 'git gc --prune=now --aggressive' to clean the repository"
  echo "  -s               modify the script"
}

# 定义 init 函数
init() {
  if [ -e /usr/local/bin/my_git ]; then
    echo "my_git is already installed."
  else
    sudo ln -s "$SCRIPT_PATH" /usr/local/bin/mgit
    sudo chmod +x /usr/local/bin/mgit
    echo "mgit has been successfully installed."
  fi
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

