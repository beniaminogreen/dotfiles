config.load_autoconfig()
config.bind("<Ctrl-Shift-y>", "hint links spawn --detach mpv --force-window yes {hint-url}")
config.bind("<Ctrl-Shift-l>", "hint links userscript libproxy.py")
#config.set('content.unknown_url_scheme_policy', "allow-all")
