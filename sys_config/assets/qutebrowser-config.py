#!/usr/bin/env python
# coding=utf8
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
config.load_autoconfig()
"""
qutebrowser settings for video

for more settings check out
https://qutebrowser.org/doc/help/settings.html
"""

editor_value = "emacsclient" # or "gvim"
browser_value = "qutebrowser"

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
# =================== Launch Qutebrowser from Dmenu ====== {{{

"""
#!/bin/sh

# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.

LAUNCER="dmenu -l 5 -i -p "
[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "

localBROWSER="$BROWSER "
[ -n "$*" ] && localBROWSER="$*"
[ -z "${DISPLAY}" ] && localBROWSER="w3m "

if [ -f ~/.config/bookmarks ]; then
	choice=$( (echo "🦆" && cat ~/.config/bookmarks) | $LAUNCER"Search:") || exit 1
else
	choice=$(echo "🦆" | $LAUNCER -i -p "Search DuckDuckGo:") || exit 1
fi

case "$choice" in
*🦆*)
	$localBROWSER"https://duckduckgo.com"
	exit
	;;
http*)
	$localBROWSER"$(echo $choice | awk '{print $1}')"
	exit
	;;
*) $localBROWSER"https://duckduckgo.com/?q=$choice"
	exit
	;;
esac
#vim:ft=sh
"""

# }}}
# ====================== Special Format Yanking =========== {{{
config.bind("<y><o>", "yank inline [[{url}][{title}]]")
# }}}
# ====================== Open Notes From Qutebrowser ====== {{{

    #``os.environ["TERMINAL"] + " -e " +
notecmd = "yank inline [[{url}][{title}]];; spawn " +\
editor_value + \
    " -c 'call CreateCapture(\"e\" , \"qutebrowser\")'"
config.bind("gn", notecmd)



"""
" PART OF MY VIMRC
" I used minisnip to execute the vimscript but you could just use autocommands

" Simple implementation of org-capture using minisnip
function! CreateCapture(window, ...)
        " file used to store all captures
	let g:org_refile='~/Documents/org/refile.org'
	if a:0 == 1 && a:1 == 'qutebrowser'
		exec a:window . ' ' . g:org_refile
		exec '$read ' . globpath(&rtp, 'extra/org/templateQUTE.org')
	endif
	call feedkeys("i\\<Plug>(minisnip)", 'i')
endfunction
"""

"""
" ~/.vim/extra/org/templateQUTE.org
* TODO {{+~getreg('+')+}}
SCHEDULED: <{{+~strftime(g:org_date_format)+}}>
"""
# }}}
# ======================= External Open =================== {{{
config.bind("V", "hint links spawn " + browser_value + ' "{hint-url}"')
config.bind("v", 'hint links spawn funnel "{hint-url}"')
config.bind("\\", 'spawn dmenuhandler "{url}"')
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
config.bind("<Ctrl-x><Ctrl-e>", "config-edit")
# }}}
# ====================== xresources ======================= {{{
# taken from https://qutebrowser.org/doc/help/configuring.html
def read_xresources(prefix):
    """
    read settings from xresources
    """
    props = {}
    x = subprocess.run(["xrdb", "-query"], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split("\n")
    for line in filter(lambda l: l.startswith(prefix), lines):
        prop, _, value = line.partition(":\t")
        props[prop] = value
    return props



# Read xresources
xresources = read_xresources("*")

# Fallback colors
default_background = "#282a36"  # Replace with your desired fallback color
default_foreground = "#f8f8f2"  # Replace with your desired fallback color
default_color8 = "#bd93f9"      # Replace with your desired fallback color

# Statusbar colors
c.colors.statusbar.normal.bg = xresources.get("*.background", default_background)
c.colors.statusbar.command.bg = xresources.get("*.background", default_background)
c.colors.statusbar.command.fg = xresources.get("*.foreground", default_foreground)
c.colors.statusbar.normal.fg = xresources.get("*.foreground", default_foreground)
c.statusbar.show = "always"

# Tab colors
c.colors.tabs.even.bg = xresources.get("*.background", default_background)
c.colors.tabs.odd.bg = xresources.get("*.background", default_background)
c.colors.tabs.even.fg = xresources.get("*.foreground", default_foreground)
c.colors.tabs.odd.fg = xresources.get("*.foreground", default_foreground)
c.colors.tabs.selected.even.bg = xresources.get("*.color8", default_color8)
c.colors.tabs.selected.odd.bg = xresources.get("*.color8", default_color8)

# Hints colors
c.colors.hints.bg = xresources.get("*.background", default_background)
c.colors.hints.fg = xresources.get("*.foreground", default_foreground)

# Tab display settings
c.tabs.show = "multiple"

# Fallback colors
default_background = "#282a36"  # Replace with your desired fallback color
default_foreground = "#f8f8f2"  # Replace with your desired fallback color
default_color14 = "#ff79c6"      # Replace with your desired fallback color

c.colors.tabs.indicator.stop = xresources.get("*.color14", default_color14)
c.colors.completion.odd.bg = xresources.get("*.background", default_background)
c.colors.completion.even.bg = xresources.get("*.background", default_background)
c.colors.completion.fg = xresources.get("*.foreground", default_foreground)
c.colors.completion.category.bg = xresources.get("*.background", default_background)
c.colors.completion.category.fg = xresources.get("*.foreground", default_foreground)
c.colors.completion.item.selected.bg = xresources.get("*.background", default_background)
c.colors.completion.item.selected.fg = xresources.get("*.foreground", default_foreground)

# # Fallback for background color
default_background = "#282a36"  # Replace with your desired fallback color

# # Get the background color, using the fallback if necessary
background_color = xresources.get("*.background", default_background)

# If not in light theme
if background_color != "#ffffff":
    # Uncomment the following line if you want to enable dark mode in Qt
    # c.qt.args = ['blink-settings=darkMode=4']
    # Enable dark mode for webpages
    c.colors.webpage.darkmode.enabled = True
    c.hints.border = "1px solid #FFFFFF"
# USERSCRIPTS
#
# personally I use
# - for password managment
#   - qute-pass
# - for chrome casting I use
#   - cast
#   - I have been looking at using catt instead of castnow

# }}}

# Load existing settings made via :set
config.load_autoconfig()

# dracula.draw.blood(c, {
    # 'spacing': {
        # 'vertical': 6,
        # 'horizontal': 8
    # }
# })

# config.source('qutebrowser-themes/onedark/onedark.py')
import catppuccin

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, 'frappe', True)

import os
from urllib.request import urlopen

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'frappe', True)
