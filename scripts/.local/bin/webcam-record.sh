#!/bin/bash
ffmpeg -y -hide_banner -thread_queue_size 2048 -itsoffset -0.5 -f alsa -i hw:PCH -thread_queue_size 2048 -f v4l2 -input_format mjpeg -video_size 1920x1080 -i /dev/video0 -c:v copy -c:a aac  Videos/webcam-recording-$(date '+%Y-%m-%d_%H-%M-%S').mp4
