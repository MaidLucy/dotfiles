#!/bin/bash

ffmpeg -f pulse -i alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.iec958-stereo -ac 1 -c:a libvorbis Voice\ Recordings/$(date +'voice_%Y-%m-%d-%H%M%S').ogg
