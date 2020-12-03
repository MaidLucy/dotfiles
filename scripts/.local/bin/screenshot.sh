#!/bin/sh

UNIQUE_URL=$(pwgen -s 4 1)
FILE=$(date +'screenshot_%Y-%m-%d-%H%M%S')_$(cat /etc/hostname).png
FILE_PATH=$(xdg-user-dir PICTURES)/Screenshots/$FILE
WEB_PATH="/mnt/7TB/web_files/f"
SCREENSHOT_DIR="/mnt/7TB/Pictures/Screenshots"
SECOND_PATH=$SCREENSHOT_DIR/$FILE
#echo "$FILE_PATH"

slurp | grim -s 1 -c -g - "$FILE_PATH"
notify-send "took screenshot and saved to $FILE_PATH"


#echo "$SECOND_PATH"
upload() {
    cp "$FILE_PATH" "$SECOND_PATH"
    ln -s "$SECOND_PATH" $WEB_PATH/$UNIQUE_URL.png
    echo https://f.lucy.moe/$UNIQUE_URL
    wl-copy "https://f.lucy.moe/$UNIQUE_URL"
    notify-send "uploaded to https://f.lucy.moe/$UNIQUE_URL"
}

$(echo "exit
upload" | wofi -d)
