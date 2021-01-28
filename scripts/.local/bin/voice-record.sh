#!/bin/bash

ffmpeg -f pulse -i alsa_input.usb-BEHRINGER_UMC202HD_192k-00.iec958-stereo -ac 1 -c:a libvorbis Voice\ Recordings/$(date +'voice_%Y-%m-%d-%H%M%S').ogg
