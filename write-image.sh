#!/bin/bash

MEDIUM_LABEL=mmcblk0

echo "Medium to be written:"`lsblk | grep "^$MEDIUM_LABEL"`
echo "Are you sure you want to continue? [y/n]"
read  answer
if [ $answer == 'y' ]; then
        last_image=`ls image*.img | sort | tail -n1`
else
        exit 1
fi

card_size=`lsblk | grep "^$MEDIUM_LABEL" | awk '{print $4;}' | cut -f1 -d.`
image_size=`stat -c%s $last_image | awk '{ foo = $1 / 1024 / 1024 / 1024; print foo }' | cut -f1 -d.`
if [ $card_size -lt $image_size ]; then
        echo "Card too small..."
        exit 1
fi;

echo "WRITING: $last_image TO: "`lsblk | grep "^$MEDIUM_LABEL"`
sudo su -c "dd if=$last_image bs=4M of=/dev/$MEDIUM_LABEL"
sync
