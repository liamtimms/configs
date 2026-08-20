#!/bin/sh
# Load personal GNOME keybindings into the current session (run as yourself,
# inside a graphical session or with DBUS_SESSION_BUS_ADDRESS set).
d="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
dconf load /org/gnome/desktop/wm/keybindings/ < "$d/wm-keybindings.conf"
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$d/media-keys.conf"
echo "GNOME keybindings applied."
