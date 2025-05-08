#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：toggle-rime.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-31 04:08
#   Description   ：
# ================================================================



if ! /home/xinyu/scripts/tools/program-has-focus --class "[Ee]macs"; then
    current_engine=$(ibus engine)
    if [[ "$current_engine" == "rime" ]]; then
        ibus engine xkb:us::eng
    else
        ibus engine rime
    fi
else
     xdotool keydown ctrl & xdotool key backslash & xdotool keyup ctrl
     # xdotool key ctrl+backslash
fi
