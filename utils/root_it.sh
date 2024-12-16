#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：root_it.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-11-25 03:37
#   Description   ：
# ================================================================

#recursively find all file with extension.md in this folder, put them in the dir .
# write it to a function and run the function in the end.


find . -name "*.md" -exec mv {} . \;


