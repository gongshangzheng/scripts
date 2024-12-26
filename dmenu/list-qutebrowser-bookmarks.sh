#!/bin/sh

# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.

LAUNCER="dmenu -l 20 -i -p "
#LAUNCER="rofi -dmenu -i -p "
BROWSER="$HOME/scripts/py_scripts/.venv/bin/python3 -m qutebrowser"
linkding_rss="http://16.171.150.115:9090/feeds/f3cb12a3a0c94b35a4440f1fa58f038e31fee606/all"
[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "

localBROWSER="$BROWSER "
[ -n "$*" ] && localBROWSER="$*"
[ -z "${DISPLAY}" ] && localBROWSER="w3m "

linkding_bookmarks="$( curl -s $linkding_rss | xmlstarlet sel -t -m "//item" -v "concat('linkding: ', title, ' | ', link)" -n )"
qutebrowser_bookmarks=$( sed "s/^/bookmark: /" $HOME/.config/qutebrowser/bookmarks/urls)
qutebrowser_quickmarks=$( sed "s/^/quickmark: /" $HOME/.config/qutebrowser/quickmarks)
#printf "%s" "$linkding_bookmarks"
if [ -f $HOME/.config/qutebrowser/bookmarks/urls ]; then
	choice=$((echo "🦆" && echo "$qutebrowser_bookmarks" && echo "$qutebrowser_quickmarks"  &&  echo "$linkding_bookmarks") | $LAUNCER"Search:") || exit 1
else
	choice=$(echo "🦆" | $LAUNCER -i -p "Search DuckDuckGo:") || exit 1
fi

case "$choice" in
*🦆*)
	$localBROWSER
	exit
	;;
bookmark:*)
	$localBROWSER"$(echo $choice | awk '{print $2}')"
	exit
	;;
quickmark:*)
    $localBROWSER"$(echo $choice | awk '{print $NF}')"
    exit
    ;;
linkding:*)
    $localBROWSER"$(echo $choice | awk '{print $NF}')"
    exit
    ;;
*) $localBROWSER"https://duckduckgo.com/?q=$choice"
	exit
	;;
esac
#vim:ft=sh

