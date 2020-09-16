#!/bin/sh

swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_to_output DP-3"
swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_from_region 0.0x0.0 1.0x1.0"
swaymsg "exec krita --platform wayland-egl" & swaymsg reload
