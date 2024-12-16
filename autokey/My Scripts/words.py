from autokey.common import USING_QT

# Maybe you don't want to set up a name server or you got some sites
# you goto that are just ips, w/e the reason this works too.
ipaddresses = [["Name", "IP Address"]]
ipaddresses.append(["local",  "127.0.0.1"])
ipaddresses.append(["ionos",  "http://87.106.191.101"])
ipaddresses.append(["OpenAI Key", "sk-Jlqw3VNRB6cRbEbGRgvqCHgvS9c4K9jU8J1b6gCoit7EHEJ3"])
ipaddresses.append(["ChatAnyWhere Base URL", "https://api.chatanywhere.org"])
ipaddresses.append(["aws",  ""])
# clearly mom needs lots of remote work and nobody goes near john's filth can

menuBuilder = []
defEntry = ""
menuEntry = "{} {}"
for x in ipaddresses:
  entry=menuEntry.format(x[0],x[1])
  if x.count("default") == 1:
      defEntry=entry
  menuBuilder.append(entry)

# 创建菜单并获取用户选择
import mydialog
mydialog = mydialog.MyDialog()
if USING_QT:
    retCode, choice = dialog.list_menu(menuBuilder, default=defEntry)
else:
    retCode, choice = mydialog.list_menu(ipaddresses, default=defEntry, height='800', width='500')

if retCode == 0:
    selection="{}"
    keyboard.send_keys(selection.format(
    choice.split("|")[-1]
    ))