#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：ml.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-20 22:24
#   Description   ：
# ================================================================

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_file> <target_file>"
    exit 1
fi

# get the absolute path of the source file and the target file

src=$(readlink -f "$1")
tgt=$(readlink -m "$2")

base=$(basename "$src")

if [ -e "$tgt" ] && [ ! -d "$tgt" ]; then
    echo "Error: $tgt already exists, exit."
    exit 1
fi

if [ -d "$tgt" ]; then
    mv $src "$tgt/$base"
    ln -s "$tgt/$base" "$(dirname "$src")/$base"
else
    mv $src "$tgt"
    ln -s "$tgt" "$(dirname "$src")/$base"
fi

