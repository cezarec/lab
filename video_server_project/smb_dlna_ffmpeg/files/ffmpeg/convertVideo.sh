#!/bin/bash
# convertVideo.sh
# ---------------
# This script converts the original, high quality recording to a much smaller
# and lower quality file for archiving purposes.
# ---------------

# Define some paths
MODULEname='CONVERTER: '
BASEpath='/media/user/500GB_2/VSS/recordings'
ARCHIVEpath=$BASEpath'/archive'
RECpath=$BASEpath'/video'

# Video conversion parameters
# Experiment freely with them
framerate='5'
bitrate='100k'

# Check that the file actually exists
if [[ ! -f $1 ]]
then
	echo 'File not found'
	exit 0;
fi

# Get the file's name
FILEname="`basename $1`"
FILEpath=$(cd $(dirname $1); pwd);

# The camera's name is the last 5 characters of the path, as each folder is called camXX where XX is the cam number
CAM=${FILEpath: -5}

# These variables will be used to create the destination path, feel free to edit them as needed
YEAR_MONTH=${FILEname:0:7}
DAY=${FILEname:8:2}
DESTINATIONpath=$ARCHIVEpath'/'$CAM'/'$YEAR_MONTH'/'$DAY;


# If the destination folder does not exist (i.e. new day/month), create it
if [[ ! -d $DESTINATIONpath ]]
then
	echo $MODULEname'Destination folder not found, creating it ('$DESTINATIONpath')'
	mkdir -p $DESTINATIONpath
fi


# Convert the video
ffmpeg -i $1 -r 5 -preset ultrafast -b:v 100k $DESTINATIONpath'/'$FILEname
echo $MODULEname'File '$DESTINATIONpath'/'$FILEname' converted!'

# Delete the original file
rm $1
echo $MODULEname'File '$1' deleted!'
