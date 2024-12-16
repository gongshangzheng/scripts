from autokey.common import USING_QT
import subprocess

# 定义网站及其名称
browser = 'chromium-browser'
websites = [["Name", "Website Address"]]
websites.append(["Localhost", "http://127.0.0.1"])
websites.append(["chat", "https://next-chat-xinyu.vercel.app/#/chat"])
websites.append(["Linkding", "http://16.171.150.115:9090/"])

menuBuilder = []
defEntry = ""
menuEntry = "{} - {}"

# 构建菜单
for site in websites:
    entry = menuEntry.format(site[0], site[1])
    if "default" in site:
        defEntry = entry
    menuBuilder.append(entry)

# 创建菜单并获取用户选择
import mydialog
mydialog = mydialog.MyDialog()
if USING_QT:
    retCode, choice = dialog.list_menu(menuBuilder, default=defEntry)
else:
    retCode, choice = mydialog.list_menu(websites, default=defEntry, height='800', width='500')

# 执行选择的命令
if retCode == 0:
    subprocess.Popen([browser, choice.split("|")[-1]])
