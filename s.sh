#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：s.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-01 15:08
#   Description   ：
# ================================================================
#!/bin/bash

# 检查是否传递了参数
if [ -z "$1" ]; then
  echo "请提供一个参数，例如 'mem' 来查看按内存排序的进程。"
  return 0
fi

# 根据参数执行不同的命令
case "$1" in
  mem)
    echo "按内存使用率排序的进程："
    ps aux --sort=-%mem | head -n 10
    ;;
  cpu)
    echo "按CPU使用率排序的进程："
    ps aux --sort=-%cpu | head -n 10
    ;;
  *)
    echo "未知参数：$1"
    echo "可用参数：mem 或 cpu"
    ;;
esac

