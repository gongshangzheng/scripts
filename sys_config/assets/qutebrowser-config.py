# coding=utf8
#!/usr/bin/env python
# ===============================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：qutebrowser-config.py
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-16 15:58
#   Description   ：
# ===============================================================================
import subprocess
import os
from qutebrowser.api import interceptor
import catppuccin

# ================== Theme ======================= {{{

config.load_autoconfig()

# load your autoconfig, use this, if the rest of your config is empty!
# config.load_autoconfig()

# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, 'mocha', True)

c.content.user_stylesheets = ['~/.config/qutebrowser/css/mocha-all-sites.css']
config.bind('<Ctrl-R>', 'config-cycle content.user_stylesheets "~/.config/qutebrowser/css/apprentice-all-sites.css" "~/.config/qutebrowser/css/darculized-all-sites.css" "~/.config/qutebrowser/css/gruvbox-all-sites.css" "~/.config/qutebrowser/css/solarized-dark-all-sites.css" "~/.config/qutebrowser/css/solarized-light-all-sites.css" "~/.config/qutebrowser/css/mocha-all-sites.css" "~/.config/qutebrowser/css/latte-all-sites.css"')

config.bind('<t><t>', 'set colors.webpage.darkmode.enabled true')
config.bind('<t><f>', 'set colors.webpage.darkmode.enabled false')

editor_value = "gvim" # or "gvim"
browser_value = "qutebrowser"

# }}}

# ================== Youtube Add Blocking ======================= {{{
def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()


interceptor.register(filter_yt)
# }}}
# }}}
# ====================== Special Format Yanking =========== {{{
config.bind("<y><o>", "yank inline [[{url}][{title}]]")
# }}}
# ====================== Open Notes From Qutebrowser ====== {{{

    #``os.environ["TERMINAL"] + " -e " +
# }}}

# ======================= Redline Insert Mode ============= {{{
# Awesome way to open vim from qutebrowser
#
# editor_value,
c.editor.command = [
    "gvim",
    "-f",
    "{file}",
    "-c",
    "normal {line}G{column0}1",
]
config.bind(",m", "spawn umpv {url}")
config.bind("<c><s>", "config-source")
config.bind("<Ctrl-i>", "edit-text")
config.bind(",M", "hint links spawn umpv {hint-url}")
config.bind(";M", "hint --rapid links spawn umpv {hint-url}")
config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End><Delete>", "insert")
config.bind("ab", "open -t http://16.171.150.115:9090/bookmarks/new?url={url}")
config.bind("gr", "open -t http://87.106.191.101:181/public.php?op=bookmarklets--subscribe&&feed_url={url}")
config.bind("gc", "config-edit")
config.bind("ge", "edit-text")
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("<Ctrl+g>", "fake-key <Esc>")
config.bind("gz", "zotero")
c.aliases = {'w': 'session-save',
             'q': 'close',
             'qa': 'quit',
             'wq': 'quit --save',
             'wqa': 'quit --save',
             'zotero': 'spawn --userscript zotero'}
# config.bind("<Ctrl-x><Ctrl-e>", "config-edit")
# }}}
