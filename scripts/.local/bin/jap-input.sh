#!/bin/bash

pids=()

kill_wlanthy(){
	for pid in ${pids[*]}; do
		kill $pid
	done
}

start_wlanthy(){
	~/Software/wlanthy/build/wlanthy & 
	pids+=($!)
}

textbox(){
	wofi --dmenu | wl-copy --trim-newline
}

kill_wlanthy(){
	for pid in ${pids[*]}; do
		kill $pid
	done
}

start_wlanthy && textbox && wl-paste --no-newline
kill_wlanthy
