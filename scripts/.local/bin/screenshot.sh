#!/bin/sh

UNIQUE_URL=$(pwgen -s 4 1)
FILE=$(date +'screenshot_%Y-%m-%d-%H%M%S')_$(cat /etc/hostname).png
FILE_PATH=$(xdg-user-dir PICTURES)/Screenshots/$FILE
WEB_PATH="/mnt/7TB/web_files/f"
SCREENSHOT_DIR="/mnt/7TB/Pictures/Screenshots"
SECOND_PATH=$SCREENSHOT_DIR/$FILE
CURRENT_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
CURRENT_OUTPUT_SCALE=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .scale')
echo "$FILE_PATH"

upload() {
    cp "$FILE_PATH" "$SECOND_PATH"
    ln -s "$SECOND_PATH" $WEB_PATH/$UNIQUE_URL.png
    echo https://f.lucy.moe/$UNIQUE_URL
    wl-copy "https://f.lucy.moe/$UNIQUE_URL"
    notify-send "uploaded to https://f.lucy.moe/$UNIQUE_URL"
}

screenshot(){
    if [ $1 = "region" ]
    then
	    slurp | grim -s $CURRENT_OUTPUT_SCALE -c -g - "$FILE_PATH" && return 0
    fi
    if [ $1 = "output" ]
    then
	    grim -s $CURRENT_OUTPUT_SCALE -o $CURRENT_OUTPUT "$FILE_PATH" && return 0
    fi
    if [ $1 = "everything" ]
    then
	    grim -s $CURRENT_OUTPUT_SCALE "$FILE_PATH" && return 0
    fi
    return 1
}

notify(){
    notify-send "took screenshot and saved to $FILE_PATH" && return 0
}

prompt(){
	$(echo "exit 
upload" | wofi -d)
}

#slurp | grim -s $CURRENT_OUTPUT_SCALE -c -g - "$FILE_PATH" &&\
screenshot $1 && notify && prompt
