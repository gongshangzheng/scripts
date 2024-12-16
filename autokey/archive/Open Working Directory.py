# Enter script code
from autokey.common import USING_QT
import os

# 定义工作目录列表
directories = []
directories.append(["rime", ".config/ibus/rime"])  # 替换为实际路径
directories.append(["doom", ".doom.d"])  # 替换为实际路径
directories.append(["STA", "Code/STA/finalProjet"])  # 替换为实际路径
directories.append(["Download", "Downloads", "default"])  # 替换为实际路径

menuBuilder = []
defEntry = ""
menuEntry = "{} - {}"

# 构建菜单
for dir in directories:
    entry = menuEntry.format(dir[0], dir[1])
    if "default" in dir:
        defEntry = entry
    menuBuilder.append(entry)

# 创建菜单并获取用户选择
if USING_QT:
    retCode, choice = dialog.list_menu(menuBuilder, default=defEntry)
else:
    retCode, choice = dialog.list_menu(menuBuilder, height='800', width='350', default=defEntry)

# 执行选择的命令
if retCode == 0:
    selected_index = menuBuilder.index(choice)
    folder_path = directories[selected_index][1]
    os.system(f'nautilus "{folder_path}"')
