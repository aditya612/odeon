#! /bin/bash

# This is the ffmpeg command that the screencast shortcut shell run.
# Picks a file name for the output file based on avalibility:

TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

if [ ! -d ~/odeon ]; then mkdir ~/odeon; fi

create_output_file() {
    if [ -f ~/odeon.mkv ]; then
        n=1
        while [ -f $HOME/odeon/output_$n.mkv ]; do
            n=$((n+1))
        done
        filename="$HOME/odeon/output_$n.mkv"
    else 
        filename="$HOME/odeon/output_$n.mkv"
    fi
}

create_output_file_with_timestamp() {
    filename="$HOME/odeon/output_$TIMESTAMP.mkv"
}

create_output_file_with_timestamp

# The actual ffmpeg commands:

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | awk '/dimensions/{print $2}') \
-i :0.0 \
-f alsa -i default \
-c:v libx264 -r 30 -c:a flac $filename
# -c:v ffvhuff -r 30 -c:a flac $filename
# -f pulse -ac i -ar 44100 -i default \

