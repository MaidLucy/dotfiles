#!/bin/bash

rm ~/.config/gtk-3.0/settings.ini
ln -s ~/.config/sway/themes/catppuccin-latte-sky-gtk3.ini ~/.config/gtk-3.0/settings.ini
rm ~/.gtkrc-2.0
ln -s ~/.config/sway/themes/catppuccin-latte-sky-gtkrc2 ~/.gtkrc-2.0
echo "background          #EFF9FE" > ~/.cache/themes/kitty.conf
echo "@import url('https://raw.githubusercontent.com/catppuccin/waybar/main/themes/latte.css');
@define-color background #EFF9FE;
@define-color hard @sky;
@define-color soft @sapphire;" > ~/.cache/themes/waybar.css
papirus-folders -C cat-latte-sky --theme Papirus-Light
~/.config/sway/import-gsettings
