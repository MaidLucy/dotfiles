#!/bin/bash
# 
# Credits for the functions to kill the ffmpeg processes 
# and catching the Ctrl+C event go to Cholik and FichteFoll.

# set the cap_sys_admin thing that is required for ffmpeg to do kmsgrab
sudo setcap cap_sys_admin+ep /usr/bin/ffmpeg

pids=()

# function to be called when SIGINT is caught
function muh_trep()
{
	for pid in ${pids[*]}; do
		kill $pid
	done
}

pulse_device="alsa_output.usb-SMSL_SMSL_M6-00.iec958-stereo.monitor"
crtc_id=49

trap muh_trap SIGINT

# execute the processes and add their respective PIDs to the pids array
ffmpeg -fflags nobuffer -f pulse -i $pulse_device -c:a copy -f s16le tcp://192.168.188.115:9899\?listen=1
pids+=($!)
ffmpeg -fflags nobuffer -y -framerate 60 -crtc_id $crtc_id -vsync 0 -device /dev/dri/card0 -vaapi_device /dev/dri/renderD128 -f kmsgrab -i - -vf 'hwmap,scale_vaapi=format=nv12' -c:v h264_vaapi -rc_mode 2 -b:v 100000k -bf 0 -f mpegts tcp://192.168.188.115:9898\?listen=1
pids+=($!)

for pid in ${pids[*]}; do
	wait $pid
done

