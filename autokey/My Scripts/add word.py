#!/usr/bin/env python3
retCode, word = dialog.input_dialog(title="word", message="Enter the word")
if retCode == 1:
    exit()
retCode, code = dialog.input_dialog(title="code", message="Enter the code")
if retCode == 1:
    exit()
# 定义文件路径
file_path = '/home/xinyu/.config/ibus/rime/wubi86_jidian_user.dict.yaml'

# 将结果附加写入文件
with open(file_path, 'a') as f:
    f.write(f"{word}\t{code}\n")