#!/bin/bash

ts=`date '+%m-%d-%y-%H-%M-%S'`
img_file=image-v-${ts}.img
sudo su -c "dd bs=4M if=/dev/mmcblk0 of=$img_file"
sudo perl resize.pl `pwd`/$img_file
