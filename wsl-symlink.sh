#!/bin/bash

read -p "enter the windows username: " windows_username

ln -s /mnt/c/Users/$windows_username ./winhome
ln -s /mnt/c/Users/$windows_username/curseforge/minecraft/Instances ./mcinstances