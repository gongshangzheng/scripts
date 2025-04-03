#!/bin/bash
sudo pacman -S bluez bluez-utils blueman
sudo systemctl enable --now bluetooth.service
