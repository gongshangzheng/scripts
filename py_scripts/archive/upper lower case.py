# Enter script code
#
# Change case of selected text. Repeated runs to this script cycle through Uppercase, Title Case, Lowercase:
#   HELLO WORLD, Hello World, hello world
#
# jack

# Get the current selection.
sText=clipboard.get_selection()
lLength=len(sText)

try:
    if not store.has_key("textCycle"):
        store.set_value("state","title")

except:
    pass

# get saved value of textCycle
state = store.get_value("textCycle")

#dialog.info_dialog(title='state', message=state)


# modify text and set next modfication style
if state == "title":
    sText=sText.title()
    newstate = "lower"

elif state == "lower":
    sText=sText.lower()
    newstate = "upper"

elif state == "upper":
    sText=sText.upper()
    newstate = "title"

else:
    newstate = "lower"

# save for next run of script
store.set_value("textCycle",newstate)



# Send the result.
keyboard.send_keys(sText)
keyboard.send_keys("<shift>+<left>"*lLength)
