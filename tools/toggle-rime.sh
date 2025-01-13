#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：toggle-rime.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-31 04:08
#   Description   ：
# ================================================================
 # Check if Emacs has focus
 if ! /home/xinyu/scripts/tools/program-has-focus --class Emacs; then
     # Get the current ibus engine
     current_engine=$(ibus engine)
     #echo "Current ibus engine: $current_engine"

     # Toggle between rime and eng
     if [ "$current_engine" = "rime" ]; then
         ibus engine xkb:us::eng
     else
         ibus engine rime
     fi
 else
     xdotool key ctrl+backslash
 fi
