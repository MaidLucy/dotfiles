#!/bin/bash

rm ~/.config/gtk-3.0/settings.ini
ln -s ~/.config/sway/themes/catppuccin-latte-maroon-gtk3.ini ~/.config/gtk-3.0/settings.ini
rm ~/.gtkrc-2.0
ln -s ~/.config/sway/themes/catppuccin-latte-maroon-gtkrc2 ~/.gtkrc-2.0
echo "background          #FFF3F3" > ~/.cache/themes/kitty.conf
echo "@import url('https://raw.githubusercontent.com/catppuccin/waybar/main/themes/latte.css');
@define-color background #FFF3F3;
@define-color hard @maroon;
@define-color soft @rosewater;" > ~/.cache/themes/waybar.css
papirus-folders -C cat-latte-maroon --theme Papirus-Light
~/.config/sway/import-gsettings
