#!/bin/bash

ffmpeg -f alsa -i pipewire -ac 1 -c:a libvorbis Voice\ Recordings/$(date +'voice_%Y-%m-%d-%H%M%S').ogg
