# Enter script code
from autokey.common import USING_QT

#Required: sshpass
#        : and for you to be in the terminal already

# you should only have one line where the 4th element has the world "default"
# the last line to have default in it will be the default in the list
# these are all local ips obviously and the passwords are stupid (3rd element)
# on purpose
systems = []
# systems.append( [ "","","GENERAL" ])
# systems.append( [ "127.0.0.1",  "root",  "reallyhardpasswordnot"])
systems.append( [ "87.106.191.101",  "xinyu",  "159329",  "default"])

menuBuilder = []
defEntry = ""
menuEntry = "{} {} {}"
hdrEntry = "====== {} ======"
for x in systems:
    if x[1] == "" and x[2] != "":
        entry = hdrEntry.format(x[2])
    elif x[1] == "" and x[2] == "":
        entry = ""
    else:
        entry = menuEntry.format(x[1], x[2], x[0])
        if x.count("default") == 1:
            defEntry = entry
    menuBuilder.append(entry)

# We use the boolean check to see which toolkit we're using
# the different toolkits receive extra parameters differently
try:
    if USING_QT:
        retCode, choice = dialog.list_menu(menuBuilder, default=defEntry)
    else:
        retCode, choice = dialog.list_menu(
            menuBuilder, height="800", width="350", default=defEntry
        )

    if retCode == 0:
        command = 'sshpass -p "{}" ssh -o StrictHostKeyChecking=no {}@{}'
        keyboard.send_keys(
            command.format(
                systems[menuBuilder.index(choice)][2]
                .replace("$", "\$")
                .replace("!", "\!"),
                systems[menuBuilder.index(choice)][1],
                systems[menuBuilder.index(choice)][0],
            )
        )
except:
    exit()  