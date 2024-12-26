# Enter script code
import platform
output = ""
output += "Platform: " + platform.platform() + "\n"
output += "Browser: " + os.popen("google-chrome --version").read()
output += "Browser: " + os.popen("firefox --version").read()
output += "Date Tested :" + system.exec_command("date")
keyboard.send_keys(output)