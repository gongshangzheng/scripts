# Enter script code
from autokey.common import USING_QT
import os
import subprocess
import time


def is_emacs_daemon_running():
    try:
        # 使用 emacsclient 检查服务器是否在运行
        result = subprocess.run(
            ['emacsclient', '-e', '(server-running-p)'],
            capture_output=True,
            text=True
        )
        return result.returncode == 0  # 返回码为 0 表示服务器正在运行
    except Exception as e:
        print(f"Error checking Emacs daemon: {e}")
        return False

def start_emacs_daemon():
    try:
        print("Starting Emacs daemon...")
        subprocess.Popen(['emacs', '--daemon'])
    except Exception as e:
        print(f"Error starting Emacs daemon: {e}")
    time.sleep(5)

def main():
    if not is_emacs_daemon_running():
        start_emacs_daemon()
    else:
        print("Emacs daemon is already running.")

    # 启动 emacsclient
    # subprocess.run(['emacsclient', '-c'])

# 定义文件列表
files = [["File Name", "Address"]]
files.append(["Rime 主词库", "~/.config/ibus/rime/wubi86_jidian.dict.yaml"])  # 替换为实际路径
files.append(["Rime 用户词库", "~/.config/ibus/rime/wubi86_jidian_user.dict.yaml"])  # 替换为实际路径
files.append(["实用脚本", "~/scripts/utils/"])  # 替换为实际路径
files.append(["AutoKey文件夹", "~/scripts/autokey/My Scripts"])  # 替换为实际路径
files.append(["README", "~/scripts/autokey/README.org"])  # 替换为实际路径

menuBuilder = []
defEntry = ""
menuEntry = "{} - {}"

# 构建菜单
for file in files:
    entry = menuEntry.format(file[0], file[1])
    if "default" in file:
        defEntry = entry
    menuBuilder.append(entry)

# 创建菜单并获取用户选择
import mydialog
mydialog = mydialog.MyDialog()
if USING_QT:
    retCode, choice = dialog.list_menu(menuBuilder, default=defEntry)
else:
    retCode, choice = mydialog.list_menu(files, default=defEntry, height='800', width='500')
# 设置编辑器变量
editor = "emacsclient -c"  # 或者设置为 "emacs"
if "emacsclient -c" == editor:
    main()
# 执行选择的命令
if retCode == 0:
    os.system(f'{editor} "{choice.split("|")[-1]}"')
