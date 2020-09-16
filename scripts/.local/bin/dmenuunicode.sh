#!/bin/sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

# Import the colors

. "${HOME}/.cache/wal/colors.sh"

# emoji selection
wl-copy "$(grep -v "#" ~/.scripts/gistfile1_.md | dmenu -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -i -l 20 -fn Monospace-10 | awk '{print $1}' | tr -d '\n')"

# press the paste key
ydotool key Ctrl+v
