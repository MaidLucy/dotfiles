#!/bin/bash

ffmpeg -f pulse -i echoCanel_source -ac 1 -c:a libvorbis $(date +'voice_%Y-%m-%d-%H%M%S').ogg
