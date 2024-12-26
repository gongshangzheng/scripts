#!/bin/python3
import sys
import os
from datetime import date
from rofi import Rofi

# path to where you want your TODOs to be inserted to
inbox_file = "/home/xinyu/.doom.d/org/inbox.org"
r = Rofi()

def todo_to_inbox():
    todo = r.text_entry("TODO", message="""Usage:
    Type full text of org TODO and any tags
    eg. Code rofi-org-todo for fast adds to inbox  :mensch:w33:
    """)
    if todo is not None:
        f = open(inbox_file, "a")
        f.write("\n* TODO ")
        f.write(todo + "\n")
        f.write(":PROPERTIES:\n")
        f.write(":CREATED: " + "[" + date.today().strftime("%Y-%m-%d %a") + "]\n")
        f.write(":END:\n\n")
        f.close()

def display_todos():
    with open(inbox_file, "r") as f:
        todos = f.readlines()
    filtered_todos = [todo for todo in todos if todo.startswith("* TODO ")]
    r.text_entry("TODO List", message="\n".join(filtered_todos))

display_todos()
todo_to_inbox()
