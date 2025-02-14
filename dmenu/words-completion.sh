#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：run_files.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-21 01:02
#   Description   ：
# ================================================================
LAUNCHER="dmenu -l 5 -i -p "
#EDITOR="emacsclient -c"
[ -z "${DISPLAY}" ] && LAUNCHER="fzf --prompt "

declare -A words
words["api"]="sk-Jlqw3VNRB6cRbEbGRgvqCHgvS9c4K9jU8J1b6gCoit7EHEJ3"
words["chatAnywhere host(abord)"]="api.chatanywhere.org"
words["chatAnywhere host(china)"]="api.chatanywhere.tech"
words["chatAnywhere endpoint"]="/v1/chat/completions"
words["chatAnywhere baseURL"]="https://api.chatanywhere.tech/v1/chat/completions"
words["rss"]="http://87.106.191.101:1200/"
words["linkding"]="http://16.171.150.115:9090/bookmarks?q="
words["surfingkeys addres"]="https://raw.githubusercontent.com/gongshangzheng/MyConf/refs/heads/master/surfingkeys.js"
words["css img"]="#+ATTR_HTML: :width 50% :align center"
words["deepseek baseURL"]="https://api.deepseek.com/chat/completions"
words["deepseek api"]="sk-80b0aa04580e488f8bd5da534f55ea4a"
words["deepseek model"]="deepseek-chat"
words["siliconFlow api"]="sk-vpxgapqqneldyjxzsbdubfiedytjdrlpmtcistvwpjfjhjql"
words["siloconFlow baseURL"]="https://api.siliconflow.cn/v1/chat/completions"
words["french genre prompt"]="现在你是我的法语单词学习助手，给我一个法语单词，让我判断其词性，如果我回答 f, 就代表我认为其是阴性；如果我回答 m, 就代表我认为其是阳性。如果我回答错了，纠正我，并给我一些相似的词及其解释；如果我回答对了，给我一些相似的词及其解释。解释以后，用这些词及原词造句，而后给我一个新的词让我判断词性。"
# Create a string to display key | value pairs
word_list=""
#printf "%s\n" "${!words[@]}"
for key in "${!words[@]}"; do
    #printf "key: %s\n" "$key"
    #printf "value: %s\n" "${words[$key]}"
    #printf "%s | %s\n" "$key" "${words[$key]}"
    word_list+="$key | ${words[$key]}\n"
done

# Show the key | value list in the launcher
choice=$(echo -e "$word_list" | $LAUNCHER "choose words:") || exit 1

# Extract the key (before the first " | ") from the selected choice
selected_word=$(echo "$choice" | cut -d'|' -f2)
#printf "Selected word: %s\n" "$selected_word"
# Execute the corresponding word
# 检查是否安装了 xdotool
if ! command -v xdotool &> /dev/null; then
    echo "xdotool 未安装，请先安装它。"
    exit 1
fi

# 打印 "hello world!" 到当前光标位置
xdotool type "$selected_word"

