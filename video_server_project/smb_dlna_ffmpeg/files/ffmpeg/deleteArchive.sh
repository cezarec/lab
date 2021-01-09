#!/bin/bash
# recordCam.sh
# ------------
# This script deletes pld recordings
# -----------

find /media/user/500GB_2/VSS/recordings/archive -mindepth 3 -type d -mmin +1 -exec rm -r {} \; && 
echo 'DELETER: Old archives deleted!'
