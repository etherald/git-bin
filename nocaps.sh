#!/bin/sh

### BEGIN INIT INFO
# Provides:          nocaps
# Required-Start:    checkroot
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Remap caps lock > ctrl.
# Description:       Remap caps lock key to control key
### END INIT INFO


# This temporarily remaps the CapsLock key to a Control key.
# The keyboard will return to the previous settings after a
# reboot. The Linux console and the X Window system each
# handles keypresses separately, so each must be remapped
# separately. First remap the X keyboard since this does not
# require root access.

# Remap the CapsLock key to a Control key for
# the X Window system.

. /lib/lsb/init-functions

if type setxkbmap >/dev/null 2>&1; then
        setxkbmap -layout us -option ctrl:nocaps 2>/dev/null &
fi

# You have to be root to remap the console keyboard.
if [ "$(id -u)" != "0" ]; then
        echo "This script is not running as root so"
        echo "the console CapsLock cannot be remapped."
        echo "Perhaps you forgot to run this under sudo."
        echo "Note that this problem does not effect X."
        echo "This only effects the consoles running on"
        echo "Alt-f1 through Alt-f6."
        exit 2
fi
# Remap the CapsLock key to a Control key for the console.
(dumpkeys | grep keymaps; echo "keycode 58 = Control") | loadkeys &

log_action_msg "Remapped caps lock to ctrl"