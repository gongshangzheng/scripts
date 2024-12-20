#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：install.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-20 20:51
#   Description   ：
# ================================================================

parent_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

cd $parent_dir

chmod 755 rm.sh
ln -s $parent_dir/rm.sh /usr/local/bin/safe-rm
