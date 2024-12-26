#!/usr/bin/env python
# coding=utf8
# ===============================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：dialog.py
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-15 14:01
#   Description   ：
# ===============================================================================
import subprocess
from mycommon import DialogData, ColourData

class MyDialog:
    def list_menu(self, options, package="yad", title="Choose a value", message="Choose a value", default=None, columns=None, **kwargs):
        """
        Show a single-selection list menu using yad

        @param options: list of options (strings) for the dialog or a list of lists for multiple columns
        @param package: yad, or zenity
        @param title: window title for the dialog
        @param message: message displayed above the list
        @param default: default value to be selected
        @param column_titles: list of column titles for multiple columns
        @return: a tuple containing the exit code and user choice
        @rtype: tuple(int, str)
        """

        # Prepare command
        command = ["--list", "--text", message]

        # If column titles are provided, add them to the command
        if columns:
            for title in columns:
                command.extend(["--column", title])  # 每个标题都单独添加
        else:
            if options and isinstance(options[0], list):
                for title in options[0]:
                    command.extend(["--column", title])
            else:
                command.extend(["--column", "Option"])


        # Flatten the options if it's a list of lists
        if options and isinstance(options[0], list):
            if columns:
                for option in options:
                    command.extend(option)
            else:
                for option in options[1:]:
                    command.extend(option)
        else:
            command.extend(options)

        # Add additional kwargs to the command
        for k, v in kwargs.items():
            command.append(f"--{k}")
            command.append(str(v))  # Convert value to string

        # Run the yad command
        with subprocess.Popen(
                [package, "--title", title] + command,
                stdout=subprocess.PIPE,
                universal_newlines=True) as p:
            output = p.communicate()[0][:-2]  # Drop trailing newline
            return_code = p.returncode

        return DialogData(return_code, output)

if __name__ == "__main__":
    mydialog = MyDialog()
    options = [
        ["Firefox", "firefox"],
        ["Emacs", "emacs"],
        ["AutoKey", "autokey"],
        ["Nautilus", "nautilus"],
        ["Chromium", "chromium-browser"]
    ]
    column_titles = ["Name", "Command"]
    retCode, choice = mydialog.list_menu(options, title="Select Program", message="Choose a program to launch:", height='800', width='500', column_titles=column_titles)

    if retCode == 0:
        print(f"You selected: {choice}")
    else:
        print("No selection or dialog was canceled.")
