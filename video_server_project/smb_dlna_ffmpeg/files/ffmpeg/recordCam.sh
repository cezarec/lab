#!/bin/bash
# recordCam.sh
# ------------
# This script saves the live video from the IP camera to a full-quality mp4 file.
# I choose to split the files every 15 minutes (900 seconds), to quickly find the time I need.
# Note: audio is not saved as my cameras don't have a microphone connected to them.
# -----------

# Uncomment this line if you're having trouble with zero-sized files (tipically happens on low end cameras), thanks Eric! (https://lucatnt.com/2014/08/record-and-archive-video-from-ip-cameras/#comment-48019)
# killall -INT ffmpeg

echo 'New recording process started!'

# The file name. I use the date to make finding files easier.
name="`date +%Y-%m-%d_%H.%M`"

# The duration time for each record session
DURATIONtime='120'

# Where the videos will be saved
BASEpath='/media/user/500GB_2/VSS'
RECpath=$BASEpath'/recordings/video'

# Define some vars for logs
MODULEname='RECORDER: '
LOGdir=$BASEpath'/logs'

# Save the streams using ffmpeg at 30 fps, stopping the capture after 120 seconds (2 minutes). Add more lines if you have more than 2 cameras
ffmpeg -i rtsp://192.168.0.200:554/channel1 -r 30  -vcodec copy -an -metadata title=$name -t $DURATIONtime $RECpath/cam01/$name.mp4 >/dev/null 2>/dev/null &
# ffmpeg -i rtsp://192.168.0.200:554/channel1 -r 30  -vcodec copy -an -metadata title=$name -t $DURATIONtime $RECpath/cam01/$name.mp4 >/dev/null 2>/dev/null &


# Save the stream from usb cam
# ffmpeg -i /dev/video0 -r 30 -f video4linux2 -s 640x480 -f mp4 -an -t $DURATIONtime $RECpath/cam02/$name.mp4 >/dev/null 2>/dev/null &

