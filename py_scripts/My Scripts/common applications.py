import subprocess
import mydialog
from autokey.common import USING_QT

# 定义可选择的程序
choices = [
    ["firefox", "firefox"],
   ["emacs", "emacsclient -c"],
 #["qutebrowser", "/home/xinyu/application/qutebrowser/.venv/bin/python3 -m qutebrowser \"$@\""],
 ["qutebrowser", "qutebrowser"],
    ["autokey", "autokey"],
    ["nautilus", "nautilus"],
    ["chromium", "chromium-browser"],
]

# 构建菜单
menuBuilder = []
defEntry = ""
menuEntry = "{} {}"
for x in choices:
    entry = menuEntry.format(x[0], x[1])
    if "default" in x:  # 检查是否有默认选项
        defEntry = entry
    menuBuilder.append(entry)

# 创建菜单并获取用户选择
# import mydialog
# from autokey.common import USING_QT

mydialog_instance = mydialog.MyDialog()
if USING_QT:
    retCode, choice = mydialog_instance.list_menu(menuBuilder, default=defEntry)
else:
    retCode, choice = mydialog_instance.list_menu(choices, default=defEntry, height='800', width='500', columns=["name", "program"])  

# 执行用户选择的命令
#import subprocess
if retCode == 0:
    # 从用户选择中提取程序名
    selected_program = choice.split("|")[-1]  # 获取选择的第一个部分，即程序名

    # 执行选定的程序
    try:
        subprocess.Popen([selected_program])
        print(f"正在启动 {selected_program}...")
    except Exception as e:
        print(f"启动 {selected_program} 时出错: {e}")
else:
    print("用户取消了选择或发生错误。")
