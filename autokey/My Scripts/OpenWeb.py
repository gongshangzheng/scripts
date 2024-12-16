# Enter script code
import webbrowser
import time

time.sleep(0.1)
site = "youtube.com"
webbrowser.get('chromium-browser').open_new_tab(site)
# webbrowser.get('firefox').open_new(site) # in case you want to open a new site in firefox
# webbrowser.get('firefox').open_new_tab(site)