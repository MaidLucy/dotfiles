#!/bin/bash

cd ~/Games/osu_wine_pipewire
input(){
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_to_output DP-1"
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_from_region 0.0x0.0 0.45473688x0.405"
	#swaymsg "input * pointer_accel -0.2"
}

osu_launch(){
	#sudo cpupower frequency-set -g performance
	cd ~/Games/osu_wine_pipewire
	export WINEPREFIX="$HOME/Games/osu_wine_pipewire"
    export STAGING_AUDIO_DURATION=50000
    #export STAGING_AUDIO_PERIOD=45000
	export PATH=$HOME/Games/osu_wine_pipewire/wine-osu/bin:$PATH
	wine $HOME/Games/osu_wine_pipewire/drive_c/osu\!/osu\!.exe $1
}

lazer_launch(){
	export SDL_VIDEODRIVER=wayland
    export PIPEWIRE_LATENCY="128/48000"
	/usr/bin/osu-lazer
}

osu_kill(){
	export WINEPREFIX="$HOME/Games/osu_wine_pipewire"
	export PATH=$HOME/Games/osu_wine_pipewire/wine-osu/bin:$PATH
	wineserver -k
}

reset_input(){
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_to_output DP-1"
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_from_region 0.0x0.0 1.0x1.0"
	#swaymsg "input * pointer_accel 0"
}

#input && $(printf "osu_launch \nlazer_launch" | fzf) $1 
input && osu_launch $1 
osu_kill
reset_input
