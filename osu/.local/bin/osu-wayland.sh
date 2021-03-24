#!/bin/bash

# card: the sound card you wanna play osu with
card="SMSL"

pulse_lowlatency(){
	# obtail pulse module ID of $card
	module_id=$(pactl list modules | grep -C 2 $card | head -n 1 | sed 's/[^0-9]*//g')
	
	# obtain module information from $card
	device_id=$(pactl list modules | grep $card | awk '{print $2}')
	name=$(pactl list modules | grep $card | awk '{print $3}')
	card_name=$(pactl list modules | grep $card | awk '{print $4}')
	
	# unload module located with $card
	pactl unload-module $module_id
	
	# loading module again with lowest latency possible
	new_module=$(pactl load-module module-alsa-card $device_id $name $card_name namereg_fail=false tsched=no fixed_latency_range=yes ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1" fragments=2 fragment_size=2)
}

input(){
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_to_output DP-2"
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_from_region 0.0x0.0 0.45473688x0.405"
}

#renice -n -13 $$
#sudo setcap cap_sys_nice+ep /opt/wine-osu/bin/wineserver

osu_launch(){
	sudo cpupower frequency-set -g performance
	cd ~/Games/osu_wine
	#bash ~/Games/osu_wine/osu.sh $1
	export WINEPREFIX="$HOME/Games/osu_wine"
	#export WINEARCH=win32
	export PATH=/opt/wine-osu/bin:$PATH

	export STAGING_AUDIO_DURATION=10000
	#export STAGING_AUDIO_DURATION=6500
	export STAGING_RT_PRIORITY_SERVER=90
	export STAGING_RT_PRIORITY_BASE=90
	wine $HOME/Games/osu_wine/drive_c/osu\!/osu\!.exe $1
}

lazer_launch(){
	export SDL_VIDEODRIVER=wayland
	/usr/bin/osu
}

osu_kill(){
	export WINEPREFIX="$HOME/Games/osu_wine"
	export PATH=/opt/wine-osu/bin:$PATH
	wineserver -k
}

reset_pulse(){
	pactl unload-module $new_module
	pactl load-module module-alsa-card $device_id $name $card_name namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=yes card_properties="module-udev-detect.discovered=1"
}

reset_input(){
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_to_output DP-2"
	swaymsg "input 1386:782:Wacom_Intuos_S_Pen map_from_region 0.0x0.0 1.0x1.0"
}

pulse_lowlatency && input && $(printf "osu_launch \nlazer_launch" | fzf) $1 && reset_pulse 
osu_kill
reset_input
