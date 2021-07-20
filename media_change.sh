#!/usr/bin/env bash
exec >> /home/pi/FloppyPlayer/mount.log 2>&1
echo "$(date) Start."
echo "$(date) Media change detected on device $1"

device=${1##*/}

lsblk | grep $device

if [ $? -eq 0 ]; then
    echo "$(date) Device exists on machine."
    echo "$(date) Mounting device $1 to /media/floppy."
    /usr/bin/systemd-mount $1 /media/floppy
    su pi -c 'cvlc --no-video --random /media/floppy/test.xspf vlc://quit' &
else
    echo "$(date) Device does not exist on machine."
    killall vlc
fi
echo "$(date) End."
