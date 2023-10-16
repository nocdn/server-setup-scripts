#!/bin/bash

# install prerequisites:
sudo apt install -y wget apt-transport-https gpg

# add Adoptium GPG key and repository:
sudo wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

# update package list and install Temurin 17 JRE:
sudo apt update
sudo apt install temurin-17-jre -y