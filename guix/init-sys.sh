#!/usr/bin/env sh

sudo keyd &
xhost +SI:localuser:xinyu
keyd-application-mapper -d
sudo chmod a+w /var/run/keyd.socket
sudo chmod a+r /var/run/keyd.socket
