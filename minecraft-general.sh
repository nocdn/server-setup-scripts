#!/bin/bash

# update sudo:
sudo apt update -y
sudo apt upgrade -y

# install packages:
sudo apt install -y curl neofetch unzip zip jq awscli

# installing adoptium 17 jre:
sudo apt install -y wget apt-transport-https gpg
sudo wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
sudo echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

sudo apt update
sudo apt install temurin-17-jre -y

# configure aws cli:
aws configure

# download the backup and restore scripts:

# getting the user's home directory to save into:
HOME_DIR=$(eval echo ~${SUDO_USER})
USER_NAME=${SUDO_USER:-$USER}

curl -o "${HOME_DIR}/backup.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/backup.sh
curl -o "${HOME_DIR}/secondaryBackup.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/secondaryBackup.sh
curl -o "${HOME_DIR}/restore.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/restore.sh
curl -o "${HOME_DIR}/modpack-download.sh" https://raw.githubusercontent.com/Kayetic/server-setup-scripts/main/modpack-download.sh
chmod +x "${HOME_DIR}/backup.sh"
chmod +x "${HOME_DIR}/secondaryBackup.sh"
chmod +x "${HOME_DIR}/restore.sh"
chmod +x "${HOME_DIR}/modpack-download.sh"

# change ownership of the downloaded scripts to the user
chown ${USER_NAME}:${USER_NAME} "${HOME_DIR}/backup.sh"
chown ${USER_NAME}:${USER_NAME} "${HOME_DIR}/secondaryBackup.sh"
chown ${USER_NAME}:${USER_NAME} "${HOME_DIR}/restore.sh"
chown ${USER_NAME}:${USER_NAME} "${HOME_DIR}/modpack-download.sh"

echo "Java version:"
java --version