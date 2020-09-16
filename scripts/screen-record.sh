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

time=$(date '+%Y-%m-%d_%H-%M-%S')
pulse_device="alsa_output.usb-SMSL_SMSL_M6-00.iec958-stereo.monitor"

trap muh_trap SIGINT

# execute the processes and add their respective PIDs to the pids array
ffmpeg -y -hide_banner -framerate 60 -crtc_id 49 -vsync 0 -device /dev/dri/card0 -vaapi_device /dev/dri/renderD128 -f kmsgrab -i - -vf 'hwmap,scale_vaapi=format=nv12' -c:v h264_vaapi -quality 15 -profile:v constrained_baseline -bf 0 -f mpegts osu-video-"$time".mpegts &
pids+=($!)
ffmpeg -y -hide_banner -f pulse -i $pulse_device -c:a copy -f wav osu-audio-"$time".wav &
pids+=($!)

for pid in ${pids[*]}; do
	wait $pid
done

# cleanup to be performed after the recording
ffmpeg -i osu-video-"$time".mpegts -i osu-audio-"$time".wav -c:a copy -c:v copy osu-"$time".mkv
rm osu-video-"$time".mpegts osu-audio-"$time".wav
